//
//  DimessViewController.h
//  AdventureClub
//
//  Created by ouyang on 16/4/25.
//  Copyright © 2016年 Family. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DimessViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageIV;
@property (weak, nonatomic) IBOutlet UILabel *usernameLbl;
@property (weak, nonatomic) IBOutlet UILabel *biaotiLbl;
@property (weak, nonatomic) IBOutlet UIImageView *huoDongImageIV;
- (IBAction)zanAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UILabel *zanLbl;
- (IBAction)caiAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UILabel *caiLbl;
- (IBAction)pinLunAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UILabel *pinLunLbl;
@property (weak, nonatomic) IBOutlet UITextView *huoDongNeiRongTV;
@property (weak, nonatomic) IBOutlet UITextField *faBiaoPinLunTF;

@end
