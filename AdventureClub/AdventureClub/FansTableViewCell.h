//
//  FansTableViewCell.h
//  AdventureClub
//
//  Created by wang on 16/5/7.
//  Copyright © 2016年 Family. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FansTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;//头像
@property (weak, nonatomic) IBOutlet UILabel *name;//名称
@property (weak, nonatomic) IBOutlet UILabel *signature;//签名

@end
