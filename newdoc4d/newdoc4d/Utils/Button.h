//
//  BkButtonDefault.h
//  qiba2
//

#import <UIKit/UIKit.h>

@class Button;

typedef void(^ButtonCallback)(Button* sender);

@interface Button : UIButton
@property(nonatomic,strong) ButtonCallback callback;
@property(nonatomic,strong) id data;

-(void)__init;
@end
