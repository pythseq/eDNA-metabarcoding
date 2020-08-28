#tutoriel pour anlalyser la sequence Fastq
#il faut activer l'environnement
conda activate obitools
#Recuperer les sequences Forward et Reverse
illuminapairedend --score-min=40 -r wolf_tutorial/wolf_R.fastq wolf_tutorial/wolf_F.fastq > wolf.fastq
# --score-min permet d'ecarter les sequences ayant une faible qualite d'alignement
#Supprimer les sequences non alignees
obigrep -p 'mode!="joined"' wolf.fastq > wolf.ali.fastq
#Assigner chaque sequence au marqueur ou a l'echantillon correspondant
ngsfilter -t wolf_tutorial/wolf_diet_ngsfilter.txt -u unidentified.fastq wolf.ali.fastq > \
  wolf.ali.assigned.fastq
  