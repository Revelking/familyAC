//
//  resetpasswordViewController.h
//  AdventureClub
//
//  Created by ouyang on 16/4/19.
//  Copyright © 2016年 Family. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface resetpasswordViewController : UIViewController
//账号
@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *email;

- (IBAction)emailAction:(UIButton *)sender forEvent:(UIEvent *)event;

@end
