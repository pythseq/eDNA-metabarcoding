#install conda
cd ./Users/franck/Downloads/
bash Anaconda3-2020.07-MacOSX-x86_64.sh
#fermeture du logiciel
conda config --set auto_activate_base false
conda --help

#creer nouvel environnement obitools
#ENVYAML=/Users/franck/Projects/installation_obitools/installation_obitools/environnements/obitools_env_conda.yaml
ENVYAML=/home/bmace/Documents/projets/beginning_obitools/environnements/obitools_env_conda.yaml
conda env create -f $ENVYAML
## To activate this environment, use
#     $ conda activate obitools
# To deactivate an active environment, use
#     $ conda deactivate
#Test des commandes

#Supprimer un environnement
conda env remove --name obitools
