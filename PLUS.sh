#!/bin/bash
STARTMODEL=RajaRajanOne
LANG=tam
PREFIX=plus
TRAINDIR=$PREFIX-$LANG-from-$STARTMODEL

cd ./tesseract

echo "-----------------------------------------------------------------------------------------------------------------"

mkdir -p ../training/$TRAINDIR

echo -e "\n***** Extract LSTM model from best traineddata for $STARTMODEL. \n"
combine_tessdata -u ../tessdata/best/$STARTMODEL.traineddata ../training/$TRAINDIR/$STARTMODEL.

echo "-----------------------------------------------------------------------------------------------------------------"
lstmtraining --debug_interval -1 \
  --continue_from ../training/$TRAINDIR/$STARTMODEL.lstm \
   --old_traineddata  ../tessdata/best/$STARTMODEL.traineddata  \
  --traineddata ../training/$LANG/$LANG.traineddata\
  --model_output ../training/$TRAINDIR/$LANG \
  --train_listfile ../training/list.train \
  --eval_listfile ../training/list.eval \
  --max_iterations 50000


