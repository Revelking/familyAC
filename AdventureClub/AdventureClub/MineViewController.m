//
//  MineViewController.m
//  AdventureClub
//
//  Created by ZengXiangjiang on 16/4/16.
//  Copyright © 2016年 Family. All rights reserved.
//

#import "MineViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SignInViewController.h"
@interface MineViewController ()
@property(strong,nonatomic)NSMutableArray *objectForShow;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _objectForShow=[NSMutableArray new];
    PFUser *currentUser=[PFUser currentUser];
    
    if (currentUser) {
        [_anniu setTitle:@"切换" forState:UIControlStateNormal];
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user=%@",currentUser];
        PFQuery *query=[PFQuery queryWithClassName:@"Personal" predicate:predicate];
        UIActivityIndicatorView *avi=[Utilities getCoverOnView:self.view];
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            [avi stopAnimating];
            _objectForShow=[NSMutableArray arrayWithArray:objects];
            NSLog(@"object=%@",objects);
            NSDictionary *dic=objects[0];
            _nameLb.text=dic[@"name"];
            
            PFFile *photoFile=dic[@"image"];
            //获取parse数据库中某个文件的网络路径
            NSString *photoURLStr=photoFile.url;
            NSURL  *photoURL=[NSURL URLWithString:photoURLStr];
            //结合SDWebImage通过图片路径来实现异步加载和缓存（本案例中加载到一个图片视图中）
            [_yongimage sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"Image"]];
            }];
    
    }else {
       [_anniu setTitle:@"登入" forState:UIControlStateNormal];
        UIImage *myImage = [UIImage imageNamed:@"wei"];
        _yongimage.image=myImage;
        _nameLb.text=@"尚未登入";
        
    
    }
        
    // Do any additional setup after loading the view.
}
-(void)tClick{



}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)reques{
    
    
    
    PFUser *cus=[PFUser currentUser];
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user=%@",cus];
    PFQuery *query=[PFQuery queryWithClassName:@"Qcoment" predicate:predicate];
      [query includeKey:@"dynamic"];
    [query includeKey:@"dynamic.user"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            _objectForShow=[NSMutableArray arrayWithArray:objects];
            [_tableView reloadData];
        }else{
            
            [Utilities popUpAlertViewWithMsg:@"请保持网络畅通" andTitle:nil onView:self];
        }
        
        
    }];
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *ob=_objectForShow[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (IBAction)fenAction:(UIButton *)sender forEvent:(UIEvent *)event {
}

- (IBAction)guanAction:(id)sender forEvent:(UIEvent *)event {
}
- (IBAction)dengAction:(UIButton *)sender forEvent:(UIEvent *)event {
     SignInViewController *vc=[Utilities getStoryboardInstanceInstance:@"Main" byIdentity:@"deng"];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
//    [self.navigationController presentViewController:vc animated:YES completion:nil];
}
@end
