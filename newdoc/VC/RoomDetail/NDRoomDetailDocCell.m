//
//  NDRoomDetailDocCell.m
//  newdoc
//
//  Created by zzc on 15/10/17.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDRoomDetailDocCell.h"
#import "NDPreserveWindow.h"

@implementation NDRoomDetailDocCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self = [[NSBundle mainBundle] loadNibNamed:@"NDRoomDetailDocCell" owner:nil options: nil][0];
    }
    return self;
}

- (void)setDoctor:(NDDoctor *)doctor{
    _doctor = doctor;
    
    [self.btnHeadImg sd_setImageWithURL:[NSURL URLWithString:doctor.picture_url] forState:UIControlStateNormal];
//    self.btnAttention
//    self.btnGo2Order
    self.lblDocName.text = doctor.name;
    self.lblDocDetail.text = doctor.title;
    self.lblGoodat.text = doctor.goodat;
    NDPreserveWindow *preserveWindow = doctor.preserve_window[0];
    self.lblCanOrder.text = preserveWindow.timescope;
    
    NSMutableString *subrooms = [NSMutableString string];
    for(NDSubroom *subroom in doctor.catalog){
        [NSString stringWithFormat:@"%@、",subroom.name];
    }
    
    self.lblSubroom.text = subrooms;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
