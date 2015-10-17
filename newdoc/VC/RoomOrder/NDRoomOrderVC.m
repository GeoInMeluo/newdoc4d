//
//  NDRoomOrderVC.m
//  newdoc
//
//  Created by zzc on 15/10/17.
//  Copyright © 2015年 zzc. All rights reserved.
//

#import "NDRoomOrderVC.h"
#import "NDRoomOrderLabeCell.h"

@interface NDRoomOrderVC ()<UICollectionViewDataSource, UIBarPositioningDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *roomCollectionView;

@end

@implementation NDRoomOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setupUI{
    [self.roomCollectionView registerNib:[UINib nibWithNibName:@"NDRoomOrderLabeCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"NDRoomOrderLabeCell"];
}

//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return 10;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    NDRoomOrderLabeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NDRoomOrderLabeCell" forIndexPath:indexPath];
//    
//    return cell;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
