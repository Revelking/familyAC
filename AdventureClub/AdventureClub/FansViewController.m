//
//  FansViewController.m
//  AdventureClub
//
//  Created by wang on 16/5/7.
//  Copyright © 2016年 Family. All rights reserved.
//

#import "FansViewController.h"
#import "FansTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface FansViewController ()
@property(strong,nonatomic)NSMutableArray *objectsForShow;
@property(strong,nonatomic)NSMutableArray *act;
@end

@implementation FansViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _objectsForShow=[NSMutableArray new];
    _act=[NSMutableArray new];
    [self quer];
    // Do any additional setup after loading the view.
}
-(void)quer{
    PFUser *cus=[PFUser currentUser];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user=%@",cus];
    PFQuery *query=[PFQuery queryWithClassName:@"Dynamic" predicate:predicate];
   
    UIActivityIndicatorView *avi=[Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [avi stopAnimating];
        if (!error) {
            NSLog(@"活动的详情页%@",objects);
            _objectsForShow=[NSMutableArray arrayWithArray:objects];
            [self hef];
        }else{
            
            [Utilities popUpAlertViewWithMsg:@"请保持网络畅通" andTitle:nil onView:self];
        }
    }];
    
    
    
   



}
-(void)hef{
    NSLog(@"sfsf ");
    for (PFObject *ob in _objectsForShow) {
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"dynamic=%@",ob];
        PFQuery *query=[PFQuery queryWithClassName:@"FocusOn" predicate:predicate];
        [query includeKey:@"user"];
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            NSLog(@"我看看%@",objects);
            for (PFObject *hue in objects ) {
               [_act addObject:hue];
                [_tableView reloadData];
            }
            
            
        }];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _act.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   FansTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
                PFObject *obj=_act[indexPath.row];
    
                PFUser *us=obj[@"user"];
                NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user=%@",us];
                PFQuery *query=[PFQuery queryWithClassName:@"Personal" predicate:predicate];
                
                [query getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
                    cell.name.text=object[@"name"];
                    cell.signature.text=object[@"signature"];
                    PFFile  *jb=object[@"image"];
                    NSString *photoURLStr=jb.url;
                    NSLog(@"%@",photoURLStr);
                    //获取parse数据库中某个文件的网络路径
                    NSURL  *photoURL=[NSURL URLWithString:photoURLStr];
                    ////结合SDWebImage通过图片路径来实现异步加载和缓存（本案例中加载到一个图片视图中）
                    [cell.image sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"jnf"]];
                }];
    
            


    return cell;
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
