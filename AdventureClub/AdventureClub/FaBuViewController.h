//
//  FaBuViewController.h
//  AdventureClub
//
//  Created by ZengXiangjiang on 16/4/18.
//  Copyright © 2016年 Family. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FaBuViewController : UIViewController

//确认发布按钮
- (IBAction)faBuAction:(UIBarButtonItem *)sender;
//标题输入框
@property (weak, nonatomic) IBOutlet UITextField *biaoTiTF;
//活动内容输入框
@property (weak, nonatomic) IBOutlet UITextView *textViewTV;
//活动开始时间显示框
@property (weak, nonatomic) IBOutlet UILabel *kaiShiTimeLbl;
//活动结束时间显示框
@property (weak, nonatomic) IBOutlet UILabel *jieShuTimeLbl;
//人数限制框
@property (weak, nonatomic) IBOutlet UITextField *renShuTF;
//活动地点选着款
@property (weak, nonatomic) IBOutlet UITextField *diDianTF;
//活动联系电话输入框
@property (weak, nonatomic) IBOutlet UITextField *dianHuaTF;
//注意事项输入款
@property (weak, nonatomic) IBOutlet UITextField *zhuYIShiXiangTF;
//图片1
@property (weak, nonatomic) IBOutlet UIImageView *image1IV;
//图片2
@property (weak, nonatomic) IBOutlet UIImageView *image2IV;
//图片3
@property (weak, nonatomic) IBOutlet UIImageView *image3IV;
//图片4
@property (weak, nonatomic) IBOutlet UIImageView *image4IV;
//活动开始时间按钮
- (IBAction)kaiShiTimeAction:(UIButton *)sender forEvent:(UIEvent *)event;
//活动结束时间按钮
- (IBAction)jieShuTimeAction:(UIButton *)sender forEvent:(UIEvent *)event;

@end
