#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
label: "Unaligned bam to sorted, markduped bam"
requirements:
    - class: ScatterFeatureRequirement
    - class: SubworkflowFeatureRequirement
    - class: MultipleInputFeatureRequirement

inputs:
    bams:
        type: File[]
    readgroups:
        type: string[]
    reference:
        type:
            - string
            - File
        secondaryFiles: [.fai, ^.dict, .amb, .ann, .bwt, .pac, .sa]
    final_name:
        type: string
        default: 'final.bam'
outputs:
    final_bam:
        type: File
        outputSource: index_bam/indexed_bam
        secondaryFiles: [.bai, ^.bai]
    mark_duplicates_metrics_file:
        type: File
        outputSource: mark_duplicates_and_sort/metrics_file
steps:
    align:
        scatter: [bams, readgroups]
        scatterMethod: dotproduct
        run: align_and_tag.cwl
        in:
            bam: bams
            readgroup: readgroups
            reference: reference
        out:
            [aligned_bam]
    merge:
        run: merge_bams_samtools.cwl
        in:
            bams: align/aligned_bam
            name: final_name
        out:
            [merged_bam]
    name_sort:
        run: name_sort.cwl
        in:
            bam: merge/merged_bam
        out:
            [name_sorted_bam]
    mark_duplicates_and_sort:
        run: mark_duplicates_and_sort.cwl
        in:
            bam: name_sort/name_sorted_bam
            output_name: final_name
        out:
            [sorted_bam, metrics_file]
    index_bam:
        run: index_bam.cwl
        in:
            bam: mark_duplicates_and_sort/sorted_bam
        out:
            [indexed_bam]
