#!/bin/bash
# example of setting up the Anacapa_db folder
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
