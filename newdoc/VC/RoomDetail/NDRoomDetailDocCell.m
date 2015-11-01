//
//  NDRoomDetailDocCell.m
//  newdoc
//
//  Created by zzc on 15/10/17.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDRoomDetailDocCell.h"
#import "NDPreserveWindow.h"
#import "NDSlot.h"

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
    self.btnAttention.selected = doctor.isFocus;
//    self.btnGo2Order
    self.lblDocName.text = doctor.name;
    self.lblDocDetail.text = [NSString stringWithFormat:@"(%@)",doctor.title];
    self.lblGoodat.text = [NSString stringWithFormat:@"擅长：%@",doctor.goodat];
    NDPreserveWindow *preserveWindow = doctor.preserve_window;
    NDSlot *slot = preserveWindow.slots[0];
    self.lblCanOrder.text = slot.timescope;
    
//    NSMutableString *subrooms = [NSMutableString string];
//    for(NDSubroom *subroom in doctor.catalog){
//        [NSString stringWithFormat:@"%@、",subroom.name];
//    }
    
    NDSubroom *subroom = doctor.catalog[0];
    
    self.lblSubroom.text = [NSString stringWithFormat:@"科室：%@",subroom.name];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
