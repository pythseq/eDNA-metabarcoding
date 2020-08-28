#Commandes utiles pour visualiser le fichier

#ls pour voir la liste des fichiers dans ce repertoire
ls wolf_tutorial/

#less : celui qui affiche le plus dans une interface (avec wildcard)
less wolf_tutorial/*txt

#ls -l -h(human) :verifier le detail sur le fichier (droit d'utilisation / taille / date de creation')
ls -l -h wolf_tutorial

#more : affiche directement dans le terminal le fichier (sans wildcard)
more wolf_tutorial/wolf_diet_ngsfilter.txt

#commande pour compter les mots, les lignes, les caracteres : wc (word count)
wc wolf_tutorial/*

#que les lignes
wc -l wolf_tutorial/*

#exercice application : envoyer le nombre de ligne sur fichier txt
wc -l wolf_tutorial/* > wolf_nb_row.txt

#ouvrir le fichier avec more ou less
less wolf_nb_row.txt

#commande pipe : | (rediriger output vers input) on peut combiner les fonctions
#compter le nb de fichiers dans un dossier
ls wolf_tutorial/ | wc -w > wolf_nb_fichiers.txt