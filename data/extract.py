import subprocess
import re
import csv
import os
csv_filename = "/root/wang/codellm/data/pass.csv"
default_cost = 1
repo_root = "/root/wang/LLVM/mlir"

def extract_block(code_content):
    pattern = r'\s*// -----\s*'
    statements = re.split(pattern, code_content)
    statements = [statement.strip() for statement in statements if statement.strip() != ""]

    for i in range(len(statements)):
        statements[i] = re.sub(r"//.*", "", statements[i])  # 去掉注释
        # statements[i] = re.sub(r"\n+", "\n", statements[i])  # 去掉多余的换行
        statements[i] = "\n".join(line for line in statements[i].splitlines() if line.strip())
    statements = [statement for statement in statements if statement.strip()]
    return statements

def extract_pass(code_content):
    pattern = r"// RUN:(.+?)\| FileCheck"
    statements = re.findall(pattern, code_content, re.DOTALL)
    for i in range(len(statements)):
      statements[i] = statements[i].replace('\\\n// RUN:', '').replace('%s', '')
    statements = [statement for statement in statements if statement.strip()]
    return statements


def save(code_content):
    blocks = extract_block(code_content)
    passes = extract_pass(code_content)
    # 将新数据追加到 CSV 文件
    with open(csv_filename, "a", newline="") as csv_file:
      csv_writer = csv.writer(csv_file)
      for b in blocks:
         for p in passes:
            csv_writer.writerow([b, p, default_cost])
      
# if __name__ == "__main__":
    # path = '/root/wang/LLVM/mlir/test/Dialect/Linalg/canonicalize.mlir'
    # with open(path, "r") as file:
    #   code_content = file.read()
    # # blocks = extract_block(code_content)
    # # print(blocks[1])
    # # print()
    # # passes = extract_pass(code_content)
    # # print(passes)
    # save(code_content)
    
if __name__ == "__main__":
   # 遍历代码仓库下的所有 .mlir 文件
  for root, dirs, files in os.walk(repo_root):
      for filename in files:
          if filename.endswith(".mlir"):
              mlir_file_path = os.path.join(root, filename)
              
              # 获取处理后的正文和 pass
              print(f'打开{mlir_file_path}进行处理')
              with open(mlir_file_path, "r") as file:
                code_content = file.read()
              # 调用处理脚本函数
              save(code_content)
              print(f'{mlir_file_path}处理完成')
  print("处理完成并数据已追加到 CSV 文件")