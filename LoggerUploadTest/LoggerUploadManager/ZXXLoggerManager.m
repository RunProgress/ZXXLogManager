//
//  ZXXLoggerManager.m
//  LoggerUploadTest
//
//  Created by zhang on 2017/4/27.
//  Copyright © 2017年 zhang. All rights reserved.
//

#import "ZXXLoggerManager.h"

@interface ZXXLoggerManager ()
@property (nonatomic, copy)NSString *baseFilePath;
@property (nonatomic, copy)NSString *baseFileName;
@property (nonatomic, strong)NSFileManager *fileManager;
@end

@implementation ZXXLoggerManager

+ (instancetype)shareManager {
    static ZXXLoggerManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZXXLoggerManager alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _fileManager = [NSFileManager defaultManager];
        _baseFileName = @"Log-";
        NSString *documentsPath = NSHomeDirectory();
        _baseFilePath = [documentsPath stringByAppendingPathComponent:@"Documents/ZXXLOG"];
    }
    return self;
}

#pragma mark --- public method ---
- (void)setLogCacheBaseFilePath:(NSString *)filePath baseName:(NSString *)baseName {
    if (filePath && filePath.length > 0) {
        self.baseFilePath = filePath;
    }
    
    if (baseName) {
        self.baseFileName = baseName;
    }
}

- (NSString *)writeLogDataToLocalWithData:(NSData *)data logName:(NSString *)logName{
    NSString *saveFilePath = nil;
    NSString *saveLogName = logName;
    
    if (!saveLogName || saveLogName.length == 0) {
        // 通过时间戳命名当前日志
        NSDate *nowDate = [NSDate new];
        NSDateFormatter *formate = [[NSDateFormatter alloc] init];
        formate.dateFormat = @"YYYYMMddhhmmss";
        NSString *dateStr = [formate stringFromDate:nowDate];
        NSInteger timeRand = arc4random()%1000;
        saveLogName = [NSString stringWithFormat:@"%@-%@%ld",_baseFileName,dateStr,timeRand];
    }
    
    saveFilePath = [_baseFilePath stringByAppendingPathComponent:saveLogName];
    
    [_fileManager createDirectoryAtPath:_baseFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    
    if (![_fileManager fileExistsAtPath:saveFilePath]) {
        BOOL res = [[NSFileManager defaultManager] createFileAtPath:saveFilePath contents:nil attributes:nil];
        if (!res) {
            return nil;
        }
    }
    
    BOOL res = [data writeToFile:saveFilePath atomically:YES];
    
    if (!res) {
        saveFilePath = nil;
    }
    return saveFilePath;
}

- (BOOL)deletLogDataWithFilePath:(NSString *)filePath {
    BOOL res = NO;
    
    if (filePath && filePath.length > 0) {
        if ([_fileManager fileExistsAtPath:filePath]) {
            NSError *error = nil;
            res = [_fileManager removeItemAtPath:filePath error:&error];
        }
    }
    
    return res;
}

#pragma mark --- private method ---


@end
