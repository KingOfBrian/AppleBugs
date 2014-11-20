//
//  ViewController.m
//  HiddenAccessibleButton
//
//  Created by Brian King on 11/20/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"Cell"];
    [self.tableView registerClass:[UITableViewHeaderFooterView class]
forHeaderFooterViewReuseIdentifier:@"Header"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = [NSString stringWithFormat:@"Row %zd - %zd",
                           indexPath.row, indexPath.section];
}

- (void)configureHeader:(UITableViewHeaderFooterView *)header inSection:(NSUInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.center = CGPointMake(20, header.bounds.size.height / 2);
    [button setTitle:@"Button" forState:UIControlStateNormal];
    [button sizeToFit];
    [header addSubview:button];

    button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.hidden = YES;
    button.center = CGPointMake(160, header.bounds.size.height / 2);
    [button setTitle:@"Hidden Button" forState:UIControlStateNormal];
    [button sizeToFit];
    [header addSubview:button];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    [self configureHeader:(id)view inSection:section];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

@end
