//
//  ViewController.m
//  DebugLogController
//
//  Created by lyxia on 15/6/12.
//  Copyright (c) 2015年 lyxia. All rights reserved.
//

#import "ViewController.h"
#import "OpenDebugGestureRecognizer.h"
#import "EMDebugVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addGestureRecognizer:[[OpenDebugGestureRecognizer alloc] initWithTarget:self action:@selector(openDebugPanel)]];
}

- (void)openDebugPanel
{
    [self presentViewController:[EMDebugVC new] animated:YES completion:NULL];
}

@end
