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
@end

@implementation DimessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [self reque];
    // Do any additional setup after loading the view.
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
            if (!error) {
                _objectsForShow=[NSMutableArray arrayWithArray:objects];
                [_tableView reloadData];
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
    return cell;
}
- (IBAction)zanAction:(UIButton *)sender forEvent:(UIEvent *)event {
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
- (IBAction)pinLunAction:(UIButton *)sender forEvent:(UIEvent *)event {
    
    
    
    
}





//当键盘右下角的确认按钮被按时收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

//点击空白处收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)guanzAction:(id)sender forEvent:(UIEvent *)event {
    
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
        NSLog(@"已经关注啦");
    }];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    PFUser *use=[PFUser currentUser];
    if (use) {
        [self penlun];
    }else{
        [Utilities popUpAlertViewWithMsg:@"尚未登入无法发评论，烦请登入" andTitle:nil onView:self];
    
    }
    
    

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
@end
