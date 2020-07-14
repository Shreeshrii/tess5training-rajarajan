#!/bin/bash
STARTMODEL=tam
LANG=tam
PREFIX=layer
TRAINDIR=$PREFIX-$LANG-from-$STARTMODEL

cd ./tesseract

echo -e "\n***** Stop lstmtraining and convert to traineddata. \n"
lstmtraining \
  --stop_training \
  --continue_from ../training/$TRAINDIR/${LANG}_checkpoint \
  --append_index 5 --net_spec '[Lfx128 O1c1]' \
  --traineddata ../training/$LANG/$LANG.traineddata\
  --model_output  ../tessdata/finetuned/$TRAINDIR.traineddata

lstmtraining \
  --stop_training \
  --convert_to_int  \
  --continue_from ../training/$TRAINDIR/${LANG}_checkpoint \
  --append_index 5 --net_spec '[Lfx128 O1c1]' \
  --traineddata ../training/$LANG/$LANG.traineddata\
  --model_output  ../tessdata/finetuned/$TRAINDIR-fast.traineddata

echo -e "$LANG:best:shreeshrii:`date +%Y%m%d`:$PREFIX:from:$STARTMODEL" > $LANG.version
combine_tessdata -o ../tessdata/finetuned/$TRAINDIR.traineddata  $LANG.version

echo -e "$LANG:fast:shreeshrii:`date +%Y%m%d`:$PREFIX:from:$STARTMODEL" > $LANG-fast.version
combine_tessdata -o ../tessdata/finetuned/$TRAINDIR-fast.traineddata  $LANG-fast.version

rm  ../tessdata/finetuned/*.__tmp__

echo -e "\n***** Run lstmeval for fast $TRAINDIR on training/list.eval (scanned) set. \n"
lstmeval --model ../tessdata/finetuned/$TRAINDIR-fast.traineddata \
   --verbosity 0 \
   --eval_listfile ../training/list.eval
