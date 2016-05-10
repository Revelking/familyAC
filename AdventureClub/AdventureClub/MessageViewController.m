//
//  MessageViewController.m
//  AdventureClub
//
//  Created by ZengXiangjiang on 16/4/16.
//  Copyright © 2016年 Family. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "DimessViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface MessageViewController ()
@property(strong,nonatomic)NSMutableArray *objectsForShow;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _objectsForShow=[NSMutableArray new];
    [self.segmeng addTarget:self action:@selector(segmentAction) forControlEvents:UIControlEventValueChanged];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reques) name:@"namehome" object:nil];
    [self reques];
    
    UIRefreshControl *rc=[[UIRefreshControl alloc]init];
    
    rc.tag=10001;
    rc.tintColor=[UIColor darkGrayColor];
    [rc addTarget:self action:@selector(reques) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:rc];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)segmentAction{
    if (self.segmeng.selectedSegmentIndex==1){
        
    [_objectsForShow removeAllObjects];
    PFQuery *query=[PFQuery queryWithClassName:@"Dynamic"];
    [query includeKey:@"user"];
    [query orderByAscending:@"click"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"活动的详情页%@",objects);
            _objectsForShow=[NSMutableArray arrayWithArray:objects];
            [_tableView reloadData];
        }else{
            
            [Utilities popUpAlertViewWithMsg:@"请保持网络畅通" andTitle:nil onView:self];
        }
        
    }];
    }

}
-(void)reques{
    [_objectsForShow removeAllObjects];
    PFQuery *query=[PFQuery queryWithClassName:@"Dynamic"];
    [query includeKey:@"user"];
    [query orderByAscending:@"updatedAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        UIRefreshControl *rc=(UIRefreshControl *)[self.tableView viewWithTag:10001];
        [rc endRefreshing];
        if (!error) {
            NSLog(@"活动的详情页%@",objects);
            _objectsForShow=[NSMutableArray arrayWithArray:objects];
            [_tableView reloadData];
        }else{
        
         [Utilities popUpAlertViewWithMsg:@"请保持网络畅通" andTitle:nil onView:self];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objectsForShow.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *ob=_objectsForShow[indexPath.row];
    PFUser *user=ob[@"user"];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user=%@",user];
    PFQuery *query=[PFQuery queryWithClassName:@"Personal" predicate:predicate];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        PFObject *obj=objects[0];
        PFFile  *jb=obj[@"image"];
        NSString *photoURLStr=jb.url;
        NSLog(@"用户有吗%@",photoURLStr);
        //获取parse数据库中某个文件的网络路径
        NSURL  *photoURL=[NSURL URLWithString:photoURLStr];
        ////结合SDWebImage通过图片路径来实现异步加载和缓存（本案例中加载到一个图片视图中）
        [cell.toux sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"wei"]];
        cell.yonghuLb.text=obj[@"name"];
    }];
    cell.mentLB.text=ob[@"contenttext"];
    NSString *cai=[NSString stringWithFormat:@"踩：%@",ob[@"stepon"]];
    cell.caiLb.text=cai;
     NSString *czai=[NSString stringWithFormat:@"赞：%@",ob[@"praise"]];
    cell.zaiLb.text=czai;
    
    PFObject *activity = [PFObject objectWithClassName:@"Dynamic"];
    activity.objectId =ob.objectId;
    NSPredicate *predicat=[NSPredicate predicateWithFormat:@"dynamic=%@",activity];
    PFQuery *quer=[PFQuery queryWithClassName:@"Comments" predicate:predicat];
    [quer findObjectsInBackgroundWithBlock:^(NSArray * _Nullable object, NSError * _Nullable error) {
         NSInteger  i=object.count;
        if (i<0) {
            cell.renshuLb.text=@"发表数：0";
        }else {
            cell.renshuLb.text=[NSString stringWithFormat:@"发表数：%ld",(long)i];
        
        }
    }];
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
    UIStoryboard *storybord=[UIStoryboard storyboardWithName:@"Storyboard1" bundle:nil];
    //更具名称找到名为detailView的页面
    DimessViewController *detailView =[storybord instantiateViewControllerWithIdentifier:@"dotai"];
    detailView.dimess=card;
[self.navigationController pushViewController:detailView animated:YES];
}
//每次页面数显后
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EnableGesture" object:nil];
}

//每次页面消失后
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DisableGesture" object:nil];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PFObject * obj = [_objectsForShow objectAtIndex:indexPath.row];
    
    NSString *str = obj[@"contenttext"];
    
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    CGSize maxSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width - 30, 1000);
    CGSize contentLabelSize = [str boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:cell.mentLB.font} context:nil].size;
    return cell.mentLB.frame.origin.y+15 + contentLabelSize.height+25;
}

@end
