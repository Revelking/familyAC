//
//  FaBuViewController.m
//  AdventureClub
//
//  Created by ZengXiangjiang on 16/4/18.
//  Copyright © 2016年 Family. All rights reserved.
//

#import "FaBuViewController.h"
#import "stimeViewController.h"

@interface FaBuViewController ()


@end

@implementation FaBuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}
//每次页面出现时
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   NSDate *useName=[[StorageMgr singletonStorageMgr]objectForKey:@"SignUpSuccessfully"];
    NSLog(@"usenmame%@",useName);
    NSDate  *time=useName;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"wuhan"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *day = [dateFormatter stringFromDate:time];
    _jieShuTimeLbl.text=day;
    [[StorageMgr singletonStorageMgr]removeObjectForKey:@"SignUpSuccessfully"];
    
   
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

//发帖（发布活动）按钮
- (IBAction)faBuAction:(UIBarButtonItem *)sender {
    
}

//开始时间按钮
- (IBAction)kaiShiTimeAction:(UIButton *)sender forEvent:(UIEvent *)event {
    
}

//结束时间按钮
- (IBAction)jieShuTimeAction:(UIButton *)sender forEvent:(UIEvent *)event {
}

//当键盘右下角的确认按钮被按时收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

//点击空白处收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
