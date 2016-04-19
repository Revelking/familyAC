//
//  PersonalViewController.h
//  AdventureClub
//
//  Created by hp on 16/4/19.
//  Copyright © 2016年 Family. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *sex;
@property (weak, nonatomic) IBOutlet UITextField *dateBirth;
@property (weak, nonatomic) IBOutlet UITextField *signature;
- (IBAction)baocun:(UIButton *)sender forEvent:(UIEvent *)event;

@end
