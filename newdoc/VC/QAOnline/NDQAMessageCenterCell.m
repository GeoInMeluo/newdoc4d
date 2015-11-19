//
//  NDQAMessageCenterCell.m
//  newdoc
//
//  Created by zzc on 15/11/18.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDQAMessageCenterCell.h"

@implementation NDQAMessageCenterCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self = [[NSBundle mainBundle] loadNibNamed:@"NDQAMessageCenterCell" owner:nil options:nil][0];
    }
    return self;
}

- (void)setMessage:(NDQAMessage *)message{
    _message = message;
    
    _lblTitle.text = message.content;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
