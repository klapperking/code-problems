#!/bin/bash

echo "Hello! This script helps you generate the necessary files to get working on code-wars katas quickly"
read -p "What difficulty is the kata? " katadifficulty
read -p "What is the name of the kata? " kataname

base_directory="/home/martinklapper/code/klapperking/code-problems/codewars-katas/"

# find directories to add numbering prefix
cd "$base_directory$katadifficulty"
existing_dir_count=$(find -maxdepth 1 -type d  | wc -l)
if [ "$existing_dir_count" -le 9 ]; then
  existing_dir_count="0$existing_dir_count"
fi

#create files
cd "$base_directory"
cp -r "kata-dir-template/" "$katadifficulty/$existing_dir_count-$kataname/"

#open vscode editor
code "$katadifficulty/$existing_dir_count-$kataname/."
