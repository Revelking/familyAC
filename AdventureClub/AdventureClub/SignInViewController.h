//
//  SignInViewController.h
//  AdventureClub
//
//  Created by ZengXiangjiang on 16/4/16.
//  Copyright © 2016年 Family. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *photoIV;

//用户名(textfield)
- (IBAction)usernameTF:(UITextField *)sender forEvent:(UIEvent *)event;
//密码(textfield)
- (IBAction)passwordTF:(UITextField *)sender forEvent:(UIEvent *)event;
//确认按钮(Button按钮)
- (IBAction)signInAction:(UIButton *)sender forEvent:(UIEvent *)event;
//注册按钮(BarButtonItem)
- (IBAction)registeredAction:(UIBarButtonItem *)sender;
//忘记密码按钮(Button按钮)
- (IBAction)forgetPasswordAction:(UIButton *)sender forEvent:(UIEvent *)event;

@end
