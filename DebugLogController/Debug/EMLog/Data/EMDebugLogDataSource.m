//
//  EMDebugLogDataSource.m
//  EMedicine
//
//  Created by lyxia on 15/6/12.
//  Copyright (c) 2015年 lyxia. All rights reserved.
//

#import "EMDebugLogDataSource.h"
#import "EMFileUtil.h"
#import "EMLogger.h"

@interface EMDebugLogDataSource()
@property (nonatomic, readwrite) NSDictionary *dataSource;
@end

@implementation EMDebugLogDataSource

+ (void)load
{
    EMDebugLogDataSource *logFilter = [EMDebugLogDataSource shareInstance];
    [logFilter filter];
}

+ (instancetype)shareInstance
{
    static EMDebugLogDataSource *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[EMDebugLogDataSource alloc] init];
        shareInstance.dataSource = [EMFileUtil sandBoxConfig:@"EMDebugLogFilter"];
        if (!shareInstance.dataSource) {
            shareInstance.dataSource = [shareInstance defaultDataSource];
            [EMFileUtil savaSandBoxConfig:@"EMDebugLogFilter" data:shareInstance.dataSource];
        }
    });
    return shareInstance;
}

- (NSDictionary *)defaultDataSource
{
    return @{
             Type :@{
                     @"close all" : [[NSNumber alloc] initWithBool:YES],
                     UIViewController_dealloc : [[NSNumber alloc] initWithBool:YES],
                     UIViewController_viewWillApear : [[NSNumber alloc] initWithBool:YES]
                     },
             Class : @[],
             Contains : @""
             };
}

- (void)updataFilter:(NSDictionary *)data
{
    self.dataSource = data;
    [EMFileUtil savaSandBoxConfig:@"EMDebugLogFilter" data:self.dataSource];
    [self filter];
}

- (void)filter
{
    NSDictionary *typeDic = self.dataSource[Type];
    NSMutableArray *types = [NSMutableArray array];
    [typeDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([(NSNumber *)obj boolValue]) {
            [types addObject:key];
        }
    }];
    [[EMLogger shareInstance] filterLogWithTypes:types];
    [[EMLogger shareInstance] filterLogWithClassNames:self.dataSource[Class]];
}

@end
