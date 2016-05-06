//
//  attentionController.m
//  AdventureClub
//
//  Created by ouyang on 16/5/6.
//  Copyright © 2016年 Family. All rights reserved.
//

#import "attentionController.h"
#import "attentionTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DimessViewController.h"
@interface attentionController ()
@property(strong,nonatomic)NSMutableArray *objectForShow;
@end

@implementation attentionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _objectForShow=[NSMutableArray new];
    self.tableView.tableFooterView=[UIView new];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
//每次页面数显后
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self requer];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)requer{
    PFUser *cus=[PFUser currentUser];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user=%@",cus];
    PFQuery *query=[PFQuery queryWithClassName:@"FocusOn" predicate:predicate];
    [query includeKey:@"dynamic"];
    [query includeKey:@"dynamic.user"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        NSLog(@"走到这里了吗");
        if (!error) {
            NSLog(@"nide%@",objects);
            _objectForShow=[NSMutableArray arrayWithArray:objects];
            [self.tableView reloadData];
        }else{
            
            [Utilities popUpAlertViewWithMsg:@"请保持网络畅通" andTitle:nil onView:self];
        }
        
    }];


}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _objectForShow.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    attentionTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *ob=_objectForShow[indexPath.row];
    PFObject *adynamic=ob[@"dynamic"];
    
    PFUser *user=adynamic[@"user"];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user=%@",user];
    PFQuery *query=[PFQuery queryWithClassName:@"Personal" predicate:predicate];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        PFObject *obj=objects[0];
        PFFile  *jb=obj[@"image"];
        NSString *photoURLStr=jb.url;
        NSLog(@"用户有吗%@",photoURLStr);
        //获取parse数据库中某个文件的网络路径
        NSURL  *photoURL=[NSURL URLWithString:photoURLStr];
        ////结合SDWebImage通过图片路径来实现异步加载和缓存（本案例中加载到一个图片视图中）
        [cell.touxia sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"wei"]];
        cell.nameLb.text=obj[@"name"];
    }];
    
    
    cell.mentLb.text=adynamic[@"contenttext"];
    
    NSString *cai=[NSString stringWithFormat:@"踩：%@",adynamic[@"stepon"]];
    cell.caiLb.text=cai;
    NSString *czai=[NSString stringWithFormat:@"赞：%@",adynamic[@"praise"]];
    cell.zaiLb.text=czai;
    
    
    NSPredicate *predicat=[NSPredicate predicateWithFormat:@"dynamic=%@",adynamic];
    PFQuery *quer=[PFQuery queryWithClassName:@"Comments" predicate:predicat];
    [quer findObjectsInBackgroundWithBlock:^(NSArray * _Nullable object, NSError * _Nullable error) {
        NSInteger  i=object.count;
        if (i<0) {
            cell.faviaosLb.text=@"发表数：0";
        }else {
            cell.faviaosLb.text=[NSString stringWithFormat:@"发表数：%ld",(long)i];
            
        }
    }];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *storybord=[UIStoryboard storyboardWithName:@"Storyboard1" bundle:nil];
    PFObject *ob=_objectForShow[indexPath.row];
    PFObject *card=ob[@"dynamic"];
    //更具名称找到名为detailView的页面
    DimessViewController *detailView =[storybord instantiateViewControllerWithIdentifier:@"dotai"];
    detailView.dimess=card;
    [self.navigationController pushViewController:detailView animated:YES];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PFObject * obj = [_objectForShow objectAtIndex:indexPath.row];
    PFObject *card=obj[@"dynamic"];
    NSString *str = card[@"contenttext"];
    
    attentionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    CGSize maxSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width - 30, 1000);
    CGSize contentLabelSize = [str boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:cell.mentLb.font} context:nil].size;
    return cell.mentLb.frame.origin.y+15 + contentLabelSize.height+20;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
