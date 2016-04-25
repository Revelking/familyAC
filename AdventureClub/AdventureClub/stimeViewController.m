//
//  stimeViewController.m
//  AdventureClub
//
//  Created by ouyang on 16/4/22.
//  Copyright © 2016年 Family. All rights reserved.
//

#import "stimeViewController.h"

@interface stimeViewController ()

@end

@implementation stimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

- (IBAction)qAction:(id)sender forEvent:(UIEvent *)event {
    NSDate *  senddate=[NSDate date];
    //timeIntervalSinceDate: 此方法表示_datePicker.date1与senddate 5时间date间隔 以_datePicker.date为为基准时间
    if ([_dateone.date timeIntervalSinceDate:senddate]<0) {
        [Utilities popUpAlertViewWithMsg:@"选择的日期小于当前日期" andTitle:nil onView:self];
        return;
        
    }
    [[StorageMgr singletonStorageMgr]addKey:@"SignUpSuccessfully" andValue:_dateone.date];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"time" object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
