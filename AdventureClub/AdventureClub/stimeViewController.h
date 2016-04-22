//
//  stimeViewController.h
//  AdventureClub
//
//  Created by ouyang on 16/4/22.
//  Copyright © 2016年 Family. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface stimeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *dateone;
- (IBAction)qAction:(id)sender forEvent:(UIEvent *)event;

@end
