//
//  NDRoomDocDetailCell.m
//  newdoc
//
//  Created by zzc on 15/10/18.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDRoomDocDetailCell.h"

@implementation NDRoomDocDetailCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setup];
    }
    return self;
}

- (void)setup{
    UILabel *lblTitle = [UILabel new];
    _lblTitle = lblTitle;
    [self addSubview:lblTitle];
    
    UIView *seprator = [UIView new];
    _seprator = seprator;
    [self addSubview:seprator];
    
    UILabel *lblDetail = [UILabel new];
    _lblDetail = lblDetail;
    [self addSubview:lblDetail];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _lblTitle.frame = CGRectMake(8, 8, self.width - 16, 1);
    _lblTitle.font = [UIFont pointFontOfSize:34];
    _lblTitle.numberOfLines = 0;
    _lblTitle.textColor = Blue;
    [_lblTitle sizeToFit];
    
    _seprator.frame = CGRectMake(_lblTitle.left, _lblTitle.bottom + 8, self.width - _lblTitle.left * 2, 1);
    _seprator.backgroundColor = LightGray;
    
    _lblDetail.frame = CGRectMake(8, _seprator.bottom + 8, self.width - _lblTitle.left * 2, 1);
    _lblDetail.numberOfLines = 0;
    _lblDetail.font = [UIFont pointFontOfSize:30];
    _lblDetail.textColor = [UIColor darkGrayColor];
    [_lblDetail sizeToFit];
    
    _cellHeight = _lblDetail.bottom + 8;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
