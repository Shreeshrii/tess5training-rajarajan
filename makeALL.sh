#!/bin/bash
cd tesseract
lang=tam

ls -1 ../training/*/*.lstmf > ../training/all-lstmf

ls -1 ../training/*eval*/*.lstmf > /tmp/ALLlist.eval
shuf  /tmp/ALLlist.eval > ../training/list.eval

ls -1 ../training/*test*/*.lstmf > /tmp/ALLlist.test
shuf  /tmp/ALLlist.test > ../training/list.test

ls -1 ../training/*train*/*.lstmf >   /tmp/alllist.train
shuf /tmp/alllist.train >  ../training/list.train

#use box files for creating unicharset since font does not render all characters in training text
unicharset_extractor --output_unicharset ../training/$lang.unicharset --norm_mode 2 ../training/*/*.box

combine_lang_model --input_unicharset ../training/$lang.unicharset --script_dir ../langdata  --numbers ../langdata/$lang/$lang.numbers --puncs ../langdata/$lang/$lang.punc --output_dir ../training --lang $lang --pass_through_recoder

cd ..
