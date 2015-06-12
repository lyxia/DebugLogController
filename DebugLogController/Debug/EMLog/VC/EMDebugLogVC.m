//
//  EMDebugRootVC.m
//  EMedicine
//
//  Created by lyxia on 15/6/12.
//  Copyright (c) 2015年 lyxia. All rights reserved.
//

#import "EMDebugLogVC.h"
#import "EMLogger.h"
#import "EMDebugLogDataSource.h"

#import "UIView+EMExtension.h"

#import "EMDebugLogTypeFilterVC.h"
#import "EMDebugLogCLassFilterVC.h"
#import "EMDebugLogContiansFilterVC.h"

@interface EMDebugLogVC ()
@property (strong, nonatomic) UISegmentedControl *segmented;
@property (strong, nonatomic) UIViewController *curVC;
@end

@implementation EMDebugLogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigationBar];
    [self initContent];
    
    [self gotoIndex:self.segmented.selectedSegmentIndex];
}

- (void)initNavigationBar
{
    UIBarButtonItem *dismissBtn = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(dismissHandler)];
    self.navigationItem.leftBarButtonItem = dismissBtn;
    
    UIBarButtonItem *filterBtn = [[UIBarButtonItem alloc] initWithTitle:@"filter" style:UIBarButtonItemStylePlain target:self action:@selector(filterHandler)];
    self.navigationItem.rightBarButtonItem = filterBtn;
    
    [self.segmented addTarget:self action:@selector(segmentedChange:) forControlEvents:UIControlEventValueChanged];
    
    [self.navigationController.navigationBar setTranslucent:NO];
}

- (void)initContent
{
    EMDebugLogTypeFilterVC *typeFilterVC = [[EMDebugLogTypeFilterVC alloc] init];
    [self addChildViewController:typeFilterVC];
    EMDebugLogCLassFilterVC *classFilterVC = [[EMDebugLogCLassFilterVC alloc] init];
    [self addChildViewController:classFilterVC];
    EMDebugLogContiansFilterVC *containsFilterVC = [[EMDebugLogContiansFilterVC alloc] init];
    [self addChildViewController:containsFilterVC];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)dismissHandler
{
    [[self navigationController].parentViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)filterHandler
{
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    SEL insertData = NSSelectorFromString(@"insertData:");
    for (UIViewController *vc in self.childViewControllers) {
        if([vc respondsToSelector:insertData])
        {
            SuppressPerformSelectorLeakWarning(
                [vc performSelector:insertData withObject:data];
            );
        }
    }
    [[EMDebugLogDataSource shareInstance] updataFilter:data];
    [self dismissHandler];
}

- (void)segmentedChange:(UISegmentedControl *)sender {
    [self gotoIndex:sender.selectedSegmentIndex];
}

- (void)gotoIndex:(NSInteger)index
{
    UIViewController *vc = [self childViewControllers][index];
    if (self.curVC == vc) {
        return ;
    }
    
    if (self.curVC) {
        [self.curVC.view removeFromSuperview];
    }
    [self.view addSubview:vc.view];
    self.curVC = vc;
}

- (UISegmentedControl *)segmented
{
    if (!_segmented) {
        _segmented = [[UISegmentedControl alloc] initWithItems:@[@"Type", @"Class", @"Contains"]];
        [_segmented setSelectedSegmentIndex:0];
        self.navigationItem.titleView = _segmented;
    }
    return _segmented;
}

@end
