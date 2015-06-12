//
//  NSObject+EMExtension.m
//  EMedicine
//
//  Created by lyxia on 15/6/11.
//  Copyright (c) 2015年 lyxia. All rights reserved.
//

#import "NSObject+EMExtension.h"

@implementation NSObject (EMExtension)

+ (NSString *)className
{
    return NSStringFromClass([self class]);
}

- (NSString *)className
{
    return NSStringFromClass([self class]);
}

@end
