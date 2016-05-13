//
//  DimessViewController.h
//  AdventureClub
//
//  Created by ouyang on 16/4/25.
//  Copyright © 2016年 Family. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DimessViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *imageIV;
@property (weak, nonatomic) IBOutlet UILabel *usernameLbl;
@property (weak, nonatomic) IBOutlet UILabel *biaotiLbl;
@property (weak, nonatomic) IBOutlet UIImageView *huoDongImageIV;
- (IBAction)zanAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UILabel *zanLbl;
- (IBAction)caiAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UILabel *caiLbl;
@property (weak, nonatomic) IBOutlet UILabel *pinLunLbl;
@property (weak, nonatomic) IBOutlet UILabel *huoDongNeiRongTV;
//输入kuang
@property (weak, nonatomic) IBOutlet UITextField *faBiaoPinLunTF;
@property(strong,nonatomic)PFObject *dimess;
- (IBAction)guanzAction:(id)sender forEvent:(UIEvent *)event;
- (IBAction)faBiaoAction:(UIButton *)sender forEvent:(UIEvent *)event;

@property (weak, nonatomic) IBOutlet UIButton *nanniu;

@end
