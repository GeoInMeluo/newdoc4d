//
//  NDRoomUserCommentCell2.m
//  newdoc4d
//
//  Created by zzc on 15/11/30.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDRoomUserCommentCell2.h"
#import "CWStarRateView.h"

@interface NDRoomUserCommentCell2 ()
@property (nonatomic, weak) CWStarRateView *starRateView;
@property (weak, nonatomic) IBOutlet UIView *rateDiv;
@end

@implementation NDRoomUserCommentCell2


- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self = [[NSBundle mainBundle] loadNibNamed:@"NDRoomUserCommentCell2" owner:nil options:nil][0];
    }
    return self;
}

- (void)setDocComment:(NDDoctorComment *)docComment{
    _docComment = docComment;
    
    _lblUsername.text = docComment.name;
    _lblContent.text = docComment.doctor_comment;
    _lblCommentTime.text = docComment.actual_date;
    [_btnIcon sd_setImageWithURL:[NSURL URLWithString:docComment.picture_url] forState:UIControlStateNormal placeholderImage:nil];
    _starRateView.scorePercent = [docComment.doctor_rating doubleValue] * 0.2;
    _lblDocCallback.text = docComment.doctor_response;
}

- (void)awakeFromNib {
    
    CWStarRateView *starRateView = [[CWStarRateView alloc] initWithFrame:self.rateDiv.bounds numberOfStars:5];
    //    self.starRateView.scorePercent = 0;
    //    self.starRateView.scorePercent = 4;
    self.starRateView.hasAnimation = YES;
    self.starRateView.allowIncompleteStar = YES;
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
