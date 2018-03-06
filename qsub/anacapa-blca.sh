#! /bin/bash
#$ -S /bin/bash
#$ -q std.q
#$ -cwd
#$ -N anacapa-co1-mock-blca
#$ -j y
#$ -o anacapa-co1-mock-blca-out.qlog
#$ -e anacapa-co1-mock-blca-err.qlog
#$ -l mem_free=48G
#$ -pe smp 1
#$ -V

/opt/singularity-2.4.2/bin/singularity exec -B /act /home/mogden2/anacapa-1.0.0.img /bin/bash -c "time /home/mogden2/Anacapa-git/Anacapa_db/anacapa_bowtie2_blca.sh -o /home/mogden2/results-mock -d /home/mogden2/Anacapa-git/Anacapa_db -u mogden2"