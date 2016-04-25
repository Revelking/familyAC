//
//  MessageViewController.h
//  AdventureClub
//
//  Created by ZengXiangjiang on 16/4/16.
//  Copyright © 2016年 Family. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)segmengtedAction:(UISegmentedControl *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmeng;

@end
