//
//  BaoMingViewController.m
//  AdventureClub
//
//  Created by wang on 16/4/23.
//  Copyright © 2016年 Family. All rights reserved.
//

#import "BaoMingViewController.h"
#import "SDCycleScrollView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MessageUI/MessageUI.h>
@interface BaoMingViewController ()

@end

@implementation BaoMingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"ou.png"]];
    NSLog(@"card%@",_card);
    PFUser *ownerUser=_card[@"user"];
    _name.text=ownerUser.username;
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user=%@",ownerUser];
    PFQuery *query=[PFQuery queryWithClassName:@"Personal" predicate:predicate];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
         PFObject *obj=objects[0];
        PFFile  *jb=obj[@"image"];
        NSString *photoURLStr=jb.url;
        NSLog(@"%@",photoURLStr);
        //获取parse数据库中某个文件的网络路径
        NSURL  *photoURL=[NSURL URLWithString:photoURLStr];
        ////结合SDWebImage通过图片路径来实现异步加载和缓存（本案例中加载到一个图片视图中）
        [_touXiang sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"wei"]];
        
    }];
    NSPredicate *predicate1=[NSPredicate predicateWithFormat:@"acticitie=%@",_card.objectId];
    PFQuery *query1=[PFQuery queryWithClassName:@"Image" predicate:predicate1];
    [query1 findObjectsInBackgroundWithBlock:^(NSArray * _Nullable object, NSError * _Nullable error) {
        PFObject *obj1=object[0];
        PFFile  *jb=obj1[@"image"];
        NSString *photoURLStr=jb.url;
        NSLog(@"%@",photoURLStr);
        //获取parse数据库中某个文件的网络路径
        NSURL  *photoURL=[NSURL URLWithString:photoURLStr];
        ////结合SDWebImage通过图片路径来实现异步加载和缓存（本案例中加载到一个图片视图中）
        [_imageTF sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"jnf"]];
    }];
    _nameTF.text=_card[@"maintitle"];
    _contentTF.text=_card[@"contenttext"];
    
    NSString *pep=[NSString stringWithFormat:@"人数限定：%@",_card[@"people"]];
    _detailsTF.text=pep;
    
    NSDate  *time=_card[@"starttime"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"wuhan"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *day = [dateFormatter stringFromDate:time];
   
    NSString *start=[NSString stringWithFormat:@"活动开始时间：%@",day];
    _startTF.text=start;
    
    NSDate  *endtime=_card[@"starttime"];
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    dateFormatter1.timeZone = [NSTimeZone timeZoneWithName:@"wuhan"];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *day1 = [dateFormatter1 stringFromDate:endtime];
    
    NSString *start1=[NSString stringWithFormat:@"活动结束时间：%@",day1];
    _timeTF.text=start1;
    
    NSString *place=[NSString stringWithFormat:@"活动地点：%@",_card[@"place"]];
    
    _addressTF.text=place;
    NSString *ren=[NSString stringWithFormat:@"活动注意事项：%@",_card[@"requirements"]];
    
   
    _mattersTF.text=ren;
    _phoneTF.text=_card[@"phone"];
    NSString *sigun=[NSString stringWithFormat:@"已报名：%@",_card[@"sigunpPe"]];
    _yibaoming.text=sigun;
    // Do any additional setup after loading the view.
}

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

- (IBAction)phoneAction:(UIButton *)sender forEvent:(UIEvent *)event {
    //该地址字符串将实现先询问是否打电话在根据用户选择去拨打或取消拨打
    NSString *dialStr=[NSString stringWithFormat:@"telprompt://%@",_phoneTF.text];
    //将字符串转化成NSURL对象
    NSURL *dialURL=[NSURL URLWithString:dialStr];
    //用openURL方法执行这个链接的调用（这里是通话功能的调用）
    [[UIApplication sharedApplication]openURL:dialURL];
}

- (IBAction)baoMingAction:(UIBarButtonItem *)sender {
   PFObject *activity = [PFObject objectWithClassName:@"Acticitie"];
    activity.objectId =_card.objectId;
    PFUser *owe=[PFUser currentUser];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user=%@ AND acticitie=%@",owe,activity];
    PFQuery *query=[PFQuery queryWithClassName:@"Apply" predicate:predicate];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        NSInteger  i=objects.count;
        if (0<i) {
           [Utilities popUpAlertViewWithMsg:@"你已经报名过啦，烦请注意活动开始时间" andTitle:nil onView:self];
        }else {
        
            [self hao];
        }
    }];
    
    
    
    
    
}
-(void)hao{
    NSNumber *sig=_card[@"sigunpPe"];
    NSNumber *people=_card[@"people"];
    if ([sig integerValue]<[people integerValue]) {
        PFObject  *he=[PFObject objectWithClassName:@"Apply"];
        PFObject *activity = [PFObject objectWithClassName:@"Acticitie"];
        activity.objectId =_card.objectId;
        he[@"acticitie"]=activity;
        PFUser *cus=[PFUser currentUser];
        he[@"user"]=cus;
        he[@"name"]=@"1";
        [he saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                [Utilities popUpAlertViewWithMsg:@"恭喜您报名成，烦请注意活动开始时间" andTitle:nil onView:self];
                
                NSNumber *click=_card[@"sigunpPe"];
                
                _card[@"sigunpPe"]=@([click integerValue]+1);
               [_card saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                   
               }];
               
            }else {
                NSLog(@"%@",error.userInfo);
                [Utilities popUpAlertViewWithMsg:@"请保持网络畅通" andTitle:nil onView:self];
            }
            
        }];
    }else{
        
        [Utilities popUpAlertViewWithMsg:@"您来慢了，人员已满，敬请关注下次活动" andTitle:nil onView:self];
        
    }


}
@end
