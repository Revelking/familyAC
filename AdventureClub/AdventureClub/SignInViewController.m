//
//  SignInViewController.m
//  AdventureClub
//
//  Created by ZengXiangjiang on 16/4/16.
//  Copyright © 2016年 Family. All rights reserved.
//

#import "SignInViewController.h"
#import "resetpasswordViewController.h"
@interface SignInViewController ()

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
//每次这个页面出现的时候都会调用这个方法，并且这个时机点事页面将要出现之前
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //判断是否记忆了用户名
    if (![[Utilities getUserDefaults:@"Username"] isKindOfClass:[NSNull class]]) {
        //如果有记忆就把记忆显示在用户名文本输入框中
        _usernameTF.text = [Utilities getUserDefaults:@"Username"];
    }
}
//每次这个页面出现的时候都会调用这个方法，并且这个时机点事页面已然出现后
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}
//封装登录操作
- (void)signInWithUsername:(NSString *)username andPassword:(NSString *)password {
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    //开始登录
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * _Nullable user, NSError * _Nullable error) {
        //登录完成后的回调
        [avi stopAnimating];
        //判断登录是否成功
        if (user) {
            NSLog(@"登录成功");
            //记忆用户名
            [Utilities setUserDefaults:@"Username" content:username];
            //将密码文本输入框中的内容清除
            _passwordTF.text = nil;
            
        } else {
            switch (error.code) {
                case 101:
                    [Utilities popUpAlertViewWithMsg:@"用户名或密码错误" andTitle:nil onView:self];
                    break;
                case 100:
                    [Utilities popUpAlertViewWithMsg:@"网络连接失败,请稍后再试" andTitle:nil onView:self];
                    break;
                default:
                    [Utilities popUpAlertViewWithMsg:@"服务器连接失败,请稍后再试" andTitle:nil onView:self];
                    break;
            }
        }
    }];
    
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

//当用户点击登录按钮后调用
- (IBAction)signInAction:(UIButton *)sender forEvent:(UIEvent *)event {
    NSString *username = _usernameTF.text;
    NSString *password = _passwordTF.text;
    
    if (username.length == 0 || password.length == 0) {
        [Utilities popUpAlertViewWithMsg:@"内容为空，请再次输入" andTitle:nil onView:self];
        return;
    }
    //执行登录
    [self signInWithUsername:username andPassword:password];

    }

//当用户点击注册按钮后调用
- (IBAction)registeredAction:(UIBarButtonItem *)sender {
}

//当用户点击忘记密码后调用
- (IBAction)forgetPasswordAction:(UIButton *)sender forEvent:(UIEvent *)event {
    UIStoryboard *stryboard = [UIStoryboard storyboardWithName:@"Storyboard1" bundle:nil];
    //更具名称"Second"，在故事版“Storyboard‘中找到对应的页面
    resetpasswordViewController *cd = [stryboard instantiateViewControllerWithIdentifier:@"resetpassword"];
    [self.navigationController presentViewController:cd animated:YES completion:nil];
    NSLog(@"哈哈哈");
    
    
    
    
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
