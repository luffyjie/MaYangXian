//
//  MayangViewController.m
//  MaYangXian
//
//  Created by lujie on 14-7-27.
//  Copyright (c) 2014年 LuJie. All rights reserved.
//

#import "MayangViewController.h"
#import "Town.h"
#import "Article.h"
#import "MayangPhotoViewCell.h"
#import "MayangTableViewCell.h"
#import "MayangScendViewController.h"

@interface MayangViewController ()
@property (strong, nonatomic) NSMutableArray *townList;

@end

@implementation MayangViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.translucent = NO;
    
    // 获取静态文件数据
    [self getDataFormFiles];
    
    // 对table 进行参数设置
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView setSeparatorColor:[UIColor blackColor]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 获取属性文件数据
-(void)getDataFormFiles
{
    self.townList = [[NSMutableArray alloc] init];
	NSArray *townDictionaries = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TownList" ofType:@"plist"]];
	NSArray *propertyNames = [[NSArray alloc] initWithObjects:@"name", @"location", @"distance", @"articles", nil];
	for (NSDictionary *townDictionary in townDictionaries) {
		Town *town = [[Town alloc] init];
		for (NSString *property in propertyNames) {
            if ([property isEqualToString:@"articles"]) {
                for (NSDictionary *articleDictionary in [townDictionary objectForKey:property]) {
                    Article *article = [[Article alloc] init];
                    [article setValue:[articleDictionary objectForKey:@"title"] forKey:@"title"];
                    [article setValue:[articleDictionary objectForKey:@"author"] forKey:@"author"];
                    [article setValue:[articleDictionary objectForKey:@"content"] forKey:@"content"];
                    NSString *imageName = [articleDictionary objectForKey:@"thumbnailImage"];
                    article.thumbnailImage = [UIImage imageNamed:imageName];
                    [article setValue:[articleDictionary objectForKey:@"images"] forKey:@"imageList"];
                    [town.articleList addObject:article];
                }
            }else {
                [town setValue:[townDictionary objectForKey:property] forKey:property];
            }
		}
		NSString *imageName = [townDictionary objectForKey:@"thumbnailImage"];
		town.thumbnailImage = [UIImage imageNamed:imageName];
		[self.townList addObject:town];
	}
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = [self.townList count];
	if (count == 0) {
		count = 1;
	}
	
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MayangPhotoViewCell *firstCell = [[MayangPhotoViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"photoIdentifier"];
        firstCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return firstCell;
    }else{
        MayangTableViewCell *townCell = [[MayangTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyIdentifier"];
        townCell.town = [self.townList objectAtIndex:indexPath.row - 1];
        return townCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //预留展示图片的cell高度
    if (indexPath.row == 0) {
        return 143.0;
    }
    
    return 53.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"scendSegue" sender:self];
}

#pragma mark about button

- (IBAction)aboutButton:(UIButton *)sender {
         [self performSegueWithIdentifier:@"aboutSegue" sender:self];
}

#pragma mark 处理segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual:@"scendSegue"]) {
        MayangScendViewController *townscend = (MayangScendViewController *) segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        townscend.articleList = [[self.townList objectAtIndex: indexPath.row - 1] articleList];
        townscend.navigationItem.title = [[self.townList objectAtIndex: indexPath.row - 1] name];
        // 设置返回按钮的文本
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                       initWithTitle:@"返回"
                                       style:UIBarButtonItemStylePlain target:nil action:nil];
        [self.navigationItem setBackBarButtonItem:backButton];
    }
    
    if ([segue.identifier isEqual:@"aboutSegue" ]) {
        
    }
}

@end
