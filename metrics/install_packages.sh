
cd ../
export PARENTDIR=`pwd`

##########################
### workflow languages ###
##########################

# cwltool
if [ ! -d "$PARENTDIR/packages/cwl/venv" ]; then
    echo "Installing cwltool..."
    mkdir -p $PARENTDIR/packages/cwl
    cd $PARENTDIR/packages/cwl
    python -m venv venv
    source venv/bin/activate
    pip install -q cwltool
    deactivate
fi

# wdl
if [ ! -d "$PARENTDIR/packages/wdl/venv" ]; then
    echo "Installing wdl..."
    mkdir -p $PARENTDIR/packages/wdl
    cd $PARENTDIR/packages/wdl
    python -m venv venv
    source venv/bin/activate
    pip install -q miniwdl
    deactivate
fi

### TODO NEXTFLOW


###################
### translators ###
###################

# janis
if [ ! -d "$PARENTDIR/packages/janis/venv" ]; then
    echo "Installing janis..."
    mkdir -p $PARENTDIR/packages/janis
    cd $PARENTDIR/packages/janis
    python -m venv venv 
    source venv/bin/activate
    pip install -q -U pip setuptools wheel
    pip install -q -e ../../../janis-core
    deactivate
fi

# wdl2cwl
if [ ! -d "$PARENTDIR/packages/wdl-cwl-translator/venv" ]; then
    echo "Installing wdl2cwl..."
    mkdir -p $PARENTDIR/packages
    cd $PARENTDIR/packages
    git clone https://github.com/common-workflow-lab/wdl-cwl-translator/
    cd wdl-cwl-translator
    python -m venv venv
    source venv/bin/activate
    pip install -q -U pip setuptools wheel
    pip install -q -e .
    deactivate
fi

# cwl2wdl
if [ ! -d "$PARENTDIR/packages/cwl2wdl/venv" ]; then
    echo "Installing cwl2wdl..."
    mkdir -p $PARENTDIR/packages
    cd $PARENTDIR/packages
    git clone https://github.com/adamstruck/cwl2wdl
    cd cwl2wdl
    sudo apt-add-repository universe
    sudo apt update
    sudo apt install python2-minimal
    sudo pip install virtualenv
    virtualenv --python=/usr/bin/python2.7 venv
    source venv/bin/activate
    alias pip2=pip
    pip install -q .
    pip install -q cwl-utils
    pip install -q PyYAML
    deactivate
fi

# TODO galaxy2cwl
# TODO cwl2nxf