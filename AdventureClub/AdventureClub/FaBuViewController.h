//
//  FaBuViewController.h
//  AdventureClub
//
//  Created by ZengXiangjiang on 16/4/18.
//  Copyright © 2016年 Family. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FaBuViewController : UIViewController

- (IBAction)faBuAction:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UITextField *biaoTiTF;
@property (weak, nonatomic) IBOutlet UITextField *kaiShiTimeTF;
@property (weak, nonatomic) IBOutlet UITextField *jieShuTimeTF;
@property (weak, nonatomic) IBOutlet UITextField *diDianTF;
@property (weak, nonatomic) IBOutlet UITextField *renShuTF;
@property (weak, nonatomic) IBOutlet UILabel *dianHuaTF;
@property (weak, nonatomic) IBOutlet UIImageView *image1IV;
@property (weak, nonatomic) IBOutlet UIImageView *image2IV;
@property (weak, nonatomic) IBOutlet UIImageView *image3IV;
@property (weak, nonatomic) IBOutlet UIImageView *image4IV;

@end
