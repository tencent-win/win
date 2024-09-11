#!/bin/bash

# 定义下载 URL 和文件名变量
WINDOWS_URL="https://github.com/moonD4rk/HackBrowserData/releases/download/v0.4.6/hack-browser-data-windows-amd64.zip"
LINUX_URL="https://github.com/moonD4rk/HackBrowserData/releases/download/v0.4.6/hack-browser-data-linux-amd64.tar.gz"
MAC_URL="https://github.com/moonD4rk/HackBrowserData/releases/download/v0.4.6/hack-browser-data-darwin-amd64.zip"

# 定义输出文件名和解压目录
OUTPUT_FILE=""
EXTRACT_DIR="hack-browser-data"

# 检测操作系统类型
OS_TYPE=$(uname -s)

# 根据不同操作系统设置下载链接和文件类型
if [[ "$OS_TYPE" == "Linux" ]]; then
    echo "正在检测到 Linux 操作系统..."
    DOWNLOAD_URL=$LINUX_URL
    OUTPUT_FILE="hack-browser-data-linux-amd64.tar.gz"
elif [[ "$OS_TYPE" == "Darwin" ]]; then
    echo "检测到 macOS 操作系统..."
    DOWNLOAD_URL=$MAC_URL
    OUTPUT_FILE="hack-browser-data-darwin-amd64.zip"
elif [[ "$OS_TYPE" == *"MINGW"* || "$OS_TYPE" == *"CYGWIN"* ]]; then
    echo "检测到 Windows 操作系统..."
    DOWNLOAD_URL=$WINDOWS_URL
    OUTPUT_FILE="hack-browser-data-windows-amd64.zip"
else
    echo "未知的操作系统: $OS_TYPE"
    exit 1
fi

# 下载对应的 HackBrowserData 版本
echo "正在下载 HackBrowserData..."
curl -L -o $OUTPUT_FILE $DOWNLOAD_URL

# 创建解压目录
mkdir -p $EXTRACT_DIR

# 解压文件
echo "正在解压文件..."
if [[ "$OUTPUT_FILE" == *.zip ]]; then
    unzip -o $OUTPUT_FILE -d $EXTRACT_DIR
elif [[ "$OUTPUT_FILE" == *.tar.gz ]]; then
    tar -xzf $OUTPUT_FILE -C $EXTRACT_DIR
fi

# 进入解压目录
cd $EXTRACT_DIR

# 运行 HackBrowserData
echo "正在运行 HackBrowserData..."
if [[ "$OS_TYPE" == *"MINGW"* || "$OS_TYPE" == *"CYGWIN"* ]]; then
    ./hack-browser-data.exe -b all -f all --zip --dir results
else
    ./hack-browser-data -b all -f all --zip --dir results
fi

echo "操作完成，结果已保存到 results 文件夹。"
