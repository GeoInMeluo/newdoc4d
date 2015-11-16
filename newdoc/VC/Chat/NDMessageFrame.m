//  newdoc
//
//  Created by zzc on 15/11/6.
//  Copyright © 2015年 zzc. All rights reserved.

#define NDTimeFont [UIFont systemFontOfSize:13]
#define NDTextFont [UIFont systemFontOfSize:15]

#import "NDMessageFrame.h"
#import "NDMessage.h"
#import "NSString+Help.h"

@implementation NDMessageFrame

- (void)setMessage:(NDMessage *)message
{
    _message = message;
    
    // 屏幕的宽度
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    // 间隙
    CGFloat padding = 10;
    
    // 1、 时间
    if (message.isHideTime == NO) { // 需要显示时间，再计算frame
        CGFloat timeX = 0;
        CGFloat timeY = 0;
        CGFloat timeW = screenW;
        CGFloat timeH = 40;
        _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    }
  
    // 2. 头像
    CGFloat iconY = CGRectGetMaxY(_timeF) + padding;
    CGFloat iconW = 40;
    CGFloat iconH = 40;
    CGFloat iconX = 0;
    if (message.type == NDMessageTypeMe) {
        iconX = screenW - padding - iconW;
    }else {
        iconX = padding;
    }
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    
    // 3. 正文
    CGFloat textY = iconY;
    CGSize maxSize = CGSizeMake(200, MAXFLOAT);
    // 按钮里面文字的尺寸
//    CGSize textSize = [NSString sizeWith:message.text andFont:NDTextFont andMaxSize:maxSize];
    CGSize textSize = [message.text sizeWithFont:NDTextFont andMaxSize:maxSize];
    // 按钮真实的尺寸
#define MARGIN 20 // 按钮文字的内边距
    CGSize textBtnSize = CGSizeMake(textSize.width + MARGIN * 2, textSize.height + MARGIN * 2);
    
    CGFloat textX = 0;
    if (message.type == NDMessageTypeOther) {
        textX = CGRectGetMaxX(_iconF) + padding;
    }else{
        textX = iconX - padding - textBtnSize.width;
    }
    _textF = CGRectMake(textX, textY, textBtnSize.width, textBtnSize.height)
    ;
    
    // 4. 行高
    CGFloat textMaxY = CGRectGetMaxY(_textF);
    CGFloat iconMaxY = CGRectGetMaxY(_iconF);
    _cellHeight = MAX(textMaxY, iconMaxY) + padding;
}

@end
