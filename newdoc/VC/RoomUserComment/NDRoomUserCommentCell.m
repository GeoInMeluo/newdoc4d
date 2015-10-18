//
//  NDRoomUserCommentCell.m
//  newdoc
//
//  Created by zzc on 15/10/18.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDRoomUserCommentCell.h"
#import "CWStarRateView.h"

@interface NDRoomUserCommentCell ()
@property (nonatomic, weak) CWStarRateView *starRateView;
@property (weak, nonatomic) IBOutlet UIView *rateDiv;
@end

@implementation NDRoomUserCommentCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self = [[NSBundle mainBundle] loadNibNamed:@"NDRoomUserCommentCell" owner:nil options:nil][0];
    }
    return self;
}

- (void)awakeFromNib {
    
    CWStarRateView *starRateView = [[CWStarRateView alloc] initWithFrame:self.rateDiv.bounds numberOfStars:5];
    self.starRateView.scorePercent = 0;
    self.starRateView.scorePercent = 4;
    self.starRateView.hasAnimation = YES;
    self.starRateView = starRateView;
    self.starRateView.userInteractionEnabled = NO;
    [self.rateDiv addSubview:starRateView];
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.starRateView.centerX = self.rateDiv.width * 0.5;
    self.starRateView.centerY = self.rateDiv.height * 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

}

@end
