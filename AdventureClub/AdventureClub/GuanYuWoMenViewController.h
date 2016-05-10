//
//  GuanYuWoMenViewController.h
//  AdventureClub
//
//  Created by ZengXiangjiang on 16/5/10.
//  Copyright © 2016年 Family. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuanYuWoMenViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageIV;
//欢迎页
- (IBAction)huanYingYeAction:(UIButton *)sender forEvent:(UIEvent *)event;
//返回按钮
- (IBAction)fanHuiAction:(UIBarButtonItem *)sender;

@end
