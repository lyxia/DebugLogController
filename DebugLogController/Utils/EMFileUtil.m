//
//  EMFileUtil.m
//  EMedicine
//
//  Created by lyxia on 15/6/12.
//  Copyright (c) 2015年 lyxia. All rights reserved.
//

#import "EMFileUtil.h"

@implementation EMFileUtil

//取沙盒的plist
+ (NSMutableDictionary *)sandBoxConfig:(NSString *)configName
{
    NSString *plistPath = [self configCompletePath:configName];
    NSMutableDictionary *config = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    return config;
}

//取系统的plist
+ (NSMutableDictionary *)systemConfig:(NSString *)configName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:configName ofType:@"plist"];
    return [[NSMutableDictionary  alloc] initWithContentsOfFile:path];
}

//获取沙盒路径
+ (NSString *)sandBoxPath
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths objectAtIndex:0];
    return path;
}

//获取配置的沙盒路径
+ (NSString *)configCompletePath:(NSString *)configName
{
    NSString *path = [self sandBoxPath];
    return [NSString stringWithFormat:@"%@%@.plist", path, configName];
}

//保存沙盒中的config
//因为系统的list文件是只读属性，在沙盒中的文件才是可读和可写的，必须在沙盒中创建plist文件
+ (void)savaSandBoxConfig:(NSString *)configName data:(NSDictionary *)data
{
    [data writeToFile:[self configCompletePath:configName] atomically:YES];
}

@end
