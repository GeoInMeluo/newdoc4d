//
//  NDRoomMapVC.m
//  newdoc
//
//  Created by zzc on 15/10/15.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDRoomMapVC.h"
#import "NDBaseNavVC.h"
#import "NDRoomSelectVC.h"

@interface NDRoomMapVC ()

@property (nonatomic, weak) IBOutlet BMKMapView* mapView;
@property (nonatomic, strong) NDRoomSelectVC *selectVC;
@property (weak, nonatomic) IBOutlet UIView *searchDiv;

@end

@implementation NDRoomMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"预约挂号";
    
    [self setupUI];
}

- (void)setupUI{
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"map_rightBtn"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.searchDiv.layer.cornerRadius = 5;
    self.searchDiv.layer.masksToBounds = YES;

    //     添加一个PointAnnotation
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = 39.915;
    coor.longitude = 116.404;
    annotation.coordinate = coor;
    annotation.title = @"这里是北京";
    [_mapView addAnnotation:annotation];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _mapView.delegate = self;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NDRoomSelectVC *selectVC = [NDRoomSelectVC new];
    selectVC.tableView.frame = _mapView.frame;
    [self.view addSubview:selectVC.tableView];
    selectVC.view.hidden = YES;
    
    self.selectVC = selectVC;
}

// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
//        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
//        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
//        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
//        return newAnnotationView;
        
        BMKPinAnnotationView *newAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        // 设置颜色
        newAnnotation.pinColor = BMKPinAnnotationColorPurple;
        // 从天上掉下效果
        newAnnotation.animatesDrop = YES;
        // 设置可拖拽
        newAnnotation.draggable = YES;
        //设置大头针图标
        newAnnotation.image = [UIImage imageNamed:@"zhaohuoche"]; UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 60)];
        //设置弹出气泡图片
        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wenzi"]]; image.frame = CGRectMake(0, 0, 100, 60); [popView addSubview:image];
        //自定义显示的内容
        UILabel *driverName = [[UILabel alloc]initWithFrame:CGRectMake(0, 3, 100, 20)];
        driverName.text = @"张XX师傅";
        driverName.backgroundColor = [UIColor clearColor];
        driverName.font = [UIFont systemFontOfSize:14];
        driverName.textColor = [UIColor whiteColor];
        driverName.textAlignment = NSTextAlignmentCenter;
        [popView addSubview:driverName];
        UILabel *carName = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, 100, 20)];
        carName.text = @"京A123456"; carName.backgroundColor = [UIColor clearColor];
        carName.font = [UIFont systemFontOfSize:14];
        carName.textColor = [UIColor whiteColor];
        carName.textAlignment = NSTextAlignmentCenter;
        [popView addSubview:carName];
        BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc]initWithCustomView:popView];
        pView.frame = CGRectMake(0, 0, 100, 60);
        ((BMKPinAnnotationView*)newAnnotation).paopaoView = nil;
        ((BMKPinAnnotationView*)newAnnotation).paopaoView = pView;

        return newAnnotation;
        
    }
    return nil;

}

//- (UIButton *)rightView{
//    UIButton *btn = [UIButton new];
//    [btn setImage:[UIImage imageNamed:@"map_rightBtn"] forState:UIControlStateNormal];
//    [btn sizeToFit];
//    [btn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    return btn;
//}

- (void)rightBtnClicked:(UIButton *)btn{
    btn.selected = !btn.selected;
    
    if(btn.selected){
        self.selectVC.tableView.hidden = NO;
        
        [BMKMapView willBackGround];
    }else{
        [BMKMapView didForeGround];
        
        self.selectVC.tableView.hidden = YES;
    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    
    self.selectVC = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
