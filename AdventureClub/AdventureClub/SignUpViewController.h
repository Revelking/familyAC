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
- (IBAction)usernameTF:(UITextField *)sender forEvent:(UIEvent *)event;
//年龄(textfield)
- (IBAction)ageTF:(UITextField *)sender forEvent:(UIEvent *)event;
//性别(textfield)
- (IBAction)genderTF:(UITextField *)sender forEvent:(UIEvent *)event;
//手机号码(textfield)
- (IBAction)telTF:(UITextField *)sender forEvent:(UIEvent *)event;
//生日(textfield)
- (IBAction)birthdayTF:(UITextField *)sender forEvent:(UIEvent *)event;
//（真实）姓名(textfield)
- (IBAction)nameTF:(UITextField *)sender forEvent:(UIEvent *)event;
//密码(textfield)
- (IBAction)passwordTF:(UITextField *)sender forEvent:(UIEvent *)event;
//确认密码(textfield)
- (IBAction)confirmPasswordTF:(UITextField *)sender forEvent:(UIEvent *)event;
//确认注册按钮(Button按钮)
- (IBAction)signUpAction:(UIButton *)sender forEvent:(UIEvent *)event;

@end
