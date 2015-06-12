//
//  EMDebugLogTypeFilterVC.m
//  EMedicine
//
//  Created by lyxia on 15/6/12.
//  Copyright (c) 2015年 lyxia. All rights reserved.
//

#import "EMDebugLogTypeFilterVC.h"
#import "EMDebugLogDataSource.h"

@interface EMDebugLogTypeFilterVC ()
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *types;
@end

@implementation EMDebugLogTypeFilterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self addConstraints];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
}

- (void)addConstraints
{
    NSDictionary *views = @{@"tableView":self.tableView};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tableView]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[tableView]-0-|" options:0 metrics:nil views:views]];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.types count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    UISwitch *switchV;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        switchV = [[UISwitch alloc] init];
        cell.accessoryView = switchV;
        switchV.tag = indexPath.row;
        [switchV addTarget:self action:@selector(switchHandler:) forControlEvents:UIControlEventValueChanged];
    }
    switchV = (UISwitch *)cell.accessoryView;
    cell.textLabel.text = [self.types.allKeys objectAtIndex:indexPath.row];
    if([(NSNumber *)[self.types.allValues objectAtIndex:indexPath.row] boolValue])
    {
        [switchV setOn:YES];
    } else {
        [switchV setOn:NO];
    }
    return cell;
}

#pragma mark - handler event
- (void)switchHandler:(UISwitch *)sender
{
    NSString *key = [self.types.allKeys objectAtIndex:sender.tag];
    [self.types setObject:[[NSNumber alloc] initWithBool:sender.on] forKey:key];
}

#pragma mark - init
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        [self.view addSubview:_tableView];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.allowsSelection = NO;
        
        [_tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _tableView;
}

- (NSMutableDictionary *)types
{
    if (!_types) {
        NSDictionary *dataSource = [EMDebugLogDataSource shareInstance].dataSource;
        NSDictionary *dic = [dataSource objectForKey:Type];
        _types = [[NSMutableDictionary alloc] initWithDictionary:dic];
    }
    return _types;
}

- (void)insertData:(NSMutableDictionary *)data
{
    [data setObject:self.types forKey:Type];
}

@end
