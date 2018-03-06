#! /bin/bash
#$ -S /bin/bash
#$ -q std.q
#$ -cwd
#$ -N anacapa-co1-mock
#$ -j y
#$ -o anacapa-co1-mock-out.qlog
#$ -e anacapa-co1-mock-err.qlog
#$ -l mem_free=48G
#$ -pe smp 1
#$ -V

time /opt/singularity-2.4.2/bin/singularity exec -B /act /home/mogden2/anacapa-1.0.0.img /bin/bash -c "time /home/mogden2/Anacapa-git/Anacapa_db/anacapa_QC_dada2.sh -i /home/mogden2/Mock_CO1_Leray_Knowlton/CO1_Leray_and_Knowlton_fastq-2x300 -o /home/mogden2/results-mock -d /home/mogden2/Anacapa-git/Anacapa_db -f /home/mogden2/Mock_CO1_Leray_Knowlton/forward_CO1_p.txt -r /home/mogden2/Mock_CO1_Leray_Knowlton/reverse_CO1_p.txt -a nextera -t MiSeq"