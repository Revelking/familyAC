//
//  HomeViewController.m
//  AdventureClub
//
//  Created by ZengXiangjiang on 16/4/16.
//  Copyright © 2016年 Family. All rights reserved.
//

#import "HomeViewController.h"
#import "SDCycleScrollView.h"
@interface HomeViewController ()<SDCycleScrollViewDelegate>
@property(strong,nonatomic)NSMutableArray *objectsForShow;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadingdata];
    NSArray *imageNames = @[@"1.jpg",
                            @"2.jpg",
                            @"3.jpg",
                            @"4.jpg",
                            @"5.jpg"];
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 180) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [self.tableView.tableHeaderView addSubview:cycleScrollView];
    //self.tableView.tableHeaderView
    // Do any additional setup after loading the view.
}
//请求数据
-(void)loadingdata{
    PFQuery *query=[PFQuery queryWithClassName:@"Activity"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            _objectsForShow=[NSMutableArray arrayWithArray:objects];
            NSLog(@"%@",objects);
        }else{
        [Utilities popUpAlertViewWithMsg:@"请保持网络畅通" andTitle:nil onView:self];
        
        }
    }];
}
//按点击量排序
-(void)reorder{
    PFQuery *query=[PFQuery queryWithClassName:@"Activity"];
[query orderByAscending:@"click"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            _objectsForShow=[NSMutableArray arrayWithArray:objects];
        }else{
        [Utilities popUpAlertViewWithMsg:@"请保持网络畅通" andTitle:nil onView:self];
        }
    }];

}
//按最新的活动时间排序
-(void)latesttime{
    PFQuery *query=[PFQuery queryWithClassName:@"Activity"];
    [query orderByAscending:@"updatedAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            _objectsForShow=[NSMutableArray arrayWithArray:objects];
        }else{
        [Utilities popUpAlertViewWithMsg:@"请保持网络畅通" andTitle:nil onView:self];
        
        }
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _objectsForShow.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *obj=_objectsForShow[indexPath.row];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    PFObject *card=_objectsForShow[indexPath.row];
    NSNumber *click=card[@"click"];
    
   card[@"click"]=@([click integerValue]+1);
  [card saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
      if (succeeded) {
          NSLog(@"增加点击量");
          
      }
  }];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//点击设置会侧滑时调用
- (IBAction)setUpAction:(UIBarButtonItem *)sender {
}

//发布活动按钮
- (IBAction)releaseAction:(UIBarButtonItem *)sender {
}
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}

@end
