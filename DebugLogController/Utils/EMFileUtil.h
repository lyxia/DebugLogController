//
//  EMFileUtil.h
//  EMedicine
//
//  Created by lyxia on 15/6/12.
//  Copyright (c) 2015年 lyxia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMFileUtil : NSObject

//读取系统配置
+ (NSMutableDictionary *)systemConfig:(NSString *)configName;

//读取沙盒配置
+ (NSMutableDictionary *)sandBoxConfig:(NSString *)configName;

//获得沙盒路径
+ (NSString *)sandBoxPath;

//保存沙盒配置数据
+ (void)savaSandBoxConfig:(NSString *)configName data:(NSDictionary *)data;

@end
