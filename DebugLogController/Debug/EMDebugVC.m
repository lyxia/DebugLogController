//
//  EMDebugVC.m
//  EMedicine
//
//  Created by lyxia on 15/6/12.
//  Copyright (c) 2015年 lyxia. All rights reserved.
//

#import "EMDebugVC.h"
#import "EMDebugLogVC.h"

@interface EMDebugVC ()

@end

@implementation EMDebugVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:[EMDebugLogVC new]];
    [self addChildViewController:nv];
    [self.view addSubview:nv.view];
}

@end
