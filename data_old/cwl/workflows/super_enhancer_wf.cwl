cwlVersion: v1.0
class: Workflow


requirements:
  - class: StepInputExpressionRequirement
  - class: InlineJavascriptRequirement
  - class: MultipleInputFeatureRequirement


inputs:

  islands_file:
    type: File
    label: "Input peaks file"
    format: "http://edamontology.org/format_3468"
    doc: "Input XLS file generated by MACS2"

  islands_control_file:
    type: File?
    label: "Control peaks file"
    format: "http://edamontology.org/format_3468"
    doc: "Control XLS file generated by MACS2"

  bambai_pair:
    type: File
    secondaryFiles:
    - .bai
    label: "Coordinate sorted BAM+BAI files"
    format: "http://edamontology.org/format_2572"
    doc: "Coordinate sorted BAM file and BAI index file"

  annotation_file:
    type: File
    label: "TSV annotation file"
    format: "http://edamontology.org/format_3475"
    doc: "TSV annotation file"

  chrom_length_file:
    type: File
    label: "Chromosome length file"
    format: "http://edamontology.org/format_2330"
    doc: "Chromosome length file"

  stitch_distance:
    type: int
    label: "Stitching distance"
    doc: "Linking distance for stitching"

  tss_distance:
    type: int
    label: "TSS distance"
    doc: "Distance from TSS to exclude, 0 = no TSS exclusion"

  promoter_bp:
    type: int
    label: "Promoter distance"
    doc: "Promoter distance for gene names assignment"


outputs:

  png_file:
    type: File
    label: "ROSE visualization plot"
    format: "http://edamontology.org/format_3603"
    doc: "Generated by ROSE visualization plot"
    outputSource: rename_png/target_file

  gene_names_file:
    type: File
    label: "Gateway Super Enhancer + gene names"
    format: "http://edamontology.org/format_3475"
    doc: "Gateway Super Enhancer results from ROSE with assigned gene names"
    outputSource: add_island_names/output_file

  bigbed_file:
    type: File
    label: "Gateway Super Enhancer bigBed file"
    format: "http://edamontology.org/format_3475"
    doc: "Gateway Super Enhancer bigBed file"
    outputSource: bed_to_bigbed/bigbed_file


steps:

  make_gff:
    in:
      islands_file: islands_file
      islands_control_file: islands_control_file
    out: [gff_file]
    run:
      cwlVersion: v1.0
      class: CommandLineTool
      requirements:
      - class: DockerRequirement
        dockerPull: biowardrobe2/rose:v0.0.2
      inputs:
        islands_file:
          type: File
          inputBinding:
            position: 5
          doc: Input XLS file generated by MACS2
        islands_control_file:
          type: File?
          inputBinding:
            position: 7
          doc: Control XLS file generated by MACS2
      outputs:
        gff_file:
          type: File
          outputBinding:
            glob: "*"
      baseCommand: ['makegff']
      arguments:
      - valueFrom:
          ${
            let root = inputs.islands_file.basename.split('.').slice(0,-1).join('.');
            return (root == "")?inputs.islands_file.basename+".gff":root+".gff";
          }
        position: 6
      doc: Tool produces GFF file from XLS file generated by MACS2

  run_rose:
    in:
      binding_sites_file: make_gff/gff_file
      bam_file: bambai_pair
      annotation_file: annotation_file
      stitch_distance: stitch_distance
      tss_distance: tss_distance
    out: [plot_points_pic, gateway_super_enhancers_bed]
    run:
      cwlVersion: v1.0
      class: CommandLineTool
      requirements:
      - class: DockerRequirement
        dockerPull: biowardrobe2/rose:v0.0.2
      inputs:
        binding_sites_file:
          type: File
          inputBinding:
            position: 5
            prefix: "-i"
          doc: GFF file of binding sites used to make enhancers
        bam_file:
          type: File
          inputBinding:
            position: 6
            prefix: "-r"
          secondaryFiles: [".bai"]
          doc: Indexed BAM+BAI file to rank enhancer by
        annotation_file:
          type: File
          inputBinding:
            position: 7
            prefix: "-g"
          doc: TSV genome annotation file
        stitch_distance:
          type: int
          inputBinding:
            position: 8
            prefix: "-s"
          doc: Linking distance for stitching
        tss_distance:
          type: int
          inputBinding:
            position: 9
            prefix: "-t"
          doc: Distance from TSS to exclude. 0 = no TSS exclusion
      outputs:
        plot_points_pic:
          type: File
          outputBinding:
            glob: "*Plot_points.png"
        gateway_super_enhancers_bed:
          type: File
          outputBinding:
            glob: "*Gateway_SuperEnhancers.bed"
      baseCommand: ['ROSE_main', '-o', './']
      doc: Tool runs ROSE to get Super Enhancers regions

  rename_png:
    in:
      source_file: run_rose/plot_points_pic
      target_filename:
        source: bambai_pair
        valueFrom: $(self.location.split('/').slice(-1)[0].split('.').slice(0,-1).join('.')+"_default_s_enhcr.png")
    out: [target_file]
    run:
      cwlVersion: v1.0
      class: CommandLineTool
      requirements:
      - class: DockerRequirement
        dockerPull: biowardrobe2/scidap:v0.0.3
      inputs:
        source_file:
          type: File
          inputBinding:
            position: 5
          doc: source file to rename
        target_filename:
          type: string
          inputBinding:
            position: 6
          doc: filename to rename to
      outputs:
        target_file:
          type: File
          outputBinding:
            glob: "*"
      baseCommand: ["cp"]
      doc: Tool renames (copy) `source_file` to `target_filename`

  sort_bed:
    in:
      unsorted_file: run_rose/gateway_super_enhancers_bed
      key:
        default: ["1,1","2,2n","3,3n"]
    out: [sorted_file]
    run:
      cwlVersion: v1.0
      class: CommandLineTool
      requirements:
      - class: InlineJavascriptRequirement
      - class: DockerRequirement
        dockerPull: biowardrobe2/scidap:v0.0.3
      inputs:
        key:
          type:
            type: array
            items: string
            inputBinding:
              prefix: "-k"
          inputBinding:
            position: 5
          doc: -k, --key=POS1[,POS2], start a key at POS1, end it at POS2 (origin 1)
        unsorted_file:
          type: File
          inputBinding:
            position: 6
          doc: File to be sorted
      outputs:
        sorted_file:
          type: File
          outputBinding:
            glob: "*"
      stdout: $(inputs.unsorted_file.location.split('/').slice(-1)[0])
      baseCommand: ["sort"]
      doc: Tool sorts data from `unsorted_file` by `key`

  reduce_bed:
    in:
      input_file: sort_bed/sorted_file
    out: [output_file]
    run:
      cwlVersion: v1.0
      class: CommandLineTool
      requirements:
      - class: DockerRequirement
        dockerPull: biowardrobe2/scidap:v0.0.3
      inputs:
        input_file:
          type: File
          inputBinding:
            position: 5
          doc: Input BED6 file to be reduced to BED4
      outputs:
        output_file:
          type: File
          outputBinding:
            glob: "*"
      baseCommand: [bash, '-c']
      arguments:
      - cat $0 | cut -f 1-4 > `basename $0`
      doc: Tool converts BED6 to BED4 by reducing column numbers

  bed_to_bigbed:
    in:
      input_bed: reduce_bed/output_file
      chrom_length_file: chrom_length_file
      bed_type:
        default: "bed4"
      output_filename:
        source: bambai_pair
        valueFrom: $(self.location.split('/').slice(-1)[0].split('.').slice(0,-1).join('.')+"_default_s_enhcr.bb")
    out: [bigbed_file]
    run:
      cwlVersion: v1.0
      class: CommandLineTool
      requirements:
      - class: DockerRequirement
        dockerPull: biowardrobe2/ucscuserapps:v358
      inputs:
        bed_type:
          type: string
          inputBinding:
            position: 5
            prefix: -type=
            separate: false
          doc: Type of BED file in a form of bedN[+[P]]. By default bed3 to three required BED fields
        input_bed:
          type: File
          inputBinding:
            position: 6
          doc: Input BED file
        chrom_length_file:
          type: File
          inputBinding:
            position: 7
          doc: Chromosome length files
        output_filename:
          type: string
          inputBinding:
            position: 8
          doc: Output filename
      outputs:
        bigbed_file:
          type: File
          outputBinding:
            glob: "*"
      baseCommand: ["bedToBigBed"]
      doc: Tool converts bed to bigBed

  bed_to_macs:
    in:
      input_file: sort_bed/sorted_file
    out: [output_file]
    run:
      cwlVersion: v1.0
      class: CommandLineTool
      requirements:
      - class: DockerRequirement
        dockerPull: biowardrobe2/scidap:v0.0.3
      inputs:
        input_file:
          type: File
          inputBinding:
            position: 5
          doc: Input file to be converted to MACS2 output format
      outputs:
        output_file:
          type: File
          outputBinding:
            glob: "*"
      baseCommand: [bash, '-c']
      arguments:
      - cat $0 | grep -v "#" | awk
        'BEGIN {print "chr\tstart\tend\tlength\tabs_summit\tpileup\t-log10(pvalue)\tfold_enrichment\t-log10(qvalue)\tname"}
        {print $1"\t"$2"\t"$3"\t"$3-$2+1"\t0\t0\t0\t0\t0\t"$4}' > `basename $0`
      doc: Tool converts `input_file` to the format compatible with the input of iaintersect from `assign_genes` step

  assign_genes:
    in:
      input_filename: bed_to_macs/output_file
      annotation_filename: annotation_file
      promoter_bp: promoter_bp
    out: [result_file]
    run:
      cwlVersion: v1.0
      class: CommandLineTool
      requirements:
      - class: InlineJavascriptRequirement
      - class: DockerRequirement
        dockerPull: biowardrobe2/iaintersect:v0.0.2
      inputs:
        input_filename:
          type: File
          inputBinding:
            prefix: --in=
            separate: false
          doc: Input filename with MACS2 peak calling results, tsv
        annotation_filename:
          type: File
          inputBinding:
            prefix: --a=
            separate: false
          doc: Annotation file, tsv
        promoter_bp:
          type: int
          inputBinding:
            prefix: --promoter=
            separate: false
          doc: Promoter region around TSS, base pairs
      outputs:
        result_file:
          type: File
          outputBinding:
            glob: "*_iaintersect.tsv"
      baseCommand: [iaintersect]
      arguments:
      - valueFrom: |
          ${
            let root = inputs.input_filename.basename.split('.').slice(0,-1).join('.');
            return (root == "")?inputs.input_filename.basename+"_iaintersect.tsv":root+"_iaintersect.tsv";
          }
        prefix: --out=
        separate: false
      doc: Tool assigns each peak obtained from MACS2 to a gene and region (upstream, promoter, exon, intron, intergenic)

  add_island_names:
    in:
      input_file: [assign_genes/result_file, sort_bed/sorted_file]
      param:
        source: bambai_pair
        valueFrom: $(self.location.split('/').slice(-1)[0].split('.').slice(0,-1).join('.')+"_default_s_enhcr.tsv")
    out: [output_file]
    run:
      cwlVersion: v1.0
      class: CommandLineTool
      requirements:
      - class: DockerRequirement
        dockerPull: biowardrobe2/scidap:v0.0.3
      inputs:
        input_file:
          type: File[]
          inputBinding:
            position: 5
          doc: TSV file to add extra columns too
        param:
          type: string
          inputBinding:
            position: 6
          doc: Param to set output filename
      outputs:
        output_file:
          type: File
          outputBinding:
            glob: "*"
      baseCommand: [bash, '-c']
      arguments:
      - echo -e "refseq_id\tgene_id\ttxStart\ttxEnd\tstrand\tchrom\tstart\tend\tlength\tregion\tname\tscore" > `basename $2`;
        cat $0 | grep -v refseq_id | paste - $1 | cut -f 1-9,15,19,20 >> `basename $2`

$namespaces:
  s: http://schema.org/

$schemas:
- http://schema.org/docs/schema_org_rdfa.html

s:name: "super-enhancer"
s:downloadUrl: https://raw.githubusercontent.com/michael-kotliar/biowardrobe-airflow-plugins/cwls/super-enhancer.cwl
s:codeRepository: https://github.com/michael-kotliar/biowardrobe-airflow-plugins
s:license: http://www.apache.org/licenses/LICENSE-2.0

s:isPartOf:
  class: s:CreativeWork
  s:name: Common Workflow Language
  s:url: http://commonwl.org/

s:creator:
- class: s:Organization
  s:legalName: "Cincinnati Children's Hospital Medical Center"
  s:location:
  - class: s:PostalAddress
    s:addressCountry: "USA"
    s:addressLocality: "Cincinnati"
    s:addressRegion: "OH"
    s:postalCode: "45229"
    s:streetAddress: "3333 Burnet Ave"
    s:telephone: "+1(513)636-4200"
  s:logo: "https://www.cincinnatichildrens.org/-/media/cincinnati%20childrens/global%20shared/childrens-logo-new.png"
  s:department:
  - class: s:Organization
    s:legalName: "Allergy and Immunology"
    s:department:
    - class: s:Organization
      s:legalName: "Barski Research Lab"
      s:member:
      - class: s:Person
        s:name: Michael Kotliar
        s:email: mailto:misha.kotliar@gmail.com
        s:sameAs:
        - id: http://orcid.org/0000-0002-6486-3898

doc: |
  Workflow to run Super Enhancer Analysis

s:about: |
  Workflow to run Super Enhancer Analysis