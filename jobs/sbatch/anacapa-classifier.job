#!/bin/bash

#SBATCH --mail-user <youremail>
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH -p intel # this is the default
##SBATCH --mem=100g
#SBATCH --time=01:10:00
#SBATCH --output=/path/to/anacapa-12S-classifier-out.log
#SBATCH -e /path/to/anacapa-12S-classifier-err.log
#SBATCH --job-name=anacapa-12S-classifier
#SBATCH --export=ALL

SINGULARITY=$(which singularity)
module load singularity # may not need this on your system
BASEDIR="/home/max" # change to folder you want shared into container
CONTAINER="/home/max/anacapa-container/anacapa-1.4.0.img" # change to full container .img path
DB="/home/max/Anacapa/Anacapa_db" # change to full path to Anacapa_db
OUT="$BASEDIR/12S_time_test" # change to output data folder from QC step

cd $BASEDIR

# If you need additional folders shared into the container, add additional -B arguments below
# To run in cluster mode, remove -l below and edit anacapa_config RUNNER and QUEUESUBMIT

time singularity exec -B $BASEDIR -B $SINGULARITY $CONTAINER /bin/bash -c "$DB/anacapa_classifier.sh -o $OUT -d $DB -l"