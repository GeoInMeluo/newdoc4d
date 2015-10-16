//
//  NDRoomAnnotationPopView.m
//  newdoc
//
//  Created by zzc on 15/10/16.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDRoomAnnotationPopView.h"

@implementation NDRoomAnnotationPopView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self = [[NSBundle mainBundle] loadNibNamed:@"NDRoomAnnotationPopView" owner:nil options:nil][0];
    }
    return self;
}
@end
