//
//  SignUpViewController.m
//  AdventureClub
//
//  Created by ZengXiangjiang on 16/4/16.
//  Copyright © 2016年 Family. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

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

- (IBAction)usernameTF:(UITextField *)sender forEvent:(UIEvent *)event {
}

- (IBAction)ageTF:(UITextField *)sender forEvent:(UIEvent *)event {
}

- (IBAction)genderTF:(UITextField *)sender forEvent:(UIEvent *)event {
}

- (IBAction)telTF:(UITextField *)sender forEvent:(UIEvent *)event {
}

- (IBAction)birthdayTF:(UITextField *)sender forEvent:(UIEvent *)event {
}

- (IBAction)nameTF:(UITextField *)sender forEvent:(UIEvent *)event {
}

- (IBAction)passwordTF:(UITextField *)sender forEvent:(UIEvent *)event {
}

- (IBAction)confirmPasswordTF:(UITextField *)sender forEvent:(UIEvent *)event {
}

- (IBAction)signUpAction:(UIButton *)sender forEvent:(UIEvent *)event {
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
