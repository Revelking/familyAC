//
//  HomeViewController.h
//  AdventureClub
//
//  Created by ZengXiangjiang on 16/4/16.
//  Copyright © 2016年 Family. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController


- (IBAction)setUpAction:(UIBarButtonItem *)sender;
- (IBAction)releaseAction:(UIBarButtonItem *)sender;
//0代表推荐，1代表视频，2代表图片，3代表精品
@property (weak, nonatomic) IBOutlet UISegmentedControl *sortingControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *View1;


@end
