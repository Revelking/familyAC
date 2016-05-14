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
#import "KSGuideManager.h"
#import "BaoMingViewController.h"
#import "ShiPingViewController.h"
@interface HomeViewController ()<SDCycleScrollViewDelegate,ActivityTableViewCellDelegate>
@property(strong,nonatomic)NSMutableArray *objectsForShow;
@property(strong,nonatomic)NSMutableArray *acg;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self app];
    _objectsForShow=[NSMutableArray new];
    _acg=[NSMutableArray new];
    self.tableView.tableFooterView=[UIView new];
    ;
   
  [self.sortingControl addTarget:self action:@selector(segmentAction) forControlEvents:UIControlEventValueChanged];
    [self loadingdata];
    [self demoContainerView];
    
    
   
//    self.view.backgroundColor=[UIColor greenColor];
   
//    UIColor *myTint = [[ UIColor alloc]initWithRed:0.66 green:1.0 blue:0.77 alpha:1.0];
//    _sortingControl.tintColor = myTint;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tishi) name:@"tis" object:nil];
    UIRefreshControl *rc=[[UIRefreshControl alloc]init];
    
    rc.tag=10001;
    rc.tintColor=[UIColor darkGrayColor];
    [rc addTarget:self action:@selector(loadingdata) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:rc];
    
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:24],NSFontAttributeName,nil];
//    
//    [self.sortingControl setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    
    self.sortingControl.momentary = YES;
    
    [self.sortingControl setBackgroundImage:[UIImage imageNamed:@"tt"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.sortingControl setBackgroundImage:[UIImage imageNamed:@"tt"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
   
    
}
-(void)tishi{
    [Utilities popUpAlertViewWithMsg:@"已经退出当前用户" andTitle:nil onView:self];
    PFUser *cur=[PFUser currentUser];
    if (cur) {
        _dengru.title=@"已登录";
        
    }else {
        
        _dengru.title=@"未登录";
        
        
    }


}
//app的引导页
-(void)app{
    
    NSMutableArray *paths = [NSMutableArray new];
    
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"8" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"9" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"10" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"11" ofType:@"jpg"]];
    
    [[KSGuideManager shared] showGuideViewWithImages:paths];
    
}
-(void)segmentAction{
    if (self.sortingControl.selectedSegmentIndex==3){
        //跳转到视频页面
        UIStoryboard *storybord=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        //更具名称找到名为detailView的页面
        ShiPingViewController *detailView =[storybord instantiateViewControllerWithIdentifier:@"shi"];
        
        [self.navigationController pushViewController:detailView animated:YES];
        
        
    }else if (self.sortingControl.selectedSegmentIndex==1)
    {
        [self reorder];
     
    }else if (self.sortingControl.selectedSegmentIndex==2){
    
        [self latesttime];
        //设置在点击后是否恢复原样
        
    }



}

//轮播
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
    [_objectsForShow removeAllObjects];
    [_acg removeAllObjects];
    PFQuery *query=[PFQuery queryWithClassName:@"Acticitie"];
    UIActivityIndicatorView *aiv=[Utilities getCoverOnView:self.view];
    [query includeKey:@"user"];
    NSDate * date=[NSDate date];
    [query whereKey:@"starttime" greaterThanOrEqualTo:date];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [aiv stopAnimating];
        
        if (!error) {
            _acg=[NSMutableArray arrayWithArray:objects];
            for(PFObject *bji in objects) {
                
                NSPredicate *predicate=[NSPredicate predicateWithFormat:@"acticitie =%@",bji];
                PFQuery *query=[PFQuery queryWithClassName:@"Image" predicate:predicate];
                NSArray *object = [query findObjects];
                NSLog(@"这个方法执行了吗%@",object);
                    if (!error) {
                        PFObject *obj=object[0];
                        PFFile  *jb=obj[@"image"];
                        NSString *photoURLStr=jb.url;
                        NSDictionary *dict=@{@"name":bji[@"maintitle"],@"contenttext":bji[@"contenttext"],@"time":bji[@"starttime"],@"image":photoURLStr};
                        [_objectsForShow addObject:dict];
                        [self.tableView reloadData];
                    }
                
            }
        }else{
            [Utilities popUpAlertViewWithMsg:@"请保持网络畅通" andTitle:nil onView:self];
            
        }
    }];
}
//按点击量排序
-(void)reorder{
    [_objectsForShow removeAllObjects];
    [_acg removeAllObjects];
    PFQuery *query=[PFQuery queryWithClassName:@"Acticitie"];
    [query includeKey:@"user"];
    [query orderByDescending:@"click"];
    NSDate * date=[NSDate date];
    [query whereKey:@"starttime" greaterThanOrEqualTo:date];
    UIActivityIndicatorView *aiv=[Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [aiv stopAnimating];
        
        if (!error) {
            _acg=[NSMutableArray arrayWithArray:objects];
            for(PFObject *bji in objects) {
                
                NSPredicate *predicate=[NSPredicate predicateWithFormat:@"acticitie =%@",bji];
                PFQuery *query=[PFQuery queryWithClassName:@"Image" predicate:predicate];
                NSArray *object = [query findObjects];
                NSLog(@"这个方法执行了吗%@",object);
                if (!error) {
                    PFObject *obj=object[0];
                    PFFile  *jb=obj[@"image"];
                    NSString *photoURLStr=jb.url;
                    NSDictionary *dict=@{@"name":bji[@"maintitle"],@"contenttext":bji[@"contenttext"],@"time":bji[@"starttime"],@"image":photoURLStr};
                    [_objectsForShow addObject:dict];
                    [self.tableView reloadData];
                }
                
            }
        }else{
            [Utilities popUpAlertViewWithMsg:@"请保持网络畅通" andTitle:nil onView:self];
            
        }
    }];

}
//按最新的活动时间排序
-(void)latesttime{
    [_objectsForShow removeAllObjects];
    [_acg removeAllObjects];
    PFQuery *query=[PFQuery queryWithClassName:@"Acticitie"];
    [query includeKey:@"user"];
    [query orderByDescending:@"starttime"];
    NSDate * date=[NSDate date];
    [query whereKey:@"starttime" greaterThanOrEqualTo:date];
    UIActivityIndicatorView *aiv=[Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [aiv stopAnimating];
        
        if (!error) {
            _acg=[NSMutableArray arrayWithArray:objects];
            for(PFObject *bji in objects) {
                
                NSPredicate *predicate=[NSPredicate predicateWithFormat:@"acticitie =%@",bji];
                PFQuery *query=[PFQuery queryWithClassName:@"Image" predicate:predicate];
                NSArray *object = [query findObjects];
                NSLog(@"这个方法执行了吗%@",object);
                if (!error) {
                    PFObject *obj=object[0];
                    PFFile  *jb=obj[@"image"];
                    NSString *photoURLStr=jb.url;
                    NSDictionary *dict=@{@"name":bji[@"maintitle"],@"contenttext":bji[@"contenttext"],@"time":bji[@"starttime"],@"image":photoURLStr};
                    [_objectsForShow addObject:dict];
                    [self.tableView reloadData];
                }
                
            }
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
    HomeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.delegate=self;
    
    cell.indexPath=indexPath;
    PFObject *obj=_objectsForShow[indexPath.row];
    
                //获取parse数据库中某个文件的网络路径
            NSURL  *photoURL=[NSURL URLWithString:obj[@"image"]];
            ////结合SDWebImage通过图片路径来实现异步加载和缓存（本案例中加载到一个图片视图中）
            [cell.imageIV sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"jnf"]];
                
            
    
    
    
//    PFFile  *obj1=obj[@"acimage"];
//    NSString *photoURLStr=obj1.url;
//    
//    //获取parse数据库中某个文件的网络路径
//    NSURL  *photoURL=[NSURL URLWithString:photoURLStr];
//    ////结合SDWebImage通过图片路径来实现异步加载和缓存（本案例中加载到一个图片视图中）
//    [cell.imageIV sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"Image"]];
    NSString *content = obj[@"name"];
    NSLog(@"content = %@",content);
    cell.activityNameLbl.text=obj[@"name"];
    cell.textViewTV.text=obj[@"contenttext"];
    NSDate  *time=obj[@"time"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"wuhan"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *day = [dateFormatter stringFromDate:time];
    cell.timeLbl.text=day;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
[tableView deselectRowAtIndexPath:indexPath animated:YES];
    PFObject *card=_acg[indexPath.row];
    NSNumber *click=card[@"click"];
    
   card[@"click"]=@([click integerValue]+1);
    
//    PFObject *image = [PFObject objectWithClassName:@"Acticitie"];
//    image.objectId =card[@"objectId"];
//    NSInteger *click=image[@"click"];
//    image[@"click"]=@([click integerValue]+1);
  [card saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
      if (succeeded) {
          NSLog(@"增加点击量");
          
      }
  }];

}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"cell"]) {
        //获得当前用户选中细胞的行数
        NSIndexPath *indexPath=_tableView.indexPathForSelectedRow;
        //根据上述行数获取该行所对应的数据
        PFObject *card=_acg[indexPath.row];
        //segue.destinationViewController 获取将要跳转的下一页的事例
        BaoMingViewController *mcvc=segue.destinationViewController;
        //将需要传递给下一页的数据放入下一页容器
        mcvc.card=card;
        
    }
}


//点击设置会侧滑时调用
- (IBAction)setUpAction:(UIBarButtonItem *)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"MenuSwitch" object:nil];
    
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
- (void)photoTapAtIndexPath:(NSIndexPath *)indexPath{
    //UIScreen mainScreen是获取屏幕的实例（全屏显示）
    _zoomIV = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //激活用户交互功能
    _zoomIV.userInteractionEnabled = YES;
    _zoomIV.backgroundColor = [UIColor blackColor];
    
    
    PFObject *obj=_objectsForShow[indexPath.row];
    
    
    
    
                NSString *photoURLStr=obj[@"image"];;
               
    
                NSURL  *photoURL=[NSURL URLWithString:photoURLStr];
                ////结合SDWebImage通过图片路径来实现异步加载和缓存（本案例中加载到一个图片视图中）
                [_zoomIV sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"jnf"]];
    
    
    
    
    
    
    
    
    
    
//    //UIScreen mainScreen是获取屏幕的实例（全屏显示）
//    _zoomIV = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    //激活用户交互功能
//    _zoomIV.userInteractionEnabled = YES;
//    _zoomIV.backgroundColor = [UIColor blackColor];
    
/*
    PFObject *obj=_objectsForShow[indexPath.row];
    
    PFFile  *obj1=obj[@"acimage"];
    NSString *photoURLStr=obj1.url;
    
    //获取parse数据库中某个文件的网络路径
    NSURL  *photoURL=[NSURL URLWithString:photoURLStr];
    ////结合SDWebImage通过图片路径来实现异步加载和缓存（本案例中加载到一个图片视图中）
    [_zoomIV sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"Image"]];
    */
    
    ////使用SD所写的这一行代码，看似比我们上面注释掉的那一行代码复杂，但是我们上面自己写的那一行代码执行的是同步加载，而SD执行的是异步加载，同步加载在加载过程中会锁死页面而异步不会
    //    [_zoomIV sd_setImageWithURL:[NSURL URLWithString:activity.imgUrl] placeholderImage:[UIImage imageNamed:@"Image"]];
    // _zoomIV.image = [self imageUrl:activity.imgUrl];
    //短边撑满，等比缩放
    _zoomIV.contentMode = UIViewContentModeScaleAspectFit;
    //[UIApplication sharedApplication]获得当前App的实例，keyWindow方法可以拿到App实例的主窗口
    [[UIApplication sharedApplication].keyWindow addSubview:_zoomIV];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomTap:)];
    [_zoomIV addGestureRecognizer:tap];
}
- (void)zoomTap:(UITapGestureRecognizer *)sender{
    NSLog(@"要缩小");
    if (sender.state == UIGestureRecognizerStateRecognized) {
        [_zoomIV removeFromSuperview];
        [_zoomIV removeGestureRecognizer:sender];
        _zoomIV = nil;
    }
    
}

//每次页面数显后
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    PFUser *cur=[PFUser currentUser];
    if (cur) {
        _dengru.title=@"已登录";
        
    }else {
        
        _dengru.title=@"未登录";
        
        
    }
   
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EnableGesture" object:nil];
}

//每次页面消失后
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DisableGesture" object:nil];
}

@end
