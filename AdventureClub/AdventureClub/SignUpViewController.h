//
//  SignUpViewController.h
//  AdventureClub
//
//  Created by ZengXiangjiang on 16/4/16.
//  Copyright © 2016年 Family. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController

//用户名(textfield)
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
//手机号码
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
//邮箱
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
//密码
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
//确认密码
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTF;
//确认注册按钮
- (IBAction)signUpAction:(UIButton *)sender forEvent:(UIEvent *)event;

@end
