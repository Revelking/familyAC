//
//  MineViewController.m
//  AdventureClub
//
//  Created by ZengXiangjiang on 16/4/16.
//  Copyright © 2016年 Family. All rights reserved.
//

#import "MineViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SignInViewController.h"
#import "MineTableViewCell.h"
#import "DimessViewController.h"
#import "BaoMingViewController.h"
@interface MineViewController ()
@property(strong,nonatomic)NSMutableArray *objectForShow;
@property(strong,nonatomic)NSMutableArray *objectForShow1;
@property(strong,nonatomic)NSString *sty;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _sty=@"0";
    _objectForShow=[NSMutableArray new];
    _objectForShow1=[NSMutableArray new];
    
    [self.segmengCt addTarget:self action:@selector(segmentAction) forControlEvents:UIControlEventValueChanged];
    // Do any additional setup after loading the view.
}
-(void)segmentAction{
    if (self.segmengCt.selectedSegmentIndex==2){
        _sty=@"1";
        [self qingd];
        
    }else if(self.segmengCt.selectedSegmentIndex==0){
    
    _sty=@"0";
        [self reques];
    }else if (self.segmengCt.selectedSegmentIndex==1){
    _sty=@"2";
        [self ggg];
    }

}
-(void)tClick{



}
-(void)ggg{
    [_objectForShow1 removeAllObjects];
    NSLog(@"fdsdfsdfsdfsdf");
    PFUser *cus=[PFUser currentUser];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user=%@",cus];
    PFQuery *query=[PFQuery queryWithClassName:@"Dynamic" predicate:predicate];
    [query includeKey:@"user"];
    [query orderByAscending:@"updatedAt"];
    UIActivityIndicatorView *avi=[Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [avi stopAnimating];
        if (!error) {
           
            _objectForShow1=[NSMutableArray arrayWithArray:objects];
            [_tableView reloadData];
        }else{
            
            [Utilities popUpAlertViewWithMsg:@"请保持网络畅通" andTitle:nil onView:self];
        }
        
    }];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)qingd{
    [_objectForShow1 removeAllObjects];
    PFUser *cus=[PFUser currentUser];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user=%@",cus];
    PFQuery *query=[PFQuery queryWithClassName:@"Apply" predicate:predicate];
    [query includeKey:@"acticitie"];
    [query includeKey:@"acticitie.user"];
    UIActivityIndicatorView *avi=[Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [avi stopAnimating];
        if (!error) {
            _objectForShow1=[NSMutableArray arrayWithArray:objects];
            
            [_tableView reloadData];
        }else {
           
            
                
                [Utilities popUpAlertViewWithMsg:@"请保持网络畅通" andTitle:nil onView:self];
           
        }
    }];
    


}


-(void)reques{
     
    [_objectForShow1 removeAllObjects];
    PFUser *cus=[PFUser currentUser];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user=%@",cus];
    PFQuery *query=[PFQuery queryWithClassName:@"Qcoment" predicate:predicate];
    [query includeKey:@"dynamic"];
    [query includeKey:@"dynamic.user"];
    UIActivityIndicatorView *avi=[Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [avi stopAnimating];
        NSLog(@"走到这里了吗");
        if (!error) {
            NSLog(@"nide%@",objects);
            _objectForShow1=[NSMutableArray arrayWithArray:objects];
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
    return _objectForShow1.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *ob=_objectForShow1[indexPath.row];
    if ([_sty isEqualToString:@"1"]) {
        PFObject *activity1=ob[@"acticitie"];
        cell.mengLb.text=activity1[@"contenttext"];
        
        NSDate *  senddate=activity1[@"starttime"];
        NSDate  *time=senddate;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"wuhan"];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *day = [dateFormatter stringFromDate:time];
        cell.time.text=day;
        
       
        PFObject *image = [PFObject objectWithClassName:@"Acticitie"];
        image.objectId =activity1.objectId;
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"acticitie =%@",image];
        PFQuery *query=[PFQuery queryWithClassName:@"Image" predicate:predicate];
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            NSLog(@"%@",objects);
            if (!error) {
                PFObject *obj=objects[0];
                PFFile  *jb=obj[@"image"];
                NSString *photoURLStr=jb.url;
                NSLog(@"%@",photoURLStr);
                //获取parse数据库中某个文件的网络路径
                NSURL  *photoURL=[NSURL URLWithString:photoURLStr];
                ////结合SDWebImage通过图片路径来实现异步加载和缓存（本案例中加载到一个图片视图中）
                [cell.hdimage sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"jnf"]];
                
                
            }else {
                
                NSLog(@"asdasdsa");
                
            }
        }];
        
        
        
        PFObject *info=activity1[@"user"];
        
        
        
        
        
        //    _name.text=ownerUser.username;
        NSPredicate *predicate1=[NSPredicate predicateWithFormat:@"user=%@",info];
        PFQuery *query1=[PFQuery queryWithClassName:@"Personal" predicate:predicate1];
        [query1 findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            PFObject *obj=objects[0];
            PFFile  *jb=obj[@"image"];
            cell.yhname.text=obj[@"name"];
            NSString *photoURLStr=jb.url;
            //获取parse数据库中某个文件的网络路径
            NSURL  *photoURL=[NSURL URLWithString:photoURLStr];
            ////结合SDWebImage通过图片路径来实现异步加载和缓存（本案例中加载到一个图片视图中）
            [cell.touimage sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"wei"]];
        }];
    }else if([_sty isEqualToString:@"0"]){
        PFObject *activity=ob[@"dynamic"];
        cell.mengLb.text=activity[@"contenttext"];
        
        NSDate *  senddate=activity.updatedAt;
        NSDate  *time=senddate;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"wuhan"];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *day = [dateFormatter stringFromDate:time];
        cell.time.text=day;
        
        
        
        
        NSPredicate *predicat=[NSPredicate predicateWithFormat:@"dynamic=%@",activity];
        PFQuery *quer=[PFQuery queryWithClassName:@"Image" predicate:predicat];
        [quer findObjectsInBackgroundWithBlock:^(NSArray * _Nullable object, NSError * _Nullable error) {
            PFObject  *obj1=object[0];
            PFFile  *jb=obj1[@"image"];
            NSString *photoURLStr=jb.url;
            //获取parse数据库中某个文件的网络路径
            NSURL  *photoURL=[NSURL URLWithString:photoURLStr];
            ////结合SDWebImage通过图片路径来实现异步加载和缓存（本案例中加载到一个图片视图中）
            [cell.hdimage sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"jnf"]];
        }];
        
        
        
        PFObject *info=activity[@"user"];
        
        
        
        NSLog(@"safasf%@",info.objectId);
        
        //    _name.text=ownerUser.username;
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user=%@",info];
        PFQuery *query=[PFQuery queryWithClassName:@"Personal" predicate:predicate];
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            PFObject *obj=objects[0];
            PFFile  *jb=obj[@"image"];
            cell.yhname.text=obj[@"name"];
            NSString *photoURLStr=jb.url;
            //获取parse数据库中某个文件的网络路径
            NSURL  *photoURL=[NSURL URLWithString:photoURLStr];
            ////结合SDWebImage通过图片路径来实现异步加载和缓存（本案例中加载到一个图片视图中）
            [cell.touimage sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"wei"]];
        }];
        
        
        
    }else if ([_sty isEqualToString:@"2"]){
    cell.mengLb.text=ob[@"contenttext"];
        NSDate *  senddate=ob.updatedAt;
        NSDate  *time=senddate;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"wuhan"];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *day = [dateFormatter stringFromDate:time];
        cell.time.text=day;
        
        
        NSPredicate *predicat=[NSPredicate predicateWithFormat:@"dynamic=%@",ob];
        PFQuery *quer=[PFQuery queryWithClassName:@"Image" predicate:predicat];
        [quer findObjectsInBackgroundWithBlock:^(NSArray * _Nullable object, NSError * _Nullable error) {
            PFObject  *obj1=object[0];
            PFFile  *jb=obj1[@"image"];
            NSString *photoURLStr=jb.url;
            //获取parse数据库中某个文件的网络路径
            NSURL  *photoURL=[NSURL URLWithString:photoURLStr];
            ////结合SDWebImage通过图片路径来实现异步加载和缓存（本案例中加载到一个图片视图中）
            [cell.hdimage sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"jnf"]];
        }];
        
        
        PFObject *info=ob[@"user"];
        
        
        
        NSLog(@"safasf%@",info.objectId);
        
        //    _name.text=ownerUser.username;
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user=%@",info];
        PFQuery *query=[PFQuery queryWithClassName:@"Personal" predicate:predicate];
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            PFObject *obj=objects[0];
            PFFile  *jb=obj[@"image"];
            cell.yhname.text=obj[@"name"];
            NSString *photoURLStr=jb.url;
            //获取parse数据库中某个文件的网络路径
            NSURL  *photoURL=[NSURL URLWithString:photoURLStr];
            ////结合SDWebImage通过图片路径来实现异步加载和缓存（本案例中加载到一个图片视图中）
            [cell.touimage sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"wei"]];
        }];
    
    }
    
    
    
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([_sty isEqualToString:@"1"]) {
        UIStoryboard *storybord=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        PFObject *ob=_objectForShow1[indexPath.row];
        PFObject *card=ob[@"acticitie"];
        //更具名称找到名为detailView的页面
        BaoMingViewController *detailView =[storybord instantiateViewControllerWithIdentifier:@"gggg"];
        detailView.card=card;
        [self.navigationController pushViewController:detailView animated:YES];
    }else if([_sty isEqualToString:@"0"]) {
        UIStoryboard *storybord=[UIStoryboard storyboardWithName:@"Storyboard1" bundle:nil];
        PFObject *ob=_objectForShow1[indexPath.row];
        PFObject *card=ob[@"dynamic"];
        //更具名称找到名为detailView的页面
        DimessViewController *detailView =[storybord instantiateViewControllerWithIdentifier:@"dotai"];
        detailView.dimess=card;
        [self.navigationController pushViewController:detailView animated:YES];
    }else if([_sty isEqualToString:@"2"]){
    
        UIStoryboard *storybord=[UIStoryboard storyboardWithName:@"Storyboard1" bundle:nil];
        PFObject *ob=_objectForShow1[indexPath.row];
       
        //更具名称找到名为detailView的页面
        DimessViewController *detailView =[storybord instantiateViewControllerWithIdentifier:@"dotai"];
        detailView.dimess=ob;
        [self.navigationController pushViewController:detailView animated:YES];
    }
    
    
    
}
- (IBAction)fenAction:(UIButton *)sender forEvent:(UIEvent *)event {
}

- (IBAction)guanAction:(id)sender forEvent:(UIEvent *)event {
}
- (IBAction)dengAction:(UIButton *)sender forEvent:(UIEvent *)event {
     SignInViewController *vc=[Utilities getStoryboardInstanceInstance:@"Main" byIdentity:@"deng"];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
//    [self.navigationController presentViewController:vc animated:YES completion:nil];
}
//每次页面数显后
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    PFUser *currentUser=[PFUser currentUser];
    
    if (currentUser) {
        [_anniu setTitle:@"切换" forState:UIControlStateNormal];
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user=%@",currentUser];
        PFQuery *query=[PFQuery queryWithClassName:@"Personal" predicate:predicate];
        UIActivityIndicatorView *avi=[Utilities getCoverOnView:self.view];
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            [avi stopAnimating];
            _objectForShow=[NSMutableArray arrayWithArray:objects];
            NSLog(@"object=%@",objects);
            NSDictionary *dic=objects[0];
            _nameLb.text=dic[@"name"];
            
            PFFile *photoFile=dic[@"image"];
            //获取parse数据库中某个文件的网络路径
            NSString *photoURLStr=photoFile.url;
            NSURL  *photoURL=[NSURL URLWithString:photoURLStr];
            //结合SDWebImage通过图片路径来实现异步加载和缓存（本案例中加载到一个图片视图中）
            [_yongimage sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"wei"]];
        }];
        [self reques];
    }else {
        [_anniu setTitle:@"登录" forState:UIControlStateNormal];
        UIImage *myImage = [UIImage imageNamed:@"wei"];
        _yongimage.image=myImage;
        _nameLb.text=@"尚未登录";
        
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EnableGesture" object:nil];
}

//每次页面消失后
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DisableGesture" object:nil];
}
@end
