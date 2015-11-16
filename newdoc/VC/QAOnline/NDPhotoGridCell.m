//
//  NDPhotoGridCell.m
//  newdoc
//
//  Created by zzc on 15/11/12.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDPhotoGridCell.h"

@implementation NDPhotoGridCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self = [[NSBundle mainBundle] loadNibNamed:@"NDPhotoGridCell" owner:nil options:nil] [0];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
