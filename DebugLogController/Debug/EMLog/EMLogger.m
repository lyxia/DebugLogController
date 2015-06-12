//
//  EMLogger.m
//  EMedicine
//
//  Created by lyxia on 15/6/11.
//  Copyright (c) 2015年 lyxia. All rights reserved.
//

#import "EMLogger.h"
#import "Aspects.h"
#import "NSObject+EMExtension.h"

#import <UIKit/UIKit.h>

@interface EMLogger()
@property (nonatomic, strong) NSArray *filterTypes;
@property (nonatomic, strong) NSArray *filterClassNames;
@end

@implementation EMLogger

+ (void)load
{
#ifdef DEBUG
    [EMLogger shareInstance];
#endif
}

+ (instancetype)shareInstance
{
    static EMLogger *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[EMLogger alloc] init];
    });
    return shareInstance;
}

- (instancetype)init
{
    if (self = [super init]) {
        [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo){
            [self logWithType:UIViewController_viewWillApear aspectInfo:aspectInfo];
        } error:NULL];
        
        [UIViewController aspect_hookSelector:NSSelectorFromString(@"dealloc") withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo){
            [self logWithType:UIViewController_dealloc aspectInfo:aspectInfo];
        } error:NULL];
    }
    return self;
}

- (void)logDebugInfoWithView:(UIViewController *)viewController contentString:(NSMutableString *)contentString;
{
    [contentString appendFormat:@"= viewController name : %@", [viewController className]];
}

- (void)logWithType:(NSString *)type aspectInfo:(id<AspectInfo>)aspectInfo
{
    if (
        ![self filterClassNamesLog:[aspectInfo.instance className]] ||
        ![self filterTypesLog:type]
        )
    {
        return ;
    }
    
    NSMutableString *log = [self logHeader:type];
    if ([type isEqualToString:UIViewController_viewWillApear] || [type isEqualToString:UIViewController_dealloc]) {
        [self logDebugInfoWithView:aspectInfo.instance contentString:log];
    }
    [log appendString:[self logFooter:type]];
    NSLog(@"%@", log);
}

- (BOOL)filterTypesLog:(NSString *)type
{
    if (!self.filterTypes || [self.filterTypes count] == 0) {
        return YES;
    }
    BOOL filter = [self.filterTypes containsObject:type];
    return filter;
}

- (BOOL)filterClassNamesLog:(NSString *)className
{
    if (!self.filterTypes || [self.filterClassNames count] == 0) {
        return YES;
    }
    BOOL filter = [self.filterClassNames containsObject:className];
    return filter;
}

- (NSMutableString *)logHeader:(NSString *)type
{
    NSMutableString *logHeader = [NSMutableString stringWithFormat:@"\n\n==============================================================\n= startLog %@                        \n==============================================================\n\n", type];
    return logHeader;
}

- (NSString *)logFooter:(NSString *)type
{
    NSString *logFooter = [NSMutableString stringWithFormat:@"\n\n==============================================================\n= endLog %@                        \n==============================================================\n\n", type];
    return logFooter;
}

- (void)closeAllLog
{
    self.filterTypes = @[CLOSE_ALL];
    self.filterClassNames = @[CLOSE_ALL];
}

- (void)filterLogWithType:(NSString *)type
{
    self.filterTypes = @[type];
}

- (void)filterLogWithTypes:(NSArray *)types
{
    self.filterTypes = types;
}

- (void)filterLogWithClassName:(NSString *)className
{
    self.filterClassNames = @[className];
}

- (void)filterLogWithClassNames:(NSArray *)classNames
{
    self.filterClassNames = classNames;
}

@end
