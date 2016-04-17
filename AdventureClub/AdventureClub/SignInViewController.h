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
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
//密码(textfield)
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
//确认按钮(Button按钮)
- (IBAction)signInAction:(UIButton *)sender forEvent:(UIEvent *)event;
//注册按钮(BarButtonItem)
- (IBAction)registeredAction:(UIBarButtonItem *)sender;
//忘记密码按钮(Button按钮)
- (IBAction)forgetPasswordAction:(UIButton *)sender forEvent:(UIEvent *)event;

@end
