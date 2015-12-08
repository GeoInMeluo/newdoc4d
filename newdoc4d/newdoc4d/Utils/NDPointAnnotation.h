//
//  NDPointAnnotation.h
//  newdoc
//
//  Created by zzc on 15/10/27.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "NDRoom.h"

@interface NDPointAnnotation : BMKPointAnnotation
@property (nonatomic, strong) NDRoom *room;
@end
