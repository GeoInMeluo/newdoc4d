//
//  NDTalkMessage.h
//  newdoc
//
//  Created by zzc on 15/11/18.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NDTalkMessage : NSObject
/*
 sessionid	咨询id
 poster		发送人id
 poster_name	发送人的名字
 poster_img	发送人的图片url
 */

@property (nonatomic, copy) NSString *sessionid;
@property (nonatomic, copy) NSString *poster;
@property (nonatomic, copy) NSString *poster_name;
@property (nonatomic, copy) NSString *poster_img;
@property (nonatomic, copy) NSString *content;
@end
