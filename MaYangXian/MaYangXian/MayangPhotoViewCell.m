//
//  MayangPhotoViewCell.m
//  MaYangXian
//
//  Created by lujie on 14-7-27.
//  Copyright (c) 2014年 LuJie. All rights reserved.
//

#import "MayangPhotoViewCell.h"

@interface MayangPhotoViewCell ()
@property (nonatomic, strong) UIImageView *overImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *photoViewList;
@property (nonatomic, strong) NSArray *photoList;

@end

@implementation MayangPhotoViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if ((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])) {
       
        //获取静态数据
        NSString *path = [[NSBundle mainBundle] pathForResource:@"PhotoList" ofType:@"plist"];
        self.photoList = [NSArray arrayWithContentsOfFile:path];
        
        //对于数组的这样的 必须进行初始化
        NSMutableArray *photoView = [[NSMutableArray alloc] init];
        for (NSUInteger i = 0; i < self.photoList.count; i++)
        {
            [photoView addObject:[NSNull null]];
        }
        self.photoViewList = photoView;
        
        
        //对cell的contentview高度参数进行设置 very important !!
        self.contentView.frame = [self _contentViewFrame];
        
        //初始化及设置滚动条参数 必须在视图底层
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.contentView.frame];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame) * self.photoList.count, CGRectGetHeight(self.scrollView.frame));
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
//        self.scrollView.bounces=NO;//去掉翻页中的白屏
        self.scrollView.scrollsToTop = NO;
        self.scrollView.delegate = self;
        [self.contentView addSubview:self.scrollView];
        
        //初始化半透明的遮罩层
        self.overImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_over"]];
        self.overImageView.frame = [self _overImageViewFrame];
        [self.contentView addSubview:self.overImageView];
        
        //设置pagecontrol的参数
        self.pageControl = [[UIPageControl alloc] init];
        self.pageControl.frame = self.overImageView.frame;
        self.pageControl.numberOfPages = self.photoList.count;
        self.pageControl.currentPage = 0;
        self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
        [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:self.pageControl];
        
        //设置图片名字参数
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.frame = [self _nameLabelFrame];
        self.nameLabel.textAlignment = NSTextAlignmentRight;
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.font = [UIFont systemFontOfSize:13.f];
        self.nameLabel.text = @"序";
        [self.contentView addSubview:self.nameLabel];
        
        // 初始化几张图片 maybe 用户会滚动
        [self loadScrollViewWithPage:1];
        [self loadScrollViewWithPage:0];
        
    }
    return self;
}

// 对位置进行参数设置

- (CGRect)_overImageViewFrame {
    CGRect contentViewBounds = self.contentView.bounds;
    return CGRectMake(0, contentViewBounds.size.height - self.overImageView.bounds.size.height, self.overImageView.bounds.size.width, self.overImageView.bounds.size.height);
}

- (CGRect)_contentViewFrame {
    return CGRectMake(0, 0, 320.0, 143.0);
}

- (CGRect)_nameLabelFrame {
    CGRect contentViewBounds = self.contentView.bounds;
    return CGRectMake(-5.f, contentViewBounds.size.height - self.overImageView.bounds.size.height, self.overImageView.bounds.size.width, self.overImageView.bounds.size.height);
}

#pragma mark 实现scroll的协议 及实现滚动翻页效果
- (void)loadScrollViewWithPage:(NSUInteger)page
{
    if (page >= self.photoList.count) return;
    
    // replace the placeholder if necessary
    UIImageView *photoView = [self.photoViewList objectAtIndex:page];
    if ((NSNull *)photoView == [NSNull null])
    {
        photoView = [[UIImageView alloc] init];
        [self.photoViewList replaceObjectAtIndex:page withObject:photoView];
    }
    
    // add the controller's view to the scroll view
    if (photoView.superview == nil)
    {
        CGRect frame = self.scrollView.frame;
        frame.origin.x = CGRectGetWidth(frame) * page;
        frame.origin.y = 0;
        photoView.frame = frame;
        [self.scrollView addSubview:photoView];
        NSDictionary *numberItem = [self.photoList objectAtIndex:page];
        photoView.image = [UIImage imageNamed:[numberItem valueForKey:@"imageKey"]];
    }
}

// at the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    NSUInteger page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
    self.nameLabel.text = [[self.photoList objectAtIndex:page] valueForKey:@"nameKey"];
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page + 1];
}


#pragma mark pageControl点击事件实现
- (void)gotoPage:(BOOL)animated
{
    NSInteger page = self.pageControl.currentPage;
    self.nameLabel.text = [[self.photoList objectAtIndex:page] valueForKey:@"nameKey"];
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page + 1];
    //update the scroll view to the appropriate page
    CGRect bounds = self.scrollView.bounds;
    bounds.origin.x = CGRectGetWidth(bounds) * page;
    bounds.origin.y = 0;
    [self.scrollView scrollRectToVisible:bounds animated:animated];
}

- (void)changePage:(UIPageControl *)pageControl
{
    [self gotoPage:YES];    // YES = animate
}

@end
