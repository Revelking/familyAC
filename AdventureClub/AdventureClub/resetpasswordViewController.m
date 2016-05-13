//
//  resetpasswordViewController.m
//  AdventureClub
//
//  Created by ouyang on 16/4/19.
//  Copyright © 2016年 Family. All rights reserved.
//

#import "resetpasswordViewController.h"

@interface resetpasswordViewController ()

@end

@implementation resetpasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"重置密码";
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

- (IBAction)emailAction:(UIButton *)sender forEvent:(UIEvent *)event {
    NSString *email=_email.text;
    NSString *an=_account.text;
    if (email.length==0||an.length==0) {
        [Utilities popUpAlertViewWithMsg:@"您填写的信息为空" andTitle:@"提示"  onView:self];
        return;
        
    }
    self.navigationController.view.userInteractionEnabled=NO;
    UIActivityIndicatorView *aiv =[Utilities getCoverOnView:self.view];
    [PFUser requestPasswordResetForEmailInBackground:email block:^(BOOL succeeded, NSError * _Nullable error) {
        [aiv stopAnimating];
        self.navigationController.view.userInteractionEnabled=YES;
        if (succeeded) {
            
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"重置密码的方式，我们已经通过邮箱的方法发送给您，请关注你的邮箱" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ac=[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self .navigationController popViewControllerAnimated:YES];
            } ];
            
            [alertView addAction:ac];
            
            [self  presentViewController:alertView animated:YES completion:nil];
        }else {
        
        
            
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络繁忙，请稍后重视" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ac=[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self .navigationController popViewControllerAnimated:YES];
            } ];
            
            [alertView addAction:ac];
            
            [self  presentViewController:alertView animated:YES completion:nil];
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
