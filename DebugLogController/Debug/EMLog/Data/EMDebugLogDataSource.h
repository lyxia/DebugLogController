//
//  EMDebugLogDataSource.h
//  EMedicine
//
//  Created by lyxia on 15/6/12.
//  Copyright (c) 2015年 lyxia. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Type @"Type"
#define Class @"Class"
#define Contains @"Contains"

@interface EMDebugLogDataSource : NSObject

@property (nonatomic, readonly) NSDictionary *dataSource;

- (void)updataFilter:(NSDictionary *)data;

+ (instancetype)shareInstance;

@end