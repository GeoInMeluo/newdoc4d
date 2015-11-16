//
//  NDPersonalAttentionDocCell.m
//  newdoc
//
//  Created by zzc on 15/10/22.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDPersonalAttentionDocCell.h"

@implementation NDPersonalAttentionDocCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self = [[NSBundle mainBundle] loadNibNamed:@"NDPersonalAttentionDocCell" owner:nil options:nil][0];
    }
    return self;
}

- (void)setTempDocDic:(NSDictionary *)tempDocDic{
    _tempDocDic = tempDocDic;
    
    WEAK_SELF;
    
    _lblName.text = tempDocDic[@"name"];
    [_ivHeadImg sd_setImageWithURL:[NSURL URLWithString:tempDocDic[@"picture_url"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_placeHolder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [weakself.ivHeadImg setImage:image forState:UIControlStateNormal];
    }];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
