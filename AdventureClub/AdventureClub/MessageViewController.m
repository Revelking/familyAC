//
//  MessageViewController.m
//  AdventureClub
//
//  Created by ZengXiangjiang on 16/4/16.
//  Copyright © 2016年 Family. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface MessageViewController ()
@property(strong,nonatomic)NSMutableArray *objectsForShow;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _objectsForShow=[NSMutableArray new];
    [self reques];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)reques{
    PFQuery *query=[PFQuery queryWithClassName:@"Dynamic"];
    [query includeKey:@"user"];
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
@end
