//
//  MayangScendTableViewCell.m
//  MaYangXian
//
//  Created by lujie on 14-7-27.
//  Copyright (c) 2014年 LuJie. All rights reserved.
//

#import "MayangScendTableViewCell.h"

#define LEFT_IMAGE_HEIGHT_SIZE  94.0
#define LEFT_IMAGE_WIDTH_SIZE   25.0
#define RIGHT_IMAGE_HEIGHT_SIZE   90.0
#define RIGHT_IMAGE_WIDTH_SIZE    88.0
#define TEXT_LEFT_MARGIN    10.0
#define TEXT_RIGHT_MARGIN    5.0



@implementation MayangScendTableViewCell

{
    UIImageView *leftimageView;
    UIImageView *rightimageView;
    UILabel *titleLabel;
    UILabel *contentLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if ((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])) {

        //设置cell的背景颜色及contentview高度参数进行设置
        self.contentView.frame = [self _contentViewFrame];
        
        rightimageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:rightimageView];
        CALayer *layer = [rightimageView layer];
        layer.borderColor = [UIColor grayColor].CGColor;
        layer.borderWidth = 0.5f;
        
        leftimageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:leftimageView];
        
        contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        contentLabel.numberOfLines = 0;

        [self.contentView addSubview:contentLabel];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:13.0]];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setHighlightedTextColor:[UIColor whiteColor]];
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:titleLabel];
	}
	return self;
}

- (CGRect)_contentViewFrame {
    return CGRectMake(0, 0, 320.0, 103.0);
}

- (CGRect)_leftimageViewFrame {
    
    return CGRectMake(0.0, 4.0, LEFT_IMAGE_WIDTH_SIZE, LEFT_IMAGE_HEIGHT_SIZE);
}

- (CGRect)_rightimageViewFrame {
    CGRect contentViewBounds = self.contentView.bounds;
    return CGRectMake(contentViewBounds.size.width - RIGHT_IMAGE_WIDTH_SIZE - TEXT_RIGHT_MARGIN, 5.0, RIGHT_IMAGE_WIDTH_SIZE, RIGHT_IMAGE_HEIGHT_SIZE);
}

- (CGRect)_contentLabelFrame {
    return CGRectMake(LEFT_IMAGE_WIDTH_SIZE + TEXT_LEFT_MARGIN + 2, 5.0, self.contentView.bounds.size.width - LEFT_IMAGE_WIDTH_SIZE - RIGHT_IMAGE_WIDTH_SIZE - TEXT_LEFT_MARGIN - TEXT_RIGHT_MARGIN, 90.0);
}

- (CGRect)_titleLabelFrame {
    return CGRectMake(0.0, 4.0, LEFT_IMAGE_WIDTH_SIZE-1, LEFT_IMAGE_HEIGHT_SIZE);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [leftimageView setFrame:[self _leftimageViewFrame]];
    [rightimageView setFrame:[self _rightimageViewFrame]];
    [contentLabel setFrame:[self _contentLabelFrame]];
    [titleLabel setFrame:[self _titleLabelFrame]];
}


-(void)setArticle:(Article *) newArticle{
    if (newArticle != _article) {
        _article = newArticle;
        leftimageView.image = [UIImage imageNamed:@"left_tip"];
        rightimageView.image = _article.thumbnailImage;
        titleLabel.text = _article.title;
        
        //设置文字内容的样式参数
        contentLabel.adjustsFontSizeToFitWidth = YES;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineHeightMultiple = 10.f;
        paragraphStyle.maximumLineHeight = 20.f;
        paragraphStyle.minimumLineHeight = 15.f;
        paragraphStyle.firstLineHeadIndent = 30.f;
        paragraphStyle.alignment = NSTextAlignmentLeft;
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
        NSDictionary *attributes = @{
                                     NSFontAttributeName:[UIFont systemFontOfSize:15],
                                     NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor blackColor]};
        contentLabel.attributedText = [[NSAttributedString alloc]initWithString:  _article.content attributes:attributes];

    }
}

@end
