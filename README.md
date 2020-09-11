# beginning_obitools

**Franck Pichot, Bastien Macé, 2020**

## Introduction

[OBITools](https://git.metabarcoding.org/obitools/obitools/wikis/home) are commands written in python, which can be used to analyse eDNA metabarcoding data based on sequencers using Illumina technology.

Only those which permit to make a pair-end sequencing and to demultiplex the sequences are presented here, in the aim to use the pipeline dada2 next.

## Preliminary steps

- First you need to have Anaconda installed

If it's not the case, click on this [link](https://www.anaconda.com/products/individual/get-started) and dowload it.

Install the download :
```
bash Anaconda3-2020.07-Linux-x86_64.sh
```

Then, close your shell and reopen it.
Verify conda is correctly installed. It should be here :
```
/~/anaconda3/bin/conda
```

Reopen your terminal and write the following line :
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

- If necessary, download your data you want to analyse like in the following example :
```
curl https://pythonhosted.org/OBITools/_downloads/wolf_tutorial.zip -o wolf_tutorial.zip
unzip wolf_tutorial.zip
```

## Step 1 : Pair-end sequencing

Activate your environment :
```
conda activate obitools
```

Make a pair-end sequencing. From your forward and reverse fastq files, this command will create a new fastq file, which will contain the pair-end sequences whith their quality scores.
```
illuminapairedend --score-min=40 -r wolf_tutorial/wolf_R.fastq wolf_tutorial/wolf_F.fastq > wolf.fastq
## --score-min doessn't take into account the sequences with a low quality score (below 40 here)
```

To only conserve the pair-end sequences, eliminate the sequences which haven't been aligned :
```
obigrep -p 'mode!="joined"' wolf.fastq > wolf.ali.fastq
## -p requires a python expression
## the unaligned sequences are notified with mode="joined" whereas the aligned sequences are notified with mode="aligned"
## python create a new dataset which only contains the sequences notified "aligned"
```

## Step 2 : Demultiplexing

The .txt file permits to assign each sequence to its sample thanks to its tag. Each tag correspond to a reverse or a forward sequence from a sample.

For the moment, the sequences in the newest dataset created are still assigned with their tag. 
You need to remove it, in order to be able to compare the sequences next :
```
ngsfilter -t wolf_tutorial/wolf_diet_ngsfilter.txt -u unidentified.fastq wolf.ali.fastq > wolf.ali.assigned.fastq
```

Two files, containing the sequences deprived of their tag, are created. In this example :
- unidentified.fastq contains the sequences that were not assigned with a correct tag
- wolf.ali.assigned.fastq contains the sequences that were assigned with a correct tag, in other words, it contains only the barcode sequences
(To be able to find the sample corresponding to each sequence, you can find the tag in the header of the sequence)