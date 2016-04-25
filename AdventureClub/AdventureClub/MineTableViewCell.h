//
//  MineTableViewCell.h
//  AdventureClub
//
//  Created by ouyang on 16/4/25.
//  Copyright © 2016年 Family. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineTableViewCell : UITableViewCell
//动态的图片
@property (weak, nonatomic) IBOutlet UIImageView *hdimage;
//用户的名字
@property (weak, nonatomic) IBOutlet UILabel *yhname;
//主要内容
@property (weak, nonatomic) IBOutlet UILabel *mengLb;

@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *touimage;

@end
