//
//  HomeViewController.m
//  AdventureClub
//
//  Created by ZengXiangjiang on 16/4/16.
//  Copyright © 2016年 Family. All rights reserved.
//

#import "HomeViewController.h"
#import "SDCycleScrollView.h"
#import "HomeTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface HomeViewController ()<SDCycleScrollViewDelegate>
@property(strong,nonatomic)NSMutableArray *objectsForShow;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _objectsForShow=[NSMutableArray new];
    self.tableView.tableFooterView=[UIView new];
    
   
  [self.sortingControl addTarget:self action:@selector(segmentAction) forControlEvents:UIControlEventValueChanged];
    [self loadingdata];
    [self demoContainerView];
    
}
-(void)segmentAction{
    if (self.sortingControl.selectedSegmentIndex==1){
        
        [self latesttime];
    }



}
-(void)demoContainerView{
    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:0.99];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"005.jpg"]];
    backgroundView.frame = _View1.bounds;
    [_View1 addSubview:backgroundView];
    
    UIScrollView *demoContainerView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    demoContainerView.contentSize = CGSizeMake(_View1.frame.size.width, _View1.frame.size.height);
    [_View1 addSubview:demoContainerView];
    
    
    
    
    NSArray *imageNames = @[@"1",
                            @"2",
                            @"3",
                            @"4",
                            @"5"];
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0, self.view.frame.size.width, 180) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [demoContainerView addSubview:cycleScrollView];


}
//请求数据
-(void)loadingdata{
    PFQuery *query=[PFQuery queryWithClassName:@"Acticitie"];
    UIActivityIndicatorView *aiv=[Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [aiv stopAnimating];
        if (!error) {
            _objectsForShow = [NSMutableArray arrayWithArray:objects];
            [self.tableView reloadData];
        }else{
        [Utilities popUpAlertViewWithMsg:@"请保持网络畅通" andTitle:nil onView:self];
        
        }
    }];
}
//按点击量排序
-(void)reorder{
    [_objectsForShow removeAllObjects];
    PFQuery *query=[PFQuery queryWithClassName:@"Acticitie"];
[query orderByAscending:@"click"];
    UIActivityIndicatorView *aiv=[Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"点击量");
            [aiv stopAnimating];
            _objectsForShow=[NSMutableArray arrayWithArray:objects];
            [self.tableView reloadData];
        }else{
        [Utilities popUpAlertViewWithMsg:@"请保持网络畅通" andTitle:nil onView:self];
        }
    }];

}
//按最新的活动时间排序
-(void)latesttime{
    [_objectsForShow removeAllObjects];
    PFQuery *query=[PFQuery queryWithClassName:@"Acticitie"];
    [query orderByAscending:@"updatedAt"];
    UIActivityIndicatorView *aiv=[Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [aiv stopAnimating];
        if (!error) {
            
            NSLog(@"sdsds");
            _objectsForShow=[NSMutableArray arrayWithArray:objects];
            [self.tableView reloadData];
            
        }else{
        [Utilities popUpAlertViewWithMsg:@"请保持网络畅通" andTitle:nil onView:self];
        
        }
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objectsForShow.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *obj=_objectsForShow[indexPath.row];
    PFFile  *obj1=obj[@"acimage"];
    NSString *photoURLStr=obj1.url;
    
    //获取parse数据库中某个文件的网络路径
    NSURL  *photoURL=[NSURL URLWithString:photoURLStr];
    ////结合SDWebImage通过图片路径来实现异步加载和缓存（本案例中加载到一个图片视图中）
    [cell.imageIV sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"Image"]];
    NSString *content = obj[@"maintitle"];
    NSLog(@"content = %@",content);
    cell.activityNameLbl.text=obj[@"maintitle"];
    cell.textViewTV.text=obj[@"contenttext"];
    NSDate  *time=obj[@"starttime"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"wuhan"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *day = [dateFormatter stringFromDate:time];
    cell.timeLbl.text=day;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
[tableView deselectRowAtIndexPath:indexPath animated:YES];
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
