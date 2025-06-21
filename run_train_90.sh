#!/bin/bash

echo "=== VGG16 CIFAR-10 Training (Function 90) ==="

# Create necessary directories
mkdir -p nn/Pygeon/models/trained
mkdir -p nn/Pygeon/data/datasets

# Set environment variables for training
export MODEL_DIR="nn/Pygeon/models/trained"
export DATA_DIR="nn/Pygeon/data/datasets"
export MODEL_FILE="vgg16_cifar_initial.bin"
export SAMPLES_FILE="CIFAR-10_custom_train_images.bin"
export LABELS_FILE="CIFAR-10_custom_train_labels.bin"

echo "Compiling all parties for training..."

# Compile all parties
echo "Compiling P0 (Model Owner)..."
make -j PARTY=0 FUNCTION_IDENTIFIER=90 PROTOCOL=5 MODELOWNER=P_0 DATAOWNER=P_1 NUM_INPUTS=40 BITLENGTH=32 DATTYPE=32

echo "Compiling P1 (Data Owner)..."
make -j PARTY=1 FUNCTION_IDENTIFIER=90 PROTOCOL=5 MODELOWNER=P_0 DATAOWNER=P_1 NUM_INPUTS=40 BITLENGTH=32 DATTYPE=32

echo "Compiling P2 (Helper Party)..."
make -j PARTY=2 FUNCTION_IDENTIFIER=90 PROTOCOL=5 MODELOWNER=P_0 DATAOWNER=P_1 NUM_INPUTS=40 BITLENGTH=32 DATTYPE=32

echo "Compilation completed!"
echo ""
echo "=== Running Instructions ==="
echo "Open 3 separate terminals and run:"
echo ""
echo "Terminal 1 (Model Owner P0):"
echo "  ./executables/run-P0.o"
echo ""
echo "Terminal 2 (Data Owner P1):"
echo "  ./executables/run-P1.o"
echo ""
echo "Terminal 3 (Helper Party P2):"
echo "  ./executables/run-P2.o"
echo ""
echo "Make sure all parties are running simultaneously for the protocol to work." 