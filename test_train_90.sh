#!/bin/bash

echo "Testing VGG16 CIFAR-10 Training (Function 90)"

# Create necessary directories
mkdir -p nn/Pygeon/models/trained
mkdir -p nn/Pygeon/data/datasets

# Set environment variables for training
export MODEL_DIR="nn/Pygeon/models/trained"
export DATA_DIR="nn/Pygeon/data/datasets"
export MODEL_FILE="vgg16_cifar_initial.bin"
export SAMPLES_FILE="CIFAR-10_custom_train_images.bin"
export LABELS_FILE="CIFAR-10_custom_train_labels.bin"

echo "Compiling training executable with Function 90..."

# Compile training executable (P0 as model owner, P1 as data owner)
make -j PARTY=0 FUNCTION_IDENTIFIER=90 PROTOCOL=5 MODELOWNER=P_0 DATAOWNER=P_1 NUM_INPUTS=40 BITLENGTH=32 DATTYPE=32

echo "Compilation completed!"

echo "To run the training, use:"
echo "./executables/run-P0.o"
echo ""
echo "Make sure to run all parties (P0, P1, P2) in separate terminals:"
echo "Terminal 1: ./executables/run-P0.o"
echo "Terminal 2: ./executables/run-P1.o" 
echo "Terminal 3: ./executables/run-P2.o" 