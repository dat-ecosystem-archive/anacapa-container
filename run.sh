#!/bin/bash
time ./Anacapa_db/anacapa_QC_dada2.sh -i /root/CO1_mock_data/CO1_Leray_and_Knowlton_fastq-2x300 -o /root/results-mock -d /root/Anacapa_db -f /root/CO1_mock_data/forward_CO1_p.txt -r /root/CO1_mock_data/reverse_CO1_p.txt -a nextera -t MiSeq &> qclog.txt
time ./Anacapa_db/anacapa_bowtie2_blca.sh -o /root/results-mock -d /root/Anacapa_db -u maxogden &> blcalog.txt