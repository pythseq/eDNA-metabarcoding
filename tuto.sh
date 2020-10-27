# assemble pairedend read
illuminapairedend --score-min=40 -r wolf_tutorial/wolf_R.fastq wolf_tutorial/wolf_F.fastq > wolf.fastq

# keep only correct assembly
obigrep -p 'mode!="joined"' wolf.fastq > wolf.ali.fastq

# demultiplexing
ngsfilter -t wolf_tutorial/wolf_diet_ngsfilter.txt -u unidentified.fastq wolf.ali.fastq > wolf.ali.assigned.fastq

# dereplicate
obiuniq -m sample wolf.ali.assigned.fastq > wolf.ali.assigned.uniq.fasta

# remove useless annotation
obiannotate -k count -k merged_sample \
  wolf.ali.assigned.uniq.fasta > $$ ; mv $$ wolf.ali.assigned.uniq.fasta

# keep sequences larger than 80bp and with depth coverage greater than 9 reads
obigrep -l 80 -p 'count>=10' wolf.ali.assigned.uniq.fasta \
    > wolf.ali.assigned.uniq.c10.l80.fasta

# Denoising / Clustering
obiclean -s merged_sample -r 0.05 -H \
  wolf.ali.assigned.uniq.c10.l80.fasta > wolf.ali.assigned.uniq.c10.l80.clean.fasta

# Taxonomic assignment
ecotag -d wolf_tutorial/embl_r117 -R wolf_tutorial/db_v05_r117.fasta wolf.ali.assigned.uniq.c10.l80.clean.fasta > \
  wolf.ali.assigned.uniq.c10.l80.clean.tag.fasta

# Format
obiannotate  --delete-tag=scientific_name_by_db --delete-tag=obiclean_samplecount \
  --delete-tag=obiclean_count --delete-tag=obiclean_singletoncount \
  --delete-tag=obiclean_cluster --delete-tag=obiclean_internalcount \
  --delete-tag=obiclean_head --delete-tag=taxid_by_db --delete-tag=obiclean_headcount \
  --delete-tag=id_status --delete-tag=rank_by_db --delete-tag=order_name \
  --delete-tag=order wolf.ali.assigned.uniq.c10.l80.clean.tag.fasta > \
  wolf.ali.assigned.uniq.c10.l80.clean.tag.ann.fasta

#sort
obisort -k count -r wolf.ali.assigned.uniq.c10.l80.clean.tag.ann.fasta >  \
  wolf.ali.assigned.uniq.c10.l80.clean.tag.ann.sort.fasta

#convert fasta into table
obitab -o wolf.ali.assigned.uniq.c10.l80.clean.tag.ann.sort.fasta > \
  wolf.ali.assigned.uniq.c10.l80.clean.tag.ann.sort.tab