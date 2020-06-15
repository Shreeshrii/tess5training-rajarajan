# tess5training-rajarajan
Tesseract lstm  training for Udhayam Rajarajan font for Tamil

You ned to have Tesseract 4+ (preferably latest version from Github master branch) installed along wih the Tesseract Training Tools. These instructions are for training on Linux.

## How to run training?

Follow the steps given below. It is recommended to check the output files after each step. Run next step only after completion of earlier step.
You can view [this colab notebook](https://colab.research.google.com/drive/1hgWfQB081CBrdTV_0KT2sRwEcmOXofpE?usp=sharing) for details.
```
git clone https://github.com/Shreeshrii/tess5training-rajarajan
cd tess5training-rajarajan
# Generate box/tif pairs and lstmf files from training text and font.
bash makedata.sh
# Generate list of lstmf files, generate unicharset from box files and the starter traineddata file.
bash makeALL.sh
# Run lstmtraining for replace the top layer training
bash LAYER.sh
# Run lstmeval to evaluate latest checkpoint
bash LAYEReval.sh
```

### fonts directory
*  Udhayam_Rajarajan.ttf file

### langdata directory
* files from tesseract-OCR/langdata_lstm
* Tamil and Latin scripts
* tam language files
* training, evaluation and test texts

### tessdata directory
* eng and osd traineddata 
* config files
* tessdata/best
* tessdata/finetuned

### tesseract
* tesstrain.sh training script

### training 
* generated files
* startmodel info
* training data folders with box, tif and lstm for files
* training folder with checkpoints

## training process

* bash makedata.sh
This will create 'train', 'eval' and 'test' folders under 'training' with box, tif and lstmf files from the training text and font.

* bash makeALL.sh
This will create the list of lstmf files to be used for training. It will also create the starter traineddata using the unicharset generated from the box files.

* bash LAYER.sh
This runs replace top layer training for tesseract using 'tam' as the startmodel and the training data generated earlier, using a new partial network spec for the new top layer along with original spec from startmodel. The script is setup to display debug information for every iteration.
Training will start with about 400% CER, it will come down to 100% in about 1000 iterations and detailed checkpoints will start getting written after CER goes below around 7000 iterations. Training slows down after it reaches 10% CER and further slows after 1%. Training may run for a few days to reach good accuracy levels. (These numbers may vary based on the training text as also the hardware where the training is being run). 
