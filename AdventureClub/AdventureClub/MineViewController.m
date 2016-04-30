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
@interface MineViewController ()
@property(strong,nonatomic)NSMutableArray *objectForShow;
@property(strong,nonatomic)NSMutableArray *objectForShow1;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _objectForShow=[NSMutableArray new];
    _objectForShow1=[NSMutableArray new];
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
            [_yongimage sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"Image"]];
            }];
    
    }else {
       [_anniu setTitle:@"登入" forState:UIControlStateNormal];
        UIImage *myImage = [UIImage imageNamed:@"wei"];
        _yongimage.image=myImage;
        _nameLb.text=@"尚未登入";
        
    
    }
[self reques];
    // Do any additional setup after loading the view.
}
-(void)tClick{



}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)reques{
     NSLog(@"走到这里了吗dsd");
    
    PFUser *cus=[PFUser currentUser];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user=%@",cus];
    PFQuery *query=[PFQuery queryWithClassName:@"Qcoment" predicate:predicate];
    [query includeKey:@"dynamic"];
    [query includeKey:@"dynamic.user"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
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
    
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *storybord=[UIStoryboard storyboardWithName:@"Storyboard1" bundle:nil];
    PFObject *ob=_objectForShow1[indexPath.row];
    PFObject *card=ob[@"dynamic"];
    //更具名称找到名为detailView的页面
    DimessViewController *detailView =[storybord instantiateViewControllerWithIdentifier:@"dotai"];
    detailView.dimess=card;
    [self.navigationController pushViewController:detailView animated:YES];
    
    
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
@end
