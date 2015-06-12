//
//  EMDebugLogContiansFilterVC.m
//  EMedicine
//
//  Created by lyxia on 15/6/12.
//  Copyright (c) 2015年 lyxia. All rights reserved.
//

#import "EMDebugLogContiansFilterVC.h"
#import "EMDebugLogDataSource.h"

@interface EMDebugLogContiansFilterVC ()
@property (nonatomic, strong) UITextField *containsTf;
@property (nonatomic, copy) NSString *contains;
@end

@implementation EMDebugLogContiansFilterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self addConstraints];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.containsTf.text = self.contains;
}

- (void)addConstraints
{
    NSDictionary *views = @{@"containsTf":self.containsTf};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[containsTf]-8-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[containsTf(==30)]" options:0 metrics:nil views:views]];
}

#pragma mark -init
- (UITextField *)containsTf
{
    if (!_containsTf) {
        _containsTf = [[UITextField alloc] init];
        [self.view addSubview:_containsTf];
        
        [_containsTf setBorderStyle:UITextBorderStyleRoundedRect];
        [_containsTf setClearButtonMode:UITextFieldViewModeWhileEditing];
        
        [_containsTf setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _containsTf;
}

- (NSString *)contains
{
    if (!_contains) {
        NSDictionary *dataSource = [EMDebugLogDataSource shareInstance].dataSource;
        NSString *str = [dataSource objectForKey:Contains];
        _contains = str;
    }
    return _contains;
}

- (void)insertData:(NSMutableDictionary *)data
{
    [data setObject:@"" forKey:Contains];
}

@end
