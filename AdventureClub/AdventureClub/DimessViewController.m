//
//  DimessViewController.m
//  AdventureClub
//
//  Created by ouyang on 16/4/25.
//  Copyright © 2016年 Family. All rights reserved.
//

#import "DimessViewController.h"

@interface DimessViewController ()

@end

@implementation DimessViewController

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

- (IBAction)zanAction:(UIButton *)sender forEvent:(UIEvent *)event {
}
- (IBAction)caiAction:(UIButton *)sender forEvent:(UIEvent *)event {
}
- (IBAction)pinLunAction:(UIButton *)sender forEvent:(UIEvent *)event {
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
