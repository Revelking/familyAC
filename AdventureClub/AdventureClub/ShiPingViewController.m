//
//  ShiPingViewController.m
//  AdventureClub
//
//  Created by wang on 16/5/10.
//  Copyright © 2016年 Family. All rights reserved.
//

#import "ShiPingViewController.h"
#import "ShiTableViewCell.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
@interface ShiPingViewController ()<ActivityTableViewCellDelegate,AVPlayerViewControllerDelegate>{//定义5个数组
    NSArray *imTitle;
    NSArray *imDetail;
    NSArray *uytd;
}
@property (nonatomic, strong) AVPlayerViewController *playCtrl;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVAudioSession *audioSession;
@end

@implementation ShiPingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条"] forBarMetrics:UIBarMetricsDefault];
    imTitle = @[@"这个前段...我输的五体投地",@"我真的没有，不然天打五雷轰顶"];
    imDetail=@[@"sha",@"bi"];
    uytd=@[@"1.mov",@"2.mov"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.delegate=self;
    cell.indexPath=indexPath;
    cell.image1.image=[UIImage imageNamed:imDetail[indexPath.row]];
    cell.telet.text=imTitle[indexPath.row];
    
    
    return cell;
}
- (void)photoTapAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
    NSString *path = [[NSBundle mainBundle] pathForResource:uytd[indexPath.row] ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    
    
    self.player = [AVPlayer playerWithURL:url];
    
    self.playCtrl = [[AVPlayerViewController alloc] init];
    self.playCtrl.player = self.player;
    //默认是YES可不写这行代码
    self.playCtrl.allowsPictureInPicturePlayback = YES;
    self.playCtrl.delegate = self;
    
    //这两行必须设置，不然画中画不能用，如果不写模拟器中可以画中画，但是在设备中不能
    self.audioSession = [AVAudioSession sharedInstance];
    [self.audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [self presentViewController:self.playCtrl animated:YES completion:^{
        [self.playCtrl.player play];
    }];
}
- (void)playerViewControllerWillStartPictureInPicture:(AVPlayerViewController *)playerViewController{
    NSLog(@"will startPicInPic");
}
- (void)playerViewControllerDidStartPictureInPicture:(AVPlayerViewController *)playerViewController{
    NSLog(@"did startPicInPic");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
