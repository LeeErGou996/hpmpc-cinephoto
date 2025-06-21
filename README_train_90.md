# VGG16 CIFAR-10 训练功能 (Function 90)

## 概述

Function 90 实现了基于多方安全计算(MPC)的VGG16神经网络在CIFAR-10数据集上的去中心化训练。

## 功能特点

- **去中心化训练**：支持三方参与（P0、P1、P2）
- **秘密共享**：数据和模型参数通过秘密共享分发
- **安全计算**：使用MPC协议保护数据隐私
- **VGG16架构**：在CIFAR-10数据集上训练VGG16模型

## 参与方角色

- **P0 (Model Owner)**：拥有模型参数，负责保存训练后的模型
- **P1 (Data Owner)**：拥有训练数据，提供CIFAR-10训练样本
- **P2 (Helper Party)**：协助计算，不拥有数据或模型

## 使用方法

### 1. 编译所有参与方

```bash
# 运行编译脚本
chmod +x run_train_90.sh
./run_train_90.sh
```

或者手动编译：

```bash
# 编译P0 (Model Owner)
make -j PARTY=0 FUNCTION_IDENTIFIER=90 PROTOCOL=5 MODELOWNER=P_0 DATAOWNER=P_1 NUM_INPUTS=40 BITLENGTH=32 DATTYPE=32

# 编译P1 (Data Owner)
make -j PARTY=1 FUNCTION_IDENTIFIER=90 PROTOCOL=5 MODELOWNER=P_0 DATAOWNER=P_1 NUM_INPUTS=40 BITLENGTH=32 DATTYPE=32

# 编译P2 (Helper Party)
make -j PARTY=2 FUNCTION_IDENTIFIER=90 PROTOCOL=5 MODELOWNER=P_0 DATAOWNER=P_1 NUM_INPUTS=40 BITLENGTH=32 DATTYPE=32
```

### 2. 运行训练

在三个不同的终端中同时运行：

**终端1 (P0 - Model Owner):**
```bash
./executables/run-P0.o
```

**终端2 (P1 - Data Owner):**
```bash
./executables/run-P1.o
```

**终端3 (P2 - Helper Party):**
```bash
./executables/run-P2.o
```

### 3. 参数说明

- `FUNCTION_IDENTIFIER=90`：指定使用训练功能
- `PROTOCOL=5`：使用协议5（3PC协议）
- `MODELOWNER=P_0`：P0作为模型拥有者
- `DATAOWNER=P_1`：P1作为数据拥有者
- `NUM_INPUTS=40`：处理40个训练样本
- `BITLENGTH=32`：使用32位精度
- `DATTYPE=32`：数据类型为32位

## 数据要求

### 训练数据文件

在 `nn/Pygeon/data/datasets/` 目录下需要以下文件：

- `CIFAR-10_custom_train_images.bin`：CIFAR-10训练图像数据
- `CIFAR-10_custom_train_labels.bin`：CIFAR-10训练标签数据

### 初始模型文件

在 `nn/Pygeon/models/trained/` 目录下需要：

- `vgg16_cifar_initial.bin`：VGG16初始权重文件

## 输出结果

训练完成后，模型将保存为：

- `nn/Pygeon/models/trained/vgg16_cifar_trained.bin`：训练后的模型权重（秘密份额格式）

## 环境变量

可以通过环境变量自定义路径：

```bash
export MODEL_DIR="path/to/model/directory"
export DATA_DIR="path/to/data/directory"
export MODEL_FILE="initial_model.bin"
export SAMPLES_FILE="train_images.bin"
export LABELS_FILE="train_labels.bin"
```

## 与推理功能的配合

训练完成后，可以使用Function 74进行推理：

```bash
# 使用训练后的模型进行推理
make -j PARTY=0 FUNCTION_IDENTIFIER=74 PROTOCOL=5 MODELOWNER=P_0 DATAOWNER=P_1 NUM_INPUTS=40 BITLENGTH=32 DATTYPE=32
```

## 注意事项

1. 确保所有参与方同时运行
2. 训练数据必须符合CIFAR-10格式（3通道，32x32像素）
3. 模型权重以秘密份额格式保存，不能直接用于明文推理
4. 训练过程使用dummy损失函数和优化器，实际应用中需要实现真实的训练算法

## 故障排除

如果遇到编译错误，请检查：
- 头文件路径是否正确
- 依赖库是否已安装
- 编译器版本是否支持C++20

如果遇到运行时错误，请检查：
- 所有参与方是否同时运行
- 数据文件是否存在且格式正确
- 网络连接是否正常 