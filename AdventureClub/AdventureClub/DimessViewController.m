//
//  DimessViewController.m
//  AdventureClub
//
//  Created by ouyang on 16/4/25.
//  Copyright © 2016年 Family. All rights reserved.
//

#import "DimessViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DimessTableViewCell.h"
@interface DimessViewController ()
@property(strong,nonatomic)NSMutableArray *objectsForShow;
@property (strong, nonatomic) UITapGestureRecognizer *tapTrick;
@end

@implementation DimessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self uddate];
    [self reque];
    _tapTrick = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgTap:)];
    _tapTrick.enabled=NO;
    [self.view addGestureRecognizer:_tapTrick];
    //监听键盘打开这一操作，打开后执行keyboardWillShow:方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //监听键盘收起这一操作，收起后执行keyboardWillHide:方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    UIRefreshControl *rc=[[UIRefreshControl alloc]init];
    
    rc.tag=10001;
    rc.tintColor=[UIColor darkGrayColor];
    [rc addTarget:self action:@selector(uddate) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:rc];
    // Do any additional setup after loading the view.
}
-(void)uddate{

    PFUser *ownerUser=_dimess[@"user"];
    //    _name.text=ownerUser.username;
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user=%@",ownerUser];
    PFQuery *query=[PFQuery queryWithClassName:@"Personal" predicate:predicate];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        PFObject *obj=objects[0];
        PFFile  *jb=obj[@"image"];
        _usernameLbl.text=obj[@"name"];
        NSString *photoURLStr=jb.url;
        //获取parse数据库中某个文件的网络路径
        NSURL  *photoURL=[NSURL URLWithString:photoURLStr];
        ////结合SDWebImage通过图片路径来实现异步加载和缓存（本案例中加载到一个图片视图中）
        [_imageIV sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"wei"]];
    }];
    _biaotiLbl.text=_dimess[@"dyname"];
    NSString *cai=[NSString stringWithFormat:@"%@",_dimess[@"stepon"]];
    _caiLbl.text=cai;
    NSString *zan=[NSString stringWithFormat:@"%@",_dimess[@"praise"]];
    _zanLbl.text=zan;
    PFObject *activity = [PFObject objectWithClassName:@"Dynamic"];
    activity.objectId =_dimess.objectId;
    NSPredicate *predicat=[NSPredicate predicateWithFormat:@"dynamic=%@",activity];
    PFQuery *quer=[PFQuery queryWithClassName:@"Image" predicate:predicat];
    [quer findObjectsInBackgroundWithBlock:^(NSArray * _Nullable object, NSError * _Nullable error) {
        UIRefreshControl *rc=(UIRefreshControl *)[self.tableView viewWithTag:10001];
        [rc endRefreshing];
        PFObject  *obj1=object[0];
        PFFile  *jb=obj1[@"image"];
        
        NSString *photoURLStr=jb.url;
        
        //获取parse数据库中某个文件的网络路径
        NSURL  *photoURL=[NSURL URLWithString:photoURLStr];
        ////结合SDWebImage通过图片路径来实现异步加载和缓存（本案例中加载到一个图片视图中）
        [_huoDongImageIV sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"jnf"]];
    }];
    PFObject *activit = [PFObject objectWithClassName:@"Dynamic"];
    activit.objectId =_dimess.objectId;
    NSPredicate *predica=[NSPredicate predicateWithFormat:@"dynamic=%@",activit];
    PFQuery *que=[PFQuery queryWithClassName:@"Comments" predicate:predica];
    [que findObjectsInBackgroundWithBlock:^(NSArray * _Nullable object, NSError * _Nullable error) {
        NSInteger  i=object.count;
        if (i<0) {
            _pinLunLbl.text=@"0";
            //            cell.renshuLb.text=
        }else {
            _pinLunLbl.text=[NSString stringWithFormat:@"%ld",(long)i];
            //            cell.renshuLb.text=
            
        }
    }];
    _huoDongNeiRongTV.text=_dimess[@"contenttext"];



}
-(void)reque{
    
    _objectsForShow=[NSMutableArray new];
    [_objectsForShow removeAllObjects];
        PFObject *activity= [PFObject objectWithClassName:@"Dynamic"];
        activity.objectId =_dimess.objectId;
        NSPredicate *predicat=[NSPredicate predicateWithFormat:@"dynamic=%@",activity];
     UIActivityIndicatorView *aiv=[Utilities getCoverOnView:self.view];
        PFQuery *quer=[PFQuery queryWithClassName:@"Comments" predicate:predicat];
       [quer includeKey:@"user"];
        [quer findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            [aiv stopAnimating];
            NSLog(@"ddsds%@",objects);
            if (!error) {
                _objectsForShow=[NSMutableArray arrayWithArray:objects];
                [_tableView reloadData];
            }
        }];
    
   
    


}
-(void)qingq{
    PFObject *activity= [PFObject objectWithClassName:@"Dynamic"];
    activity.objectId =_dimess.objectId;
    
    PFUser *cus=[PFUser currentUser];
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user=%@ AND dynamic=%@",cus,activity];
    PFQuery *query=[PFQuery queryWithClassName:@"FocusOn" predicate:predicate];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        NSInteger  i=objects.count;
        if (0<i) {
        
            [_nanniu setTitle:@"已关注" forState:UIControlStateNormal];
        }else {
        
        [_nanniu setTitle:@"加关注" forState:UIControlStateNormal];
        }
    
    
    
    }];

}
//每次页面数显后
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    PFObject *activity= [PFObject objectWithClassName:@"Dynamic"];
    activity.objectId =_dimess.objectId;
    
    PFUser *cus=[PFUser currentUser];
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user=%@ AND dynamic=%@",cus,activity];
    PFQuery *query=[PFQuery queryWithClassName:@"FocusOn" predicate:predicate];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        NSInteger  i=objects.count;
        if (0<i) {
            
            [_nanniu setTitle:@"已关注" forState:UIControlStateNormal];
        }else {
            
            [_nanniu setTitle:@"加关注" forState:UIControlStateNormal];
        }
        
        
        
    }];

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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objectsForShow.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DimessTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *ob=_objectsForShow[indexPath.row];
    PFUser *user=ob[@"user"];
     NSLog(@"dsfdsfdsfdsf");
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user=%@",user];
    PFQuery *query=[PFQuery queryWithClassName:@"Personal" predicate:predicate];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
       
        NSLog(@"用户存在吗%@",objects);
        PFObject *obj=objects[0];
        PFFile  *jb=obj[@"image"];
        cell.pinLunUsernameLbl.text=obj[@"name"];
        NSString *photoURLStr=jb.url;
        //获取parse数据库中某个文件的网络路径
        NSURL  *photoURL=[NSURL URLWithString:photoURLStr];
        ////结合SDWebImage通过图片路径来实现异步加载和缓存（本案例中加载到一个图片视图中）
        [cell.pinLunTouXiangIV sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"wei"]];
    }];
    cell.pinLunDeNeiRongLbl.text=ob[@"content"];
    NSLog(@"dasddasd%@",ob[@"content"]);
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
////ableView:heightForRowAtIndexPath: 中调用这个方法，填入需要的参数计算cell 高度。
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PFObject * obj = [_objectsForShow objectAtIndex:indexPath.row];
    NSString *str = obj[@"content"];
    DimessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    CGSize maxSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width - 30, 1000);
    CGSize contentLabelSize = [str boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:cell.pinLunDeNeiRongLbl.font} context:nil].size;
    return cell.pinLunDeNeiRongLbl.frame.origin.y + contentLabelSize.height+5;
}
- (IBAction)zanAction:(UIButton *)sender forEvent:(UIEvent *)event {
    PFUser *use=[PFUser currentUser];
    if (use) {
        
    }else{
        [Utilities popUpAlertViewWithMsg:@"尚未登入，烦请登入" andTitle:nil onView:self];
        return;
    }
    PFObject *activity= [PFObject objectWithClassName:@"Dynamic"];
    activity.objectId =_dimess.objectId;
    
    PFUser *cus=[PFUser currentUser];
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user=%@ AND dynamic=%@",cus,activity];
     UIActivityIndicatorView *aiv=[Utilities getCoverOnView:self.view];
    PFQuery *query=[PFQuery queryWithClassName:@"Click" predicate:predicate];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [aiv stopAnimating];
        NSInteger  i=objects.count;
        if (0<i) {
            NSLog(@"这个看看%@",objects);
            
            [Utilities popUpAlertViewWithMsg:@"您已经点过啦，为了公平一个人只有一次机会哦，😊" andTitle:nil onView:self];
        }else {
            [self dian];
            
        }
    }];
    
}
-(void)dian{
    NSNumber *click=_dimess[@"praise"];
    
    _dimess[@"praise"]=@([click integerValue]+1);
    
    
    [_dimess saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [self uddate];
            NSLog(@"增加点击量");
        }
    }];
    PFObject *activity= [PFObject objectWithClassName:@"Dynamic"];
    activity.objectId =_dimess.objectId;
    
    PFUser *cus=[PFUser currentUser];
    PFObject *focus=[PFObject objectWithClassName:@"Click"];
    
    focus[@"user"]=cus;
    focus[@"dynamic"]=activity;
    focus[@"nom"]=@"1";
     UIActivityIndicatorView *aiv=[Utilities getCoverOnView:self.view];
    [focus saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        [aiv stopAnimating];
        NSLog(@"点赞啦");
    }];

}
- (IBAction)caiAction:(UIButton *)sender forEvent:(UIEvent *)event {
    PFUser *use=[PFUser currentUser];
    if (use) {
        
    }else{
        [Utilities popUpAlertViewWithMsg:@"尚未登入，烦请登入" andTitle:nil onView:self];
        return;
    }
    PFObject *activity= [PFObject objectWithClassName:@"Dynamic"];
    activity.objectId =_dimess.objectId;
    
    PFUser *cus=[PFUser currentUser];
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user=%@ AND dynamic=%@",cus,activity];
    PFQuery *query=[PFQuery queryWithClassName:@"Click" predicate:predicate];
     UIActivityIndicatorView *aiv=[Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [aiv stopAnimating];
        NSInteger  i=objects.count;
        if (0<i) {
            NSLog(@"这个看看%@",objects);
            
            [Utilities popUpAlertViewWithMsg:@"您已经点过啦，为了公平一个人只有一次机会哦，😊" andTitle:nil onView:self];
        }else {
            [self caid];
            
        }
    }];
    
}
-(void)caid{
    
    NSNumber *click=_dimess[@"stepon"];
    
    _dimess[@"stepon"]=@([click integerValue]+1);
    
    
    [_dimess saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [self uddate];
            NSLog(@"增加点击量");
        }
    }];
    PFObject *activity= [PFObject objectWithClassName:@"Dynamic"];
    activity.objectId =_dimess.objectId;
    
    PFUser *cus=[PFUser currentUser];
    PFObject *focus=[PFObject objectWithClassName:@"Click"];
    
    focus[@"user"]=cus;
    focus[@"dynamic"]=activity;
    focus[@"nom"]=@"1";
     UIActivityIndicatorView *aiv=[Utilities getCoverOnView:self.view];
    [focus saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        [aiv stopAnimating];
        NSLog(@"点赞啦");
    }];

}






//当键盘右下角的确认按钮被按时收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

////点击空白处收键盘
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.view endEditing:YES];
//}

- (IBAction)guanzAction:(id)sender forEvent:(UIEvent *)event {
    PFUser *use=[PFUser currentUser];
    if (use) {
        
    }else{
        [Utilities popUpAlertViewWithMsg:@"尚未登入，烦请登入" andTitle:nil onView:self];
        return;
    }
    
    PFObject *activity= [PFObject objectWithClassName:@"Dynamic"];
    activity.objectId =_dimess.objectId;
    
    PFUser *cus=[PFUser currentUser];
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user=%@ AND dynamic=%@",cus,activity];
    PFQuery *query=[PFQuery queryWithClassName:@"FocusOn" predicate:predicate];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        NSInteger  i=objects.count;
        if (0<i) {
            NSLog(@"这个看看%@",objects);
            
            UIAlertController *alertView=[UIAlertController alertControllerWithTitle:@"提示" message:@"你已经关注了，是否取消关注呢" preferredStyle:UIAlertControllerStyleAlert];
             UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确认" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 PFObject *obj=objects[0];
                 PFObject *activity= [PFObject objectWithClassName:@"FocusOn"];
                 activity.objectId =obj.objectId;
                  UIActivityIndicatorView *aiv=[Utilities getCoverOnView:self.view];
                 [activity deleteInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                     [aiv stopAnimating];
                     if (succeeded) {
                         [self qingq];
                         NSLog(@"取消关注成功");
                     }
                 }];
             }];
            UIAlertAction *cancelAction1 = [UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertView addAction:cancelAction];
            [alertView addAction:cancelAction1];
            [self presentViewController:alertView animated:YES completion:nil];
        }else {
            [self foe];
           
        }
    }];
    
    
   
    
}

- (IBAction)faBiaoAction:(UIButton *)sender forEvent:(UIEvent *)event {
    PFUser *use=[PFUser currentUser];
    if (use) {
        PFObject *activity= [PFObject objectWithClassName:@"Dynamic"];
        activity.objectId =_dimess.objectId;
        
        PFUser *cus=[PFUser currentUser];
        
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user=%@ AND dynamic=%@",cus,activity];
        PFQuery *query=[PFQuery queryWithClassName:@"Qcoment" predicate:predicate];
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            NSInteger  i=objects.count;
            if (0<i) {
            
            }else {
                [self cahx];
            }
        
        
        }];
        [self penlun];
    }else{
        [Utilities popUpAlertViewWithMsg:@"尚未登入无法发评论，烦请登入" andTitle:nil onView:self];
        
    }
}
-(void)cahx{
    PFUser *use=[PFUser currentUser];
            PFObject *activity= [PFObject objectWithClassName:@"Dynamic"];
            activity.objectId =_dimess.objectId;
            
            PFObject *focus=[PFObject objectWithClassName:@"Qcoment"];
            
            focus[@"user"]=use;
            focus[@"dynamic"]=activity;
            [focus saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                NSLog(@"方便查询到，查询的数据");
            }];
}
-(void)foe{
    PFObject *activity= [PFObject objectWithClassName:@"Dynamic"];
    activity.objectId =_dimess.objectId;
    
    PFUser *cus=[PFUser currentUser];
    PFObject *focus=[PFObject objectWithClassName:@"FocusOn"];
    
    focus[@"user"]=cus;
    focus[@"dynamic"]=activity;
    UIActivityIndicatorView *aiv=[Utilities getCoverOnView:self.view];
    [focus saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        [aiv stopAnimating];
        [self qingq];
        NSLog(@"已经关注啦");
    }];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
}
-(void)penlun{

    NSString *dsf=_faBiaoPinLunTF.text;
    if (dsf.length>0) {
        PFObject *activit= [PFObject objectWithClassName:@"Dynamic"];
        activit.objectId =_dimess.objectId;
        PFUser *suer=[PFUser currentUser];
        PFObject *activity= [PFObject objectWithClassName:@"Comments"];
        activity[@"content"]=_faBiaoPinLunTF.text;
        activity[@"dynamic"]=activit;
        activity[@"user"]=suer;
        UIActivityIndicatorView *aiv=[Utilities getCoverOnView:self.view];
        [activity saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            [aiv stopAnimating];
            if (succeeded) {
                _faBiaoPinLunTF.text=@"";
                [self reque];
                NSLog(@"评论表成功");
            }
        }];
    }
}
//键盘打开时的操作
- (void)keyboardWillShow:(NSNotification *)notification {
    NSLog(@"键盘打开了");
   _tapTrick.enabled=YES;
    //获得键盘的位置
    CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSLog(@"键盘的高度是:%f",keyboardRect.size.height);
    //计算键盘出现后，为确保_scrollView的内容都能显示，它应该滚动到的y轴位置
    CGFloat newOffset = (_tableView.contentSize.height - _tableView.frame.size.height) + keyboardRect.size.height;
    //将_scrollView滚动到上述位置
    [_tableView setContentOffset:CGPointMake(0, newOffset) animated:YES];
}
//键盘收起时的操作
- (void)keyboardWillHide:(NSNotification *)notification {
    NSLog(@"键盘收回了");
  
    if (2<_objectsForShow.count) {
        _tapTrick.enabled=NO;
        //计算键盘消失后，_scrollView应该滚动回到的y轴位置
        CGFloat newOffset = (_tableView.contentSize.height - _tableView.frame.size.height) + 50;
        //将_scrollView滚动到上述位置
        [_tableView setContentOffset:CGPointMake(0, newOffset) animated:YES];
    }
}
-(void)bgTap:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateRecognized) {
        [self.view endEditing:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0;

}
@end
