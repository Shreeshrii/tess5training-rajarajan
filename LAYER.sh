#!/bin/bash
STARTMODEL=tam
LANG=tam
PREFIX=layer
TRAINDIR=$PREFIX-$LANG-from-$STARTMODEL

cd ./tesseract

### cp -v ~/tessdata_best/tam.traineddata ../tessdata/best/$STARTMODEL.traineddata 

echo "-----------------------------------------------------------------------------------------------------------------"

###### rm -rf ../training/$TRAINDIR
mkdir -p ../training/$TRAINDIR

echo -e "\n***** Extract LSTM model from best traineddata for $STARTMODEL. \n"
combine_tessdata -u ../tessdata/best/$STARTMODEL.traineddata ../training/$TRAINDIR/$STARTMODEL.

echo "-----------------------------------------------------------------------------------------------------------------"
lstmtraining --debug_interval -1 \
  --continue_from ../training/$TRAINDIR/$STARTMODEL.lstm \
  --append_index 5 --net_spec '[Lfx128 O1c1]' \
  --traineddata ../training/$LANG/$LANG.traineddata\
  --model_output ../training/$TRAINDIR/$LANG \
  --train_listfile ../training/list.train \
  --eval_listfile ../training/list.eval \
  --max_iterations 5000000


