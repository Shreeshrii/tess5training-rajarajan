#!/bin/bash
# bash -x test.sh 
lang=RajaRajanOne
PSM=6
cd test/
rm  -v *ALL*$lang*.txt  *tessinput.tif
my_files=$(ls *{*.jpg,*.tif,*.png,*.jp2})

    for my_file in ${my_files}; do
            echo -e "\n ***** "  $my_file "LANG" $lang  $PSM "****"
            OMP_THREAD_LIMIT=1 time -p tesseract $my_file  "${my_file%.*}-$lang-tmp" --oem 1 --psm $PSM -l "$lang"  --dpi 300 --tessdata-dir /home/ubuntu/tess5training-rajarajan/tessdata/best -c preserve_interword_spaces=1 -c page_separator='' -c tessedit_write_images=true
            mv tessinput.tif  ${my_file%.*}-tessinput.tif
            accuracy   "${my_file%.*}".gt.txt   "${my_file%.*}-$lang-tmp".txt  >   "${my_file%.*}-$lang"-accuracy.txt
            ##cat "${my_file%.*}-$lang-tmp".txt >> ALL-$lang.txt
            ##cat "${my_file%.*}".gt.txt >>  ALL-$lang-gt.txt
    done
    ##accuracy  ALL-$lang-gt.txt  ALL-$lang.txt  >  accuracy-ALL-$lang.txt
    ##wordacc  ALL-$lang-gt.txt  ALL-$lang.txt  >  wordacc-ALL-$lang.txt
echo "DONE with my_files"
## rm *-tmp.txt
