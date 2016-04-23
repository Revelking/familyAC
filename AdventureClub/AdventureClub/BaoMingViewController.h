//
//  BaoMingViewController.h
//  AdventureClub
//
//  Created by wang on 16/4/23.
//  Copyright © 2016年 Family. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaoMingViewController : UIViewController
@property(strong,nonatomic)PFObject *card;
@property (weak, nonatomic) IBOutlet UILabel *yibaoming;
//头像
@property (weak, nonatomic) IBOutlet UIImageView *touXiang;
//用户名
@property (weak, nonatomic) IBOutlet UILabel *name;
//活动图片
@property (weak, nonatomic) IBOutlet UIImageView *imageTF;
//活动名称
@property (weak, nonatomic) IBOutlet UILabel *nameTF;
//活动内容
@property (weak, nonatomic) IBOutlet UILabel *contentTF;
//活动限定人数
@property (weak, nonatomic) IBOutlet UILabel *detailsTF;
//开始时间
@property (weak, nonatomic) IBOutlet UILabel *startTF;
//结束时间
@property (weak, nonatomic) IBOutlet UILabel *timeTF;

//活动地点
@property (weak, nonatomic) IBOutlet UILabel *addressTF;
//注意事项
@property (weak, nonatomic) IBOutlet UILabel *mattersTF;
//活动电话
@property (weak, nonatomic) IBOutlet UILabel *phoneTF;
//此方法实现可打电话
- (IBAction)phoneAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)baoMingAction:(UIBarButtonItem *)sender;

@end
