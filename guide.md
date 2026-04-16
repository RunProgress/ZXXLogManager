# ZXXLogManager 仓库指南

## 仓库概述

ZXXLogManager 是一个 iOS 平台的日志管理工具，主要用于日志文件的本地存储和管理。该项目提供了简单易用的接口，帮助开发者在应用中实现日志的持久化存储。

## 项目结构

```
├── LoggerUploadTest/           # 主项目目录
│   ├── LoggerUploadManager/    # 核心日志管理模块
│   │   ├── ZXXLoggerManager.h  # 头文件
│   │   └── ZXXLoggerManager.m  # 实现文件
│   ├── AppDelegate.h/m         # 应用代理
│   ├── ViewController.h/m      # 视图控制器
│   └── main.m                  # 程序入口
├── LoggerUploadTest.xcodeproj/ # Xcode 项目文件
├── LoggerUploadTestTests/      # 单元测试
├── LoggerUploadTestUITests/    # UI 测试
├── Pods/                       # CocoaPods 依赖
│   └── AFNetworking/           # 网络库依赖
├── Podfile                     # CocoaPods 配置文件
└── README.md                   # 项目说明
```

## 核心功能

### ZXXLoggerManager 类

`ZXXLoggerManager` 是项目的核心类，提供了以下功能：

1. **单例模式**：通过 `shareManager` 方法获取唯一实例
2. **日志存储配置**：设置日志缓存目录和基础文件名
3. **日志写入**：将日志数据写入本地文件
4. **日志删除**：删除指定路径的日志文件

### 主要方法

| 方法 | 描述 | 参数 | 返回值 |
|------|------|------|--------|
| `setLogCacheBaseFilePath:baseName:` | 设置日志缓存目录和基础文件名 | filePath: 目录地址<br>baseName: 日志名称前缀 | 无 |
| `writeLogDataToLocalWithData:logName:` | 写入日志数据到本地文件 | data: 日志数据<br>logName: 日志文件名 | 成功返回文件路径，失败返回 nil |
| `deletLogDataWithFilePath:` | 删除本地日志文件 | filePath: 文件路径 | 成功返回 YES，失败返回 NO |

## 技术实现

### 存储机制

- 默认存储路径：`Documents/ZXXLOG/`
- 默认日志前缀：`Log-`
- 自动创建目录结构
- 使用时间戳和随机数生成唯一文件名

### 线程安全

- 使用 `dispatch_once` 确保单例的线程安全

## 使用方法

### 1. 导入头文件

```objective-c
#import "ZXXLoggerManager.h"
```

### 2. 获取单例实例

```objective-c
ZXXLoggerManager *loggerManager = [ZXXLoggerManager shareManager];
```

### 3. 配置存储路径（可选）

```objective-c
// 设置自定义存储路径和日志前缀
[loggerManager setLogCacheBaseFilePath:@"/custom/path" baseName:@"MyAppLog-"];
```

### 4. 写入日志

```objective-c
// 准备日志数据
NSData *logData = [@"This is a log message" dataUsingEncoding:NSUTF8StringEncoding];

// 写入日志（自动生成文件名）
NSString *filePath = [loggerManager writeLogDataToLocalWithData:logData logName:nil];

// 或者指定文件名
NSString *customPath = [loggerManager writeLogDataToLocalWithData:logData logName:@"custom-log.txt"];

if (filePath) {
    NSLog(@"日志写入成功，路径：%@", filePath);
} else {
    NSLog(@"日志写入失败");
}
```

### 5. 删除日志

```objective-c
// 删除指定路径的日志文件
BOOL success = [loggerManager deletLogDataWithFilePath:filePath];
if (success) {
    NSLog(@"日志删除成功");
} else {
    NSLog(@"日志删除失败");
}
```

## 依赖项

- **AFNetworking**：用于网络操作（虽然当前实现中未直接使用，但已集成）

## 扩展建议

1. **日志上传功能**：添加将本地日志上传到服务器的功能
2. **日志压缩**：实现日志文件的压缩，减少存储空间
3. **日志轮转**：添加日志文件轮转机制，避免单个文件过大
4. **日志级别**：支持不同级别的日志（如 DEBUG、INFO、ERROR 等）
5. **日志加密**：对敏感日志进行加密存储

## 注意事项

- 确保应用有文件系统写入权限
- 定期清理过期日志，避免存储空间占用过大
- 在生产环境中注意日志内容的安全性，避免记录敏感信息

## 示例应用

项目中包含一个简单的示例应用，展示了如何使用 `ZXXLoggerManager` 进行日志管理。

## 总结

ZXXLogManager 是一个轻量级的日志管理工具，提供了基本的日志存储和管理功能。通过简单的接口，开发者可以轻松实现应用中的日志持久化，为应用的调试和问题排查提供有力支持。