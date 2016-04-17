//
//  HomeTableViewCell.h
//  AdventureClub
//
//  Created by ZengXiangjiang on 16/4/17.
//  Copyright © 2016年 Family. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell

//图片视图
@property (weak, nonatomic) IBOutlet UIImageView *imageIV;
//活动名称
@property (weak, nonatomic) IBOutlet UILabel *activityNameLbl;
//活动内容简介
@property (weak, nonatomic) IBOutlet UITextView *textViewTV;
//活动开始时间
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;

@end
