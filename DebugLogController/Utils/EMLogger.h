//
//  EMLogger.h
//  EMedicine
//
//  Created by lyxia on 15/6/11.
//  Copyright (c) 2015年 lyxia. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#define CLOSE_ALL @"CLOSE_ALL"
#define UIViewController_viewWillApear @"UIViewController viewWillAppear"
#define UIViewController_dealloc @"UIViewController dealloc"
#endif

@interface EMLogger : NSObject

- (void)closeAllLog;

- (void)filterLogWithType:(NSString *)type;

- (void)filterLogWithTypes:(NSArray *)types;

- (void)filterLogWithClassName:(NSString *)className;

- (void)filterLogWithClassNames:(NSArray *)classNames;

+ (instancetype)shareInstance;

@end
