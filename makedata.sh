#!/bin/bash
cd ./tesseract
lang=tam
LANG=tam
FONTSDIR=../fonts

 for PREFIX in  test  ; do
 
 echo -e "$PREFIX -----------------------------------------------------------------------------------------------------------------"
 
 rm -rf  ../training/${PREFIX}
 
 echo -e "\n***** Making training data for ${PREFIX} set for $LANG training."
 
 python3 ../normalize.py -v ../langdata/$LANG/${PREFIX}.training_text
 
 bash src/training/tesstrain.sh \
 --fonts_dir $FONTSDIR \
 --lang $lang \
 --linedata_only \
 --noextract_font_properties \
 --langdata_dir ../langdata \
 --training_text ../langdata/$LANG/${PREFIX}.training_text \
 --tessdata_dir ../tessdata \
 --output_dir ../training/${PREFIX} \
 --save_box_tiff \
 --distort_image \
 --exposures   "2 3" \
 --maxpages 0 \
 --fontlist \
 "Udhayam_Rajarajan" 
 
 echo "-----------------------------------------------------------------------------------------------------------------"
 done
 
 for PREFIX in  eval  ; do
 
 echo -e "$PREFIX -----------------------------------------------------------------------------------------------------------------"
 
 rm -rf  ../training/${PREFIX}
 
 echo -e "\n***** Making training data for ${PREFIX} set for $LANG training."
 
 python3 ../normalize.py -v ../langdata/$LANG/${PREFIX}.training_text
 
 bash src/training/tesstrain.sh \
 --fonts_dir $FONTSDIR \
 --lang $lang \
 --linedata_only \
 --noextract_font_properties \
 --langdata_dir ../langdata \
 --training_text ../langdata/$LANG/${PREFIX}.training_text \
 --tessdata_dir ../tessdata \
 --output_dir ../training/${PREFIX} \
 --save_box_tiff \
 --exposures   "2 3" \
 --maxpages 0 \
 --fontlist \
 "Udhayam_Rajarajan" 
 
 echo "-----------------------------------------------------------------------------------------------------------------"
 done
 

for PREFIX in  train  ; do

echo -e "$PREFIX -----------------------------------------------------------------------------------------------------------------"

rm -rf  ../training/${PREFIX}
rm -rf  ../training/${PREFIX}-distort

echo -e "\n***** Making training data for ${PREFIX} set for $LANG training."

python3 ../normalize.py -v ../langdata/$LANG/${PREFIX}.training_text

bash src/training/tesstrain.sh \
--fonts_dir $FONTSDIR \
--lang $lang \
--linedata_only \
--noextract_font_properties \
--langdata_dir ../langdata \
--training_text ../langdata/$LANG/${PREFIX}.training_text \
--tessdata_dir ../tessdata \
--output_dir ../training/${PREFIX} \
--exposures   "2 3" \
--save_box_tiff \
--maxpages 0 \
--fontlist \
 "Udhayam_Rajarajan" 
 
echo "-----------------------------------------------------------------------------------------------------------------"

bash src/training/tesstrain.sh \
--fonts_dir $FONTSDIR \
--lang $lang \
--linedata_only \
--noextract_font_properties \
--langdata_dir ../langdata \
--training_text ../langdata/$LANG/${PREFIX}.training_text \
--tessdata_dir ../tessdata \
--output_dir ../training/${PREFIX}-distort \
--distort_image \
--save_box_tiff \
--exposures   "2 3" \
--maxpages 0 \
--fontlist \
 "Udhayam_Rajarajan" 
 
echo "-----------------------------------------------------------------------------------------------------------------"

done

echo "-----------------------------------------------------------------------------------------------------------------"

