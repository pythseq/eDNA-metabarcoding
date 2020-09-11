# beginning_obitools

## Introduction

OBITools are commands which can be used to analyse eDNA metabarcoding data based on sequencers using Illumina technology

## Preliminary steps

- First you need to have Anaconda 3 (2020-07) installed

If it's not the case, click on this [link](https://www.anaconda.com/products/individual/get-started) and dowload it.

Use your bash to install it :
```
bash Anaconda3-2020.07-Linux-x86_64.sh
```

Then, close your software or terminal and reopen it.
Verify conda is correctly installed. It should be here :
```
/~/anaconda3/bin/conda
```

Reopen your terminal :
```
conda config --set auto_activate_base false
```

- Create your new environment obitools in your root beginning_obitools in your corresponding path. For example :
```
ENVYAML=/home/bmace/Documents/projets/beginning_obitools/environnements/obitools_env_conda.yaml
conda env create -f $ENVYAML
```

Now you can activate your environment :
```
conda activate obitools
```
And deactivate it :
```
conda deactivate
```

- Downloads your data you want to analyse :
```
curl https://pythonhosted.org/OBITools/_downloads/wolf_tutorial.zip -o wolf_tutorial.zip
unzip wolf_tutorial.zip
```

## Step 1 : Pair-end sequencing

Activate your environment :
```
conda activate obitools
```

Make a pair-end sequencing. From your forward and reverse fastq files, this command will create a new fastq files, which will contain the pair-end sequences which their quality scores.
```
illuminapairedend --score-min=40 -r wolf_tutorial/wolf_R.fastq wolf_tutorial/wolf_F.fastq > wolf.fastq
## --score-min doessn't take into account the sequences with a low quality score (below 40 here)
```

To only conserve the pair-end sequences, eliminate the sequences which haven't been aligned :
```
obigrep -p 'mode!="joined"' wolf.fastq > wolf.ali.fastq
## -p requires a python expression
## the analigned sequences are notified with mode="joined" whereas the aligned sequences are notified mode="aligned"
## here, python create a new dataset, which only contains the sequences notified "aligned"
```

## Step 2 : Demultiplexing

The .txt file permits to assign each sequence to their sample thanks to their tag. Each tag correspond to a the reverse or forward sequences from a sample.

For the moment, the sequences in the newest dataset creates are still assigned with their tag. 
You need to remove it, in order to be able to compare the sequences next :
```
ngsfilter -t wolf_tutorial/wolf_diet_ngsfilter.txt -u unidentified.fastq wolf.ali.fastq > wolf.ali.assigned.fastq
```

Two files, containing the sequences deprived of their tag, are created :
- unidentified.fastq which contain the sequences that were not assigned with a correct tag
- wolf.ali.assigned.fastq which contain the sequences that were assigned with a correct tag, in other words, it contains only the barcode sequences
(To be able to find the sample corresponding to each sequence, you can find the tag in the header of the sequence)