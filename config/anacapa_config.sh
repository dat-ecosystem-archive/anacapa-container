######
# This config is for the Anacapa Dat Container
# github.com/datproject/anacapa-container
# Should be in Anacapa_db/scripts folder
######

MODULE_SOURCE=""
FASTX_TOOLKIT=""
ANACONDA_PYTHON=""
BOWTIE2=""
ATS=""
R=""
PYTHONWNUMPY=""
GCC=""

CUTADAPT="/usr/local/anacapa/miniconda/bin/cutadapt"
MUSCLE="/usr/local/bin/muscle"
RUNNER="/bin/bash"
QUEUESUBMIT="qsub"
export PATH="/usr/local/anacapa/miniconda/bin:$PATH"

# To use HPC mode:
# RUNNER="/path/to/singularity exec anacapa.img /bin/bash"
# QUEUESUBMIT="ssh $HOSTNAME qsub" (or sbatch)
