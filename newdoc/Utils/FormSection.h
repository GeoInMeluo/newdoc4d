//
//  FormSection.h
//  newdoc
//
//  Created by zzc on 15/11/5.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormSection : NSObject
@property(nonatomic,strong) UIView * headerView;
@property(nonatomic,strong) UIView * footerView;
@property(nonatomic,strong) NSMutableArray * cells;
@end
