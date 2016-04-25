//
//  MineViewController.h
//  AdventureClub
//
//  Created by ZengXiangjiang on 16/4/16.
//  Copyright © 2016年 Family. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineViewController : UIViewController
//当前用户的头像
@property (weak, nonatomic) IBOutlet UIImageView *yongimage;
//用户的名字
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
//点击粉丝触发的事件
- (IBAction)fenAction:(UIButton *)sender forEvent:(UIEvent *)event;
//点击关注触发的事件
- (IBAction)guanAction:(id)sender forEvent:(UIEvent *)event;
//0 或1
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmengCt;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *anniu;
- (IBAction)dengAction:(UIButton *)sender forEvent:(UIEvent *)event;

@end
