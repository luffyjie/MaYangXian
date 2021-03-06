//
//  MayangScendViewController.m
//  MaYangXian
//
//  Created by lujie on 14-7-27.
//  Copyright (c) 2014年 LuJie. All rights reserved.
//

#import "MayangScendViewController.h"
#import "MayangScendTableViewCell.h"
#import "MayangDetailViewController.h"

@implementation MayangScendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 对table 进行参数设置
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView setSeparatorColor:[UIColor blackColor]];
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = [self.articleList count];
	if (count == 0) {
		count = 1;
	}
	
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //update by lujie 由于此方法调用十分频繁，cell的标示声明成静态变量有利于性能优化 2014-09-29
    static NSString *articleIdentifier=@"articleIdentifier";
    MayangScendTableViewCell *articleCell = [tableView dequeueReusableCellWithIdentifier:articleIdentifier];
    if (!articleCell){
        articleCell = [[MayangScendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:articleIdentifier];
    }
    articleCell.article = [self.articleList objectAtIndex:indexPath.row];
    return articleCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //设置cell的高度
    return 103.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
}

#pragma mark 处理segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual:@"detailSegue"]) {
        MayangDetailViewController *detailView = (MayangDetailViewController *) segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        detailView.article = [self.articleList objectAtIndex: indexPath.row];
        detailView.navigationItem.title = [[self.articleList objectAtIndex: indexPath.row] title];
        // 设置返回按钮的文本
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                       initWithTitle:@"返回"
                                       style:UIBarButtonItemStylePlain target:nil action:nil];
        [self.navigationItem setBackBarButtonItem:backButton];
        
    }
    
}

@end
