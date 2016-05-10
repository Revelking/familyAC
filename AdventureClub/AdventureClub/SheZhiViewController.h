//
//  SheZhiViewController.h
//  AdventureClub
//
//  Created by ZengXiangjiang on 16/4/18.
//  Copyright © 2016年 Family. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SheZhiViewController : UIViewController
//退出按钮
- (IBAction)exitAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (strong,nonatomic)UIImageView *zoomIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *gexing;
- (IBAction)ganyu:(id)sender forEvent:(UIEvent *)event;

@end
