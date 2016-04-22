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
@interface SheZhiViewController ()

@end

@implementation SheZhiViewController

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
- (IBAction)exitAction:(UIButton *)sender forEvent:(UIEvent *)event {
      [PFUser logOut];
     [[NSNotificationCenter defaultCenter]postNotificationName:@"MenuSwitch" object:nil];
    
}
@end
