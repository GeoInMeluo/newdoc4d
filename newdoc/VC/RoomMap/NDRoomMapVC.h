//
//  NDRoomMapVC.h
//  newdoc
//
//  Created by zzc on 15/10/15.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDBaseVC.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface NDRoomMapVC : NDBaseVC<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
@property (nonatomic, assign) BOOL isShowList;
@end
