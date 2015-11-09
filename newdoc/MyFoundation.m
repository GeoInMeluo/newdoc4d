//
//  MyFoundation.m
//  newdoc
//
//  Created by zzc on 15/10/22.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "MyFoundation.h"
#import <CommonCrypto/CommonCrypto.h>

NSString * MD5_NSString(NSString* s)
{
    if(s.length == 0)
        return @"";
    //	return s;
    const char * cStr = [s UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result);
    NSString * ret = [NSString stringWithFormat:
                      @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                      result[0], result[1], result[2], result[3],
                      result[4], result[5], result[6], result[7],
                      result[8], result[9], result[10], result[11],
                      result[12], result[13], result[14], result[15]
                      ];
    return ret;
}

void ShowAlert(NSString * text)
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:text delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
    [alert show];
}

NSString * SafeString(NSString * s)
{
    if(s == nil)
        return @"";
    return s;
}

NSValue * SafeValue(NSValue * value){
    if(value == nil){
        return [NSValue new];
    }
    return value;
}

NSNumber * SafeNumber(NSNumber * n){
    if(n == nil){
        return [NSNumber new];
    }
    return n;
}