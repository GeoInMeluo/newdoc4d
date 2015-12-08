//  newdoc
//
//  Created by zzc on 15/11/6.
//  Copyright © 2015年 zzc. All rights reserved.

#import <Foundation/Foundation.h>
@class NDMessage;

@interface NDMessageFrame : NSObject

/**
 *  小的模型
 */
@property (nonatomic, strong) NDMessage *message;
/**
 *  时间的frame
 */
@property (nonatomic, assign) CGRect timeF;
/**
 *  头像的frame
 */
@property (nonatomic, assign) CGRect iconF;

/**
 *  正文的frame
 */
@property (nonatomic, assign) CGRect textF;

/**
 *  行高
 */
@property (nonatomic, assign) CGFloat cellHeight;


@end
