#!/bin/bash
# bash -x test.sh Grantha1_fast scannedlines

lang=$1
whichdir=$2
PSM=6
cd images/$whichdir/
my_files=$(ls */*{*.jpg,*.tif,*.png,*.jp2})
    rm  -v *ALL*$lang*.txt 
    for my_file in ${my_files}; do
            echo -e "\n ***** "  $my_file "LANG" $lang  $PSM "****"
            OMP_THREAD_LIMIT=1 time -p tesseract $my_file  "${my_file%.*}-$lang-tmp" --oem 1 --psm $PSM -l "$lang"  --dpi 300 --tessdata-dir ~/tess4training-grantha/tessdata/finetuned -c preserve_interword_spaces=1 -c page_separator='' -c paragraph_text_based=false -c tessedit_do_invert=0
            ## accuracy   "${my_file%.*}".gt.txt   "${my_file%.*}-$lang-tmp".txt  >   "${my_file%.*}-$lang"-accuracy.txt
            cat "${my_file%.*}-$lang-tmp".txt >> ALL-$lang.txt
            cat "${my_file%.*}".gt.txt >>  ALL-$lang-gt.txt
    done
    accuracy  ALL-$lang-gt.txt  ALL-$lang.txt  >  accuracy-ALL-$lang.txt
    wordacc  ALL-$lang-gt.txt  ALL-$lang.txt  >  wordacc-ALL-$lang.txt
echo "DONE with my_files"
rm */*-tmp.txt
