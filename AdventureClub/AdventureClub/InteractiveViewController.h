//
//  InteractiveViewController.h
//  AdventureClub
//
//  Created by wang on 16/5/7.
//  Copyright © 2016年 Family. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InteractiveViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *antitle;
@property (weak, nonatomic) IBOutlet UITextView *content;
@property (weak, nonatomic) IBOutlet UIImageView *image;
- (IBAction)ok:(UIButton *)sender forEvent:(UIEvent *)event;

@end
