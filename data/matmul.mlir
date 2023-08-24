func.func @matmul(%A: tensor<12x9xf32>, %B: tensor<9x6xf32>, %C: tensor<12x6xf32>) -> tensor<12x6xf32> {
  // CHECK: linalg.matmul ins(%[[A]], %[[B]] : memref<12x9xf32>, memref<9x6xf32>) outs(%[[C]] : memref<12x6xf32>)
  %D = linalg.matmul ins(%A, %B: tensor<12x9xf32>, tensor<9x6xf32>) outs(%C: tensor<12x6xf32>) -> tensor<12x6xf32>
  // CHECK: return %[[C]] : memref<12x6xf32>
  return %D : tensor<12x6xf32>
}

// module {
//   func.func @matmul(%arg0: tensor<12x9xf32>, %arg1: tensor<9x6xf32>, %arg2: tensor<12x6xf32>) -> tensor<12x6xf32> {
//     %0 = linalg.matmul ins(%arg0, %arg1 : tensor<12x9xf32>, tensor<9x6xf32>) outs(%arg2 : tensor<12x6xf32>) -> tensor<12x6xf32>
//     return %0 : tensor<12x6xf32>
//   }
// }