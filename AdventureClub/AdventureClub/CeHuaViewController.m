//
//  CeHuaViewController.m
//  AdventureClub
//
//  Created by ZengXiangjiang on 16/4/19.
//  Copyright © 2016年 Family. All rights reserved.
//

#import "CeHuaViewController.h"
#import <ECSlidingViewController/ECSlidingViewController.h>
#import "TabBarViewController.h"
#import "SheZhiViewController.h"

@interface CeHuaViewController ()

@property (strong, nonatomic) ECSlidingViewController *slidingVC;

@end

@implementation CeHuaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self LateralSpreads];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)LateralSpreads{
    
    //根据故事版的名称，和故事版中页面的名称
    TabBarViewController *vc=[Utilities getStoryboardInstanceInstance:@"Main" byIdentity:@"tab"];
    //初始化门框,并且同时设置移门中间的那扇门
    _slidingVC=[ECSlidingViewController slidingWithTopViewController:vc];
    //设置开门关门的耗时
    _slidingVC.defaultTransitionDuration=0.25f;
    //设置控制移门开关的手势,这里同时对触摸和拖拽响应;
    _slidingVC.topViewAnchoredGesture=ECSlidingViewControllerAnchoredGestureTapping|ECSlidingViewControllerAnchoredGesturePanning;
    //设置上述手势的识别范围
    [vc.view addGestureRecognizer:_slidingVC.panGesture];
    //根据故事版中名称获得左滑页面的实力
    SheZhiViewController *leftVC=  [Utilities getStoryboardInstanceInstance:@"Main" byIdentity:@"Life"];
    
    //设置移门靠左的那扇门
    _slidingVC.underLeftViewController=leftVC;
    //设置移门的开闭程度(设置左侧页面当被显示是，宽度能够显示屏幕宽度减去屏幕宽度的4分之1的宽度值)anchorLeftPeekAmount中间屏幕
    _slidingVC.anchorRightPeekAmount=UI_SCREEN_W /4;

    //创建一个单当菜单按钮被按时要执行的侧滑方法的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuSwitchAction) name:@"MenuSwitch" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enableGestureAction) name:@"EnableGesture" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disableGestureAction) name:@"DisableGesture" object:nil];
    
    //mode的方法跳转的这个页面
    [self presentViewController:_slidingVC animated:NO completion:nil];
}

- (void)menuSwitchAction {
    NSLog(@"菜单");
    if (_slidingVC.currentTopViewPosition == ECSlidingViewControllerTopViewPositionAnchoredRight) {
        //上述条件表示中间那扇门正移在右侧，说明门是打开的，因此我们需要将它关闭，也就是将中间的门移回中间
        [_slidingVC resetTopViewAnimated:YES];
    } else {
        //反之将中间的门移到右边
        [_slidingVC anchorTopViewToRightAnimated:YES];
    }
}

//激活移门手势
- (void)enableGestureAction {
    _slidingVC.panGesture.enabled = YES;
}

//关闭移门手势
- (void)disableGestureAction {
    _slidingVC.panGesture.enabled = NO;
}

@end
