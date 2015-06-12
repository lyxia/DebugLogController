//
//  EMDebugLogCLassFilterVC.m
//  EMedicine
//
//  Created by lyxia on 15/6/12.
//  Copyright (c) 2015年 lyxia. All rights reserved.
//

#import "EMDebugLogCLassFilterVC.h"
#import "EMDebugLogDataSource.h"

@interface EMDebugLogCLassFilterVC ()
@property (strong, nonatomic) UITextField *classNameTf;
@property (strong, nonatomic) UIButton *addBtn;
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *classNames;
@end

@implementation EMDebugLogCLassFilterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self addConstraints];
    [self.addBtn addTarget:self action:@selector(addClassName) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addConstraints
{
    NSDictionary *views = @{@"classNameTf":self.classNameTf, @"tableView":self.tableView ,@"addBtn":self.addBtn};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[classNameTf]-8-[addBtn(==40)]-8-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tableView]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[classNameTf]-8-[tableView]-8-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[addBtn(==30)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[classNameTf(==30)]" options:0 metrics:nil views:views]];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.classNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.classNames[indexPath.row];
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.classNames removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - handler event
- (void)addClassName
{
    if (!self.classNameTf.text || self.classNameTf.text.length == 0) {
        return ;
    }
    [self.classNames addObject:self.classNameTf.text];
    [self.tableView reloadData];
}

- (void)removeClassName:(NSString *)className
{
    [self.classNames removeObject:className];
}

#pragma mark -init
- (UITextField *)classNameTf
{
    if (!_classNameTf) {
        _classNameTf = [[UITextField alloc] init];
        [self.view addSubview:_classNameTf];
        
        [_classNameTf setBorderStyle:UITextBorderStyleRoundedRect];
        [_classNameTf setClearButtonMode:UITextFieldViewModeWhileEditing];
        
        [_classNameTf setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _classNameTf;
}

- (UIButton *)addBtn
{
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] init];
        [self.view addSubview:_addBtn];
        
        [_addBtn setTitle:@"Add" forState:UIControlStateNormal];
        [_addBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        [_addBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _addBtn;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        [self.view addSubview:_tableView];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.allowsSelection = NO;
        _tableView.editing = YES;
        
        [_tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _tableView;
}

- (NSMutableArray *)classNames
{
    if (!_classNames) {
        NSDictionary *dataSource = [EMDebugLogDataSource shareInstance].dataSource;
        NSArray *array = [dataSource objectForKey:Class];
        _classNames = [[NSMutableArray alloc] initWithArray:array];
    }
    return _classNames;
}

- (void)insertData:(NSMutableDictionary *)data
{
    [data setObject:self.classNames forKey:Class];
}

@end
