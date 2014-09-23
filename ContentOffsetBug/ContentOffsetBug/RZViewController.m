//
//  RZViewController.m
//  ContentOffsetBug
//
//  Created by Brian King on 9/22/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZViewController.h"

@interface RZViewController () <UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) BOOL heightToggle;
@property (assign, nonatomic) CGPoint lastContentOffset;

@end

@implementation RZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Test"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.heightToggle ? 44 : 66;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Test" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Cell - %d", indexPath.row];
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.heightToggle = !self.heightToggle;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ( self.tableView.isTracking ) {
#ifdef WORK_AROUND
        BOOL drasticShift = fabs(self.tableView.contentOffset.y - self.lastContentOffset.y) > 10;
        if ( drasticShift && self.tableView.isTracking ) {
            self.tableView.contentOffset = self.lastContentOffset;
        }
        self.lastContentOffset = self.tableView.contentOffset;
#endif
    }
}

@end
