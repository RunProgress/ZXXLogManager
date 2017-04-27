//
//  ZXXLoggerManager.h
//  LoggerUploadTest
//
//  Created by zhang on 2017/4/27.
//  Copyright © 2017年 zhang. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 缓存日志管理类 负责日志文件的存储以及上传
*/
@interface ZXXLoggerManager : NSObject

+ (instancetype)shareManager;


/**
 * 设置日志缓存的目录

 @param filePath 目录地址 (默认 Documents/ZXXLOG/)
 @param baseName 日志的名称首部 (like: Log-******)
        nil: 日志的名称首部为默认(default: Log)
 */
- (void)setLogCacheBaseFilePath:(NSString *)filePath baseName:(NSString *)baseName;

/**
 * 写入缓存数据 到本地文件
 @param data 缓存数据
 @param logName 缓存日子的名字; 如果 nil,使用默认命名(baseName-timetamp)
 @return 如果写入返回该日志写入的地址, 失败 返回 nil
 */
- (NSString *)writeLogDataToLocalWithData:(NSData *)data logName:(NSString *)logName;


/**
 * 删除本地的日志文件

 @param filePath 文件路径
 @return 成功: YES, 失败: NO
 */
- (BOOL)deletLogDataWithFilePath:(NSString *)filePath;

@end
