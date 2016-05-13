//
//  SheZhiViewController.m
//  AdventureClub
//
//  Created by ZengXiangjiang on 16/4/18.
//  Copyright © 2016年 Family. All rights reserved.
//

#import "SheZhiViewController.h"
#import "PersonalViewController.h"
#import "TheMessageViewController.h"
#import "resetpasswordViewController.h"
#import "SDCycleScrollView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SignInViewController.h"
#import "GuanYuWoMenViewController.h"
@interface SheZhiViewController ()

@end

@implementation SheZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Q.png"]];
    _imageV.userInteractionEnabled=YES;
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *singleRecognizer3;
    singleRecognizer3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photo)];
    singleRecognizer3.numberOfTapsRequired=1;
    [_imageV  addGestureRecognizer:singleRecognizer3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//每次页面数显后
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    PFUser *currentUser=[PFUser currentUser];
    
    if (currentUser) {
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user=%@",currentUser];
        PFQuery *query=[PFQuery queryWithClassName:@"Personal" predicate:predicate];
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            
            
            NSDictionary *dic=objects[0];
            _nameLb.text=dic[@"name"];
            
            _gexing.text=dic[@"signature"];
            PFFile *photoFile=dic[@"image"];
            //获取parse数据库中某个文件的网络路径
            NSString *photoURLStr=photoFile.url;
            NSURL  *photoURL=[NSURL URLWithString:photoURLStr];
            //结合SDWebImage通过图片路径来实现异步加载和缓存（本案例中加载到一个图片视图中）
            [_imageV sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"jnf"]];
            
        }];
        
    }else {
        UIImage *myImage = [UIImage imageNamed:@"wei"];
        _imageV.image=myImage;
        _nameLb.text=@"尚未登入";
        _gexing.text=@"       ";
        
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)exitAction:(UIButton *)sender forEvent:(UIEvent *)event {
    PFUser *curee=[PFUser currentUser];
    if (curee) {
        [PFUser logOut];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"MenuSwitch" object:nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"tis" object:nil];
    }else {
        [Utilities popUpAlertViewWithMsg:@"并未登入" andTitle:nil onView:self];
    
    }
    
}
- (void)photo{
    PFUser  *cuerr=[PFUser currentUser];
    if (cuerr) {
        //UIScreen mainScreen是获取屏幕的实例（全屏显示）
        _zoomIV = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        //激活用户交互功能
        _zoomIV.userInteractionEnabled = YES;
        _zoomIV.backgroundColor = [UIColor blackColor];
        
        _zoomIV.image=_imageV.image;
        
        _zoomIV.contentMode = UIViewContentModeScaleAspectFit;
        //[UIApplication sharedApplication]获得当前App的实例，keyWindow方法可以拿到App实例的主窗口
        [[UIApplication sharedApplication].keyWindow addSubview:_zoomIV];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomTap:)];
        [_zoomIV addGestureRecognizer:tap];
    }else{
        NSLog(@"游泳吗");
        [self performSegueWithIdentifier:@"xian" sender:self];
       // SignInViewController *vc=[Utilities getStoryboardInstanceInstance:@"Main" byIdentity:@"deng"];
        //[self.navigationController presentViewController:vc animated:YES completion:nil];
    }
    
    
    
    
   
}
- (void)zoomTap:(UITapGestureRecognizer *)sender{
    NSLog(@"要缩小");
    if (sender.state == UIGestureRecognizerStateRecognized) {
        [_zoomIV removeFromSuperview];
        [_zoomIV removeGestureRecognizer:sender];
        _zoomIV = nil;
    }
    
}


- (IBAction)ganyu:(id)sender forEvent:(UIEvent *)event {
    UIStoryboard *storybord=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NSLog(@"sadsad");
    
    //更具名称找到名为detailView的页面
    GuanYuWoMenViewController *detailView =[storybord instantiateViewControllerWithIdentifier:@"uio"];
    
    [self.navigationController presentViewController:detailView animated:YES completion:nil];
}
@end
