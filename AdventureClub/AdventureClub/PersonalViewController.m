//
//  PersonalViewController.m
//  AdventureClub
//
//  Created by hp on 16/4/19.
//  Copyright © 2016年 Family. All rights reserved.
//

#import "PersonalViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface PersonalViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    BOOL flag;
}
@property(strong,nonatomic)NSMutableArray *objectForShow;
@property(strong,nonatomic)UIImagePickerController *imagePC;
@property(nonatomic)NSInteger i;
@property(strong,nonatomic)NSString *o;
@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    flag = NO;
    _i=2;
    _image.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleRecognizer;
    singleRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sing)];
    singleRecognizer.numberOfTapsRequired=1;
    [_image addGestureRecognizer:singleRecognizer];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)sing{
    _o=@"1";
    //alertControllerWithTitle:标题  message:正文
    UIAlertController *actionSheet=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *takePhoto=[UIAlertAction actionWithTitle:@"拍照📷" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self picKImage:UIImagePickerControllerSourceTypeCamera];
        
    }];
    
    UIAlertAction *coosephoto=[UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self picKImage:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    UIAlertAction *cancephoto=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    [actionSheet addAction:takePhoto];
    [actionSheet addAction:coosephoto];
    [actionSheet addAction:cancephoto];
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}
//每次页面出现时
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    PFUser *currentUser=[PFUser currentUser];
    
    if (currentUser) {
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user=%@",currentUser];
        PFQuery *query=[PFQuery queryWithClassName:@"Personal" predicate:predicate];
        UIActivityIndicatorView *avi=[Utilities getCoverOnView:self.view];
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            [avi stopAnimating];
            _objectForShow=[NSMutableArray arrayWithArray:objects];
            NSLog(@"object=%@",objects);
            PFObject *dic=objects[0];
            NSString  *name=dic[@"name"];
            NSString *sex=dic[@"sex"];
            NSString *dateBirth=dic[@"dateBirth"];
            NSString *signature=dic[@"signature"];
            if (name.length==0) {
                _name.text=@"未填写";
            }else {
                _name.text=name;
                
            }
            if (sex.length==0) {
                _sex.text=@"未填写";
            }else {
                _sex.text=dic[@"sex"];
            }
            if (dateBirth.length==0) {
                _dateBirth.text=@"未填写";
            }else {
                _dateBirth.text=dic[@"dateBirth"];
            }
            if (signature.length==0) {
                _signature.text=@"未填写";
            }else {
                _signature.text=dic[@"signature"];
            }
            
            
            PFFile *photoFile=dic[@"image"];
            //获取parse数据库中某个文件的网络路径
            NSString *photoURLStr=photoFile.url;
            NSURL  *photoURL=[NSURL URLWithString:photoURLStr];
            //结合SDWebImage通过图片路径来实现异步加载和缓存（本案例中加载到一个图片视图中）
            [_image sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"Image"]];
            
        }];
        
    }else {
        
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"尚未登入，烦请登入" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertView addAction:cancelAction];
        [self presentViewController:alertView animated:YES completion:nil];
    }
    
    
    
}
-(void)quer{
    PFUser *currentUser=[PFUser currentUser];
    
    if (currentUser) {
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"user=%@",currentUser];
        PFQuery *query=[PFQuery queryWithClassName:@"Personal" predicate:predicate];
        UIActivityIndicatorView *avi=[Utilities getCoverOnView:self.view];
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            [avi stopAnimating];
            _objectForShow=[NSMutableArray arrayWithArray:objects];
            NSLog(@"object=%@",objects);
            PFObject *dic=objects[0];
            NSString  *name=dic[@"name"];
            NSString *sex=dic[@"sex"];
            NSString *dateBirth=dic[@"dateBirth"];
            NSString *signature=dic[@"signature"];
            if (name.length==0) {
                _name.text=@"未填写";
            }else {
            _name.text=name;
            
            }
            if (sex.length==0) {
                _sex.text=@"未填写";
            }else {
             _sex.text=dic[@"sex"];
            }
            if (dateBirth.length==0) {
                _dateBirth.text=@"未填写";
            }else {
            _dateBirth.text=dic[@"dateBirth"];
            }
            if (signature.length==0) {
                _signature.text=@"未填写";
            }else {
                _signature.text=dic[@"signature"];
            }
            
            
            PFFile *photoFile=dic[@"image"];
            //获取parse数据库中某个文件的网络路径
            NSString *photoURLStr=photoFile.url;
            NSURL  *photoURL=[NSURL URLWithString:photoURLStr];
            //结合SDWebImage通过图片路径来实现异步加载和缓存（本案例中加载到一个图片视图中）
            [_image sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"Image"]];
            
        }];
        
    }else {
        [Utilities popUpAlertViewWithMsg:@"尚未登入，烦请登入" andTitle:nil onView:self];
        [self.navigationController popViewControllerAnimated:YES];
    }



}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
//当键盘被按时调用
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //点击空白的时候，隐藏键盘
    [self.view endEditing:YES];
}
- (IBAction)baocun:(UIButton *)sender forEvent:(UIEvent *)event {
    PFObject *card=_objectForShow[0];
//    if (_name.text.length==0||_dateBirth.text==0||_sex.text.length==0||_signature.text.length==0) {
//        [Utilities popUpAlertViewWithMsg:@"为空" andTitle:nil onView:self];
//        return;
//    }
    UIImage *image=_image.image;
    if (!flag) {
        
        
    }else {
    
        NSData  *photoData=UIImagePNGRepresentation(image);
        //将上述数据流转化成PFFILE对象，这是个文件对象， 这里除了设置文件内容，还需要给文件取个文件名，这个文件名可以是任何名字
        PFFile  *photoFile=[PFFile fileWithName:@"photo.png" data:photoData];
        card[@"image"]=photoFile;
        
        UIActivityIndicatorView *avi=[Utilities getCoverOnView:self.view];
        [card saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                [avi stopAnimating];
                [self quer];
                [Utilities popUpAlertViewWithMsg:@"您已经修改完成了!" andTitle:nil onView:self];
                
            }
        }];
    }
    if (_name.text.length==0) {
        
    }else {
    
    card[@"name"]=_name.text;
        [card saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                [self quer];
                [Utilities popUpAlertViewWithMsg:@"您已经修改完成了!" andTitle:nil onView:self];
                
            }
        }];
    }
    if (_dateBirth.text==0) {
        
    }else {
    card[@"dateBirth"]=_dateBirth.text;
        [card saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                [self quer];
                [Utilities popUpAlertViewWithMsg:@"您已经修改完成了!" andTitle:nil onView:self];
                
            }
        }];
    }
    if (_sex.text.length==0) {
        
    }else {
    
        card[@"sex"]=_sex.text;
        [card saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                [self quer];
                [Utilities popUpAlertViewWithMsg:@"您已经修改完成了!" andTitle:nil onView:self];
                
            }
        }];
    }
    if (_signature.text.length==0) {
        
    }else {
    card[@"signature"]=_signature.text;
        [card saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                [self quer];
                [Utilities popUpAlertViewWithMsg:@"您已经修改完成了!" andTitle:nil onView:self];
                
            }
        }];
    }
    
    
}



- (IBAction)fanhui:(UIBarButtonItem *)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)picKImage:(UIImagePickerControllerSourceType)sourceType{
    NSLog(@"有相片");
    _i=1;
    //判断当前的选择图片类型是否可用
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        //_imagePC将内容为空
        _imagePC=nil;
        //初始化一个图片控制器对象
        _imagePC=[[UIImagePickerController alloc]init];
        //签协议
        _imagePC.delegate=self;
        //设置图片选择器的类型
        _imagePC.sourceType=sourceType;
        //设置选择的媒体文件是否被编辑
        _imagePC.allowsEditing=YES;
        //设置可以被选择的媒体文件的类型
        _imagePC.mediaTypes=@[(NSString *)kUTTypeImage];
        [self presentViewController:_imagePC animated:YES completion:nil];
    }else{
        UIAlertController *alertview=[UIAlertController alertControllerWithTitle:@"提示" message:sourceType==UIImagePickerControllerSourceTypeCamera?@"你当前的设备没有照相功能":@"当前设备无法有相册"  preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmAction=[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:nil];
        [alertview addAction:confirmAction];
        [self presentViewController:alertview animated:YES completion:nil];
        
        
    }
    
    
    
}
//当选择完媒体文件后被调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //根据UIImagePickerControllerEditedImage这个健去拿到我们选择的图片
    UIImage *image=info[UIImagePickerControllerEditedImage];
    //用mode的方式返回上一页
    [self dismissViewControllerAnimated:YES completion:nil];
    //将上面拿到的图片设置为
    
    _image.image=image;
    
    flag = YES;
}
@end
