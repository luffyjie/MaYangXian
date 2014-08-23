//
//  MayangDetailViewController.m
//  MaYangXian
//
//  Created by lujie on 14-7-27.
//  Copyright (c) 2014年 LuJie. All rights reserved.
//

#import "MayangDetailViewController.h"

@interface MayangDetailViewController ()
@property (nonatomic, strong) UILabel *authorLabel;
@property (strong, nonatomic) UITextView *contentview;
@property (nonatomic, strong) UIImageView *imageview;

@end

@implementation MayangDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置textview的参数
    CGRect viewBounds = self.view.bounds;
    self.contentview = [[UITextView alloc]initWithFrame:CGRectMake(0.0, 0.0, viewBounds.size.width, viewBounds.size.height)];
    [self.contentview setBackgroundColor: [UIColor clearColor]];
    [self.contentview setDelegate:self];
    [self.contentview setEditable:YES];
    self.contentview.showsVerticalScrollIndicator = NO;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = 10.f;
    paragraphStyle.maximumLineHeight = 20.f;
    paragraphStyle.minimumLineHeight = 15.f;
    paragraphStyle.firstLineHeadIndent = 50.f;
    paragraphStyle.paragraphSpacing = 10.f;
    paragraphStyle.headIndent = 15.f;
    paragraphStyle.tailIndent = -15.f;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:15],
                                  NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor blackColor]};
    NSString *block = @"\n";
    //如果有图片附件，则留出空位 显示图片
    if (_article.imageList.count > 0) {
        block = @"\n\n\n\n\n";
        self.imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed: [_article.imageList objectAtIndex:0]]];
        self.imageview.frame = CGRectMake(20.0, 30.0, viewBounds.size.width - 40, 120.0);
        [self.contentview addSubview:self.imageview];
    }
    self.contentview .attributedText = [[NSAttributedString alloc]initWithString: [block stringByAppendingString: _article.content] attributes:attributes];
    self.contentview.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.contentview.bounds.size.width - 20, 20.0)];
    self.authorLabel.text = [@"作者--" stringByAppendingString: _article.author];
    self.authorLabel.textColor = [UIColor brownColor];
    self.authorLabel.textAlignment = NSTextAlignmentRight;
    [self.authorLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
    [self.contentview addSubview:self.authorLabel];
    [self.view addSubview:self.contentview];
}

- (void)setArticle:(Article *) newArticle{
    if (newArticle != _article) {
        _article = newArticle;
    }
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}



@end
