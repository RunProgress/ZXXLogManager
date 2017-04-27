//
//  ViewController.m
//  LoggerUploadTest
//
//  Created by zhang on 2017/4/27.
//  Copyright © 2017年 zhang. All rights reserved.
//

#import "ViewController.h"
#import "ZXXLoggerManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSData *data = [@"asdfafa" dataUsingEncoding:NSUTF8StringEncoding];
    NSString *filePath = [[ZXXLoggerManager shareManager] writeLogDataToLocalWithData:data logName:nil];
    BOOL res = [[ZXXLoggerManager shareManager] deletLogDataWithFilePath:filePath];
    NSLog(@"%@", res ? @"true" : @"false");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
