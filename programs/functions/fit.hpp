#pragma once
#include "../../nn/PIGEON/headers/simple_nn.h"
#include <iostream>

namespace simple_nn {

template <typename Model, typename DataLoader>
void fit(Model& model, DataLoader& train_loader, int epochs = 1) {
    for (int epoch = 0; epoch < epochs; ++epoch) {
        std::cout << "[fit] Epoch " << (epoch+1) << "/" << epochs << std::endl;
        for (int i = 0; i < train_loader.size(); ++i) {
            auto batch_X = train_loader.get_x(i);
            auto batch_Y = train_loader.get_y(i);
            model.forward(batch_X, true);         // 前向传播（注意加true）
            model.zero_grad();                    // 梯度清零
            model.loss_criterion(model.net.back()->output, batch_Y); // 损失计算
            model.backward(batch_X);              // 反向传播
            model.update_weight();                // 参数更新
        }
    }
}

} // namespace simple_nn 