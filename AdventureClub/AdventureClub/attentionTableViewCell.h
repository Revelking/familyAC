//
//  attentionTableViewCell.h
//  AdventureClub
//
//  Created by ouyang on 16/5/6.
//  Copyright © 2016年 Family. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface attentionTableViewCell : UITableViewCell
//用户头像
@property (weak, nonatomic) IBOutlet UIImageView *touxia;
//用户名
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
//关注内容
@property (weak, nonatomic) IBOutlet UILabel *mentLb;
//赞
@property (weak, nonatomic) IBOutlet UILabel *zaiLb;
//踩
@property (weak, nonatomic) IBOutlet UILabel *caiLb;
//发表数
@property (weak, nonatomic) IBOutlet UILabel *faviaosLb;

@end
