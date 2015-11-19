//  newdoc
//
//  Created by zzc on 15/11/6.
//  Copyright © 2015年 zzc. All rights reserved.

#import <Foundation/Foundation.h>

typedef enum {
    NDMessageTypeMe = 0, // 自己发的
    NDMessageTypeOther // 别人发的
}NDMessageType;

@interface NDMessage : NSObject
/*
 *  头像
 */
@property (nonatomic, copy) NSString *icon_url;

/**
 *  聊天内容
 */
@property (nonatomic,copy)NSString * text;

/**
 *  发送时间
 */
@property (nonatomic,copy)NSString * time;

/**
 *  消息的类型
 */
@property (nonatomic,assign)NDMessageType type;

/**
 *  是否需要隐藏时间
 */
@property (nonatomic, assign, getter = isHideTime) BOOL hideTime;

+ (instancetype)messageWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
