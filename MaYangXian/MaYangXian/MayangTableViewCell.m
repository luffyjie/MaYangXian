//
//  MayangTableViewCell.m
//  MaYangXian
//
//  Created by lujie on 14-7-27.
//  Copyright (c) 2014年 LuJie. All rights reserved.
//

#import "MayangTableViewCell.h"

#define IMAGE_HEIGHT_SIZE   45.0
#define IMAGE_WIDTH_SIZE    60.0
#define TIP_IMAGE_WIDTH_SIZE 9.0
#define TIP_IMAGE_HEIGHT_SIZE 22.0
#define EDITING_INSET       10.0
#define TEXT_LEFT_MARGIN    10.0
#define TEXT_RIGHT_MARGIN   45.0
#define DISTANCE_WIDTH     100.0

@implementation MayangTableViewCell
{
    UIImageView *tipimageView;
    UIImageView *imageView;
    UILabel *nameLabel;
    UILabel *locationLabel;
    UILabel *distanceLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if ((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])) {
        
        //设置cell的背景颜色及contentview高度参数进行设置 very important !!
        self.contentView.frame = [self _contentViewFrame];
        
        //初始化图片 设置图片的边框
        imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:imageView];
        CALayer *layer = [imageView layer];
        layer.borderColor = [UIColor grayColor].CGColor;
        layer.borderWidth = 0.5f;
        
        //设置地理位置label的参数
        locationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [locationLabel setFont:[UIFont systemFontOfSize:14.0]];
        [locationLabel setTextColor:[UIColor blackColor]];
        locationLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:locationLabel];
        
        //设置距离提示label的参数
        distanceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [distanceLabel setFont:[UIFont systemFontOfSize:10.0]];
        [distanceLabel setTextColor:[UIColor blackColor]];
        distanceLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:distanceLabel];
        
        //文字标题label参数设置
        nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [nameLabel setFont:[UIFont boldSystemFontOfSize:16.0]];
        [nameLabel setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:nameLabel];
        
        //箭头图标初始化设置
        tipimageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:tipimageView];
	}
	return self;
}

- (CGRect)_contentViewFrame {
    return CGRectMake(0, 0, 320.0, 53.0);
}

- (CGRect)_tipimageViewFrame {
    CGRect contentViewBounds = self.contentView.bounds;
    return CGRectMake(contentViewBounds.size.width - TIP_IMAGE_WIDTH_SIZE*2.2, contentViewBounds.size.height/2 - TIP_IMAGE_HEIGHT_SIZE/2, TIP_IMAGE_WIDTH_SIZE, TIP_IMAGE_HEIGHT_SIZE);
}

- (CGRect)_imageViewFrame {
    return CGRectMake(7.0, 4.0, IMAGE_WIDTH_SIZE, IMAGE_HEIGHT_SIZE);
}

- (CGRect)_nameLabelFrame {
    return CGRectMake(IMAGE_WIDTH_SIZE + EDITING_INSET + TEXT_LEFT_MARGIN, 18.0, self.contentView.bounds.size.width - IMAGE_WIDTH_SIZE - EDITING_INSET - TEXT_LEFT_MARGIN, 16.0);
}

- (CGRect)_locationLabelFrame {
    CGRect contentViewBounds = self.contentView.bounds;
    return CGRectMake(contentViewBounds.size.width - DISTANCE_WIDTH - TEXT_RIGHT_MARGIN, 10.0, DISTANCE_WIDTH, 16.0);
}

- (CGRect)_distanceLabelFrame {
    CGRect contentViewBounds = self.contentView.bounds;
    return CGRectMake(contentViewBounds.size.width - DISTANCE_WIDTH - TEXT_RIGHT_MARGIN, 30.0, DISTANCE_WIDTH, 16.0);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [tipimageView setFrame:[self _tipimageViewFrame]];
    [imageView setFrame:[self _imageViewFrame]];
    [nameLabel setFrame:[self _nameLabelFrame]];
    [locationLabel setFrame:[self _locationLabelFrame]];
    [distanceLabel setFrame:[self _distanceLabelFrame]];
    if (self.editing) {
        distanceLabel.alpha = 0.0;
    } else {
        distanceLabel.alpha = 1.0;
    }
}


-(void)setTown:(Town *) newTown{
    if (newTown != _town) {
        _town = newTown;
        tipimageView.image = [UIImage imageNamed:@"tip"];
        imageView.image = _town.thumbnailImage;
        nameLabel.text = _town.name;
        locationLabel.text = _town.location;
        distanceLabel.text = _town.distance;
    }
}

@end
