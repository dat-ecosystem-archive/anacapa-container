# anacapa-container version of qsub templates for UC Merced. copy to Anacapa_db/scripts folder

# function templates used to generate the job files that get submitted using qsub
# if your environment needs different arguments for your job scheduling system you can change these
# example usage:
# source anacapa_qsub_templates.sh
# printf "$(DADA2_PAIRED_TEMPLATE)" > some_file

BOWTIE2_BLCA_PAIRED_TEMPLATE() {
read -d '' String <<EOF
#!/bin/bash
#$ -q std.q
#$ -cwd
#$ -l mem_free=48G
#$ -pe smp 1
#$ -N bowtie2_${j}_blca
#$ -o ${OUT}/Run_info/hoffman2/run_logs/${j}_bowtie2_blca_$JOB_ID.out
#$ -e ${OUT}/Run_info/hoffman2/run_logs/${j}_bowtie2_blca_$JOB_ID.err 

echo _BEGIN_ [run_bowtie2_blca_paired.sh]: `date`

${RUNNER} ${DB}/scripts/run_bowtie2_blca.sh  -o ${OUT} -d ${DB} -m ${j} -u ${UN}

echo _END_ [run_bowtie2_blca.sh]
EOF
echo "$String"
}

DADA2_PAIRED_TEMPLATE() {
read -d '' String <<EOF
#!/bin/bash
#$ -q std.q
#$ -cwd
#$ -l mem_free=48G
#$ -pe smp 1
#$ -N paired_${j}_dada2
#$ -o ${OUT}/Run_info/hoffman2/run_logs/${j}_paired_$JOB_ID.out
#$ -e ${OUT}/Run_info/hoffman2/run_logs/${j}_paired_$JOB_ID.err

echo _BEGIN_ [run_dada2_bowtie2_paired.sh]: `date`

${RUNNER} ${DB}/scripts/run_dada2.sh  -o ${OUT} -d ${DB} -m ${j} -t paired

echo _END_ [run_dada2_paired.sh]
EOF
echo "$String"
}

DADA2_PAIRED_F_TEMPLATE() {
read -d '' String <<EOF
#!/bin/bash
#$ -q std.q
#$ -cwd
#$ -l mem_free=48G
#$ -pe smp 1
#$ -N unpaired_F_${j}_dada2
#$ -o ${OUT}/Run_info/hoffman2/run_logs/${j}_unpaired_F_$JOB_ID.out
#$ -e ${OUT}/Run_info/hoffman2/run_logs/${j}_unpaired_F_$JOB_ID.err 

echo _BEGIN_ [run_dada2_bowtie2_unpaired_F.sh]: `date`

${RUNNER} ${DB}/scripts/run_dada2.sh  -o ${OUT} -d ${DB} -m ${j} -t forward

echo _END_ [run_dada2_unpaired_F.sh]
EOF
echo "$String"
}

DADA2_PAIRED_R_TEMPLATE() {
read -d '' String <<EOF
#!/bin/bash
#$ -q std.q
#$ -cwd
#$ -l mem_free=48G
#$ -pe smp 1
#$ -N unpaired_R_${j}_dada2
#$ -o ${OUT}/Run_info/hoffman2/run_logs/${j}_unpaired_R_$JOB_ID.out
#$ -e ${OUT}/Run_info/hoffman2/run_logs/${j}_unpaired_R_$JOB_ID.err 

echo _BEGIN_ [run_dada2_bowtie2_unpaired_R.sh]: `date`

${RUNNER} ${DB}/scripts/run_dada2.sh  -o ${OUT} -d ${DB} -m ${j} -t reverse

echo _END_ [run_dada2_unpaired_R.sh]
EOF
echo "$String"
}

BLCA_TEMPLATE() {
read -d '' String <<EOF
#!/bin/bash
#$ -q std.q
#$ -cwd
#$ -l mem_free=48G
#$ -pe smp 1
#$ -N bowtie2_${j}_blca
#$ -o ${OUT}/Run_info/hoffman2/run_logs/${j}_blca_$JOB_ID.out
#$ -e ${OUT}/Run_info/hoffman2/run_logs/${j}_blca_$JOB_ID.err 

echo _BEGIN_ [run_blca.sh]: `date`

${RUNNER} ${DB}/scripts/run_blca.sh -o ${OUT} -d ${DB} -m ${MB} -f ${str} 

echo _END_ [run_blca.sh]
EOF
echo "$String"
}