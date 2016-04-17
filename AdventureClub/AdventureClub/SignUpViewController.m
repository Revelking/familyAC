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

//当用户点击确认注册按钮后调用
- (IBAction)signUpAction:(UIButton *)sender forEvent:(UIEvent *)event {
    NSString *username = _usernameTF.text;
    NSString *email = _emailTF.text;
    NSString *phone=_phoneTF.text;
    NSString *password = _passwordTF.text;
    NSString *confirmPassword = _confirmPasswordTF.text;
    
    if (username.length == 0 || email.length == 0 || password.length == 0 || confirmPassword.length == 0) {
        [Utilities popUpAlertViewWithMsg:@"内容为空，请输入完整" andTitle:nil onView:self];
        return;
    }
    if (![password isEqualToString:confirmPassword]) {
        [Utilities popUpAlertViewWithMsg:@"密码不相同，请重新输入" andTitle:nil onView:self];
        return;
    }
     PFUser *user = [PFUser user];
    user.username = username;
    user.email = email;
    user.password = password;
    user[@"phone"]=phone;
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error){
        if (!error) {
           
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ac=[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self .navigationController popViewControllerAnimated:YES];
            } ];
           
            [alertView addAction:ac];
           
            [self  presentViewController:alertView animated:YES completion:nil];

        }else {
            switch (error.code) {
                case 202:
                    [Utilities popUpAlertViewWithMsg:@"该用户名已被使用" andTitle:nil onView:self];
                    break;
                case 203:
                    [Utilities popUpAlertViewWithMsg:@"该电子邮箱已被使用" andTitle:nil onView:self];
                    break;
                case 100:
                    [Utilities popUpAlertViewWithMsg:@"网络不给力，请稍后再试" andTitle:nil onView:self];
                    break;
                case 125:
                    [Utilities popUpAlertViewWithMsg:@"该电子邮箱不存在" andTitle:nil onView:self];
                    break;
                default:
                    [Utilities popUpAlertViewWithMsg:@"服务器正在维护，请稍后再试" andTitle:nil onView:self];
                    break;
            }
        
        }
    }];
    
    
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
