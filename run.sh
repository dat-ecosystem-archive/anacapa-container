#!/bin/bash
dat clone $TAXON taxonref20171118
dat clone $DATA CO1_mock_data

find anacapa-git -name "*.sh" | xargs chmod +x
cd anacapa-git/Anacapa_db
ls ../taxonref/*_filtered* | xargs -L 1 tar xzvf
mv 12S_db_filtered_to_remove_ambigous_taxonomy 12S
mv 16S_db_filtered_to_remove_ambigous_taxonomy 16S
mv 18S_db_filtered_to_remove_ambigous_taxonomy 18S
mv FITS_db_filtered_to_remove_ambigous_taxonomy FITS
mv PITS_db_filtered_to_remove_ambigous_taxonomy PITS
mv CO1_db_filtered_to_remove_ambigous_taxonomy CO1
cp ../../gist/anacapa_config.sh scripts/

time ./anacapa-git/Anacapa_db/anacapa_QC_dada2.sh -i /root/CO1_mock_data/CO1_Leray_and_Knowlton_fastq-2x300 -o /root/results-mock -d /root/anacapa-git/Anacapa_db -f /root/CO1_mock_data/forward_CO1_p.txt -r /root/CO1_mock_data/reverse_CO1_p.txt -a nextera -t MiSeq &> qclog.txt

time ./anacapa-git/Anacapa_db/anacapa_bowtie2_blca.sh -o /root/results-mock -d /root/anacapa-git/Anacapa_db -u maxogden &> blcalog.txt
 