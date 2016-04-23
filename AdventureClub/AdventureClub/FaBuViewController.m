//
//  FaBuViewController.m
//  AdventureClub
//
//  Created by ZengXiangjiang on 16/4/18.
//  Copyright © 2016年 Family. All rights reserved.
//

#import "FaBuViewController.h"
#import "stimeViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface FaBuViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic)NSInteger i;
@property(nonatomic)NSInteger c;
@property(strong,nonatomic)UIImagePickerController *imagePC;
@end

@implementation FaBuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _image1IV.userInteractionEnabled=YES;
    _image2IV.userInteractionEnabled=YES;
    _image3IV.userInteractionEnabled=YES;
    _image4IV.userInteractionEnabled=YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(timesd) name:@"time" object:nil];
    _kaiShiTimeLbl.text=@"尚未选择时间";
    _jieShuTimeLbl.text=@"尚未选择时间";
    UITapGestureRecognizer *singleRecognizer;
    singleRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sing)];
    singleRecognizer.numberOfTapsRequired=1;
    [_image1IV addGestureRecognizer:singleRecognizer];
    
    UITapGestureRecognizer *singleRecognizer1;
    singleRecognizer1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sing1)];
    singleRecognizer1.numberOfTapsRequired=1;
    [_image2IV addGestureRecognizer:singleRecognizer1];
    
    UITapGestureRecognizer *singleRecognizer2;
    singleRecognizer2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sing2)];
    singleRecognizer2.numberOfTapsRequired=1;
    [_image3IV  addGestureRecognizer:singleRecognizer2];
    
    UITapGestureRecognizer *singleRecognizer3;
    singleRecognizer3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sing3)];
    singleRecognizer3.numberOfTapsRequired=1;
    [_image4IV  addGestureRecognizer:singleRecognizer3];

}
-(void)sing{
    _c=1;
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
-(void)sing1{
    _c=2;
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
-(void)sing2{

    _c=3;
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
-(void)sing3{

    _c=4;
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
-(void)timesd{
    if (_i==2) {
        NSDate *useName=[[StorageMgr singletonStorageMgr]objectForKey:@"SignUpSuccessfully"];
        NSLog(@"usenmame%@",useName);
        NSDate  *time=useName;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"wuhan"];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSString *day = [dateFormatter stringFromDate:time];
        _jieShuTimeLbl.text=day;
        [[StorageMgr singletonStorageMgr]removeObjectForKey:@"SignUpSuccessfully"];
       
    }else {
        NSDate *useName=[[StorageMgr singletonStorageMgr]objectForKey:@"SignUpSuccessfully"];
        NSLog(@"usenmame%@",useName);
        NSDate  *time=useName;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"wuhan"];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSString *day = [dateFormatter stringFromDate:time];
        _kaiShiTimeLbl.text=day;
        [[StorageMgr singletonStorageMgr]removeObjectForKey:@"SignUpSuccessfully"];
       
        
        
    }
    
}

//每次页面出现时
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    PFUser *cus=[PFUser currentUser];
    if (cus) {
        
    }else {
    
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"您尚未登入，无法使其功能，烦请登入" message:@"提示" preferredStyle:UIAlertControllerStyleAlert];
        //创建“确认”按钮，风格为UIAlertActionStyleDefault
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        //创建“取消”按钮，风格为UIAlertActionStyleCancel
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        //将以上两个按钮添加进弹出窗（按钮添加的顺序决定按钮的排版：从左到右；从上到下。如果是取消风格UIAlertActionStyleCancel的按钮会放在最左边）
        [alertView addAction:confirmAction];
        [alertView addAction:cancelAction];
        
        //用present modal的方式跳转到另一个页面（显示alertView）
        [self presentViewController:alertView animated:YES completion:nil];
        
    
    }
//   NSDate *useName=[[StorageMgr singletonStorageMgr]objectForKey:@"SignUpSuccessfully"];
//    NSLog(@"usenmame%@",useName);
//    NSDate  *time=useName;
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"wuhan"];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//    
//    NSString *day = [dateFormatter stringFromDate:time];
//    _jieShuTimeLbl.text=day;
//    [[StorageMgr singletonStorageMgr]removeObjectForKey:@"SignUpSuccessfully"];
    
   
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

//发帖（发布活动）按钮
- (IBAction)faBuAction:(UIBarButtonItem *)sender {
    NSString *biaoti=_biaoTiTF.text;
    NSString *textV=_textViewTV.text;
    NSString *kaishi=_kaiShiTimeLbl.text;
    NSString *jieshu=_jieShuTimeLbl.text;
    NSString *rensu=_renShuTF.text;
    NSString *didian=_diDianTF.text;
    NSString *dianhua=_dianHuaTF.text;
    NSString *zhuyu=_zhuYIShiXiangTF.text;
     UIImage *image=_image1IV.image;
    UIImage *image1=_image2IV.image;
    UIImage *image2=_image3IV.image;
    UIImage *image3=_image4IV.image;
    if (biaoti.length==0||textV.length==0||kaishi.length==0||jieshu.length==0||rensu.length==0||dianhua.length==0||didian.length==0||zhuyu.length==0) {
        [Utilities popUpAlertViewWithMsg:@"非常抱歉，内容为空，请填写" andTitle:nil onView:self];
        return;
    }
    if (image==nil||image1==nil||image2==nil||image3==nil) {
        [Utilities popUpAlertViewWithMsg:@"请选择一张图片" andTitle:nil onView:self];
        return;
    }
    PFUser *currenUser=[PFUser currentUser];
    
    PFObject *acticity=[PFObject objectWithClassName:@"Acticitie"];
    NSString  *b= [kaishi substringWithRange:NSMakeRange(0,4)];
    NSString *c=[kaishi substringWithRange:NSMakeRange(5,2)];
    NSString *h=[kaishi substringWithRange:NSMakeRange(8,2)];
    NSString *not=[NSString stringWithFormat:@"%@%@%@",b,c,h];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc]init];
    [formatter2 setDateFormat:@"yyyyMMdd"];
    NSDate *date1 = [[NSDate alloc] init];
    date1 = [formatter2 dateFromString:not];
    acticity[@"starttime"]=date1;
    
    
    
    NSString  *b1= [jieshu substringWithRange:NSMakeRange(0,4)];
    NSString *c1=[jieshu substringWithRange:NSMakeRange(5,2)];
    NSString *h1=[jieshu substringWithRange:NSMakeRange(8,2)];
    NSString *not1=[NSString stringWithFormat:@"%@%@%@",b1,c1,h1];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc]init];
    [formatter1 setDateFormat:@"yyyyMMdd"];
    NSDate *date2 = [[NSDate alloc] init];
    date2 = [formatter1 dateFromString:not1];
    acticity[@"endtime"]=date2;
    
    acticity[@"maintitle"]=biaoti;
    acticity[@"contenttext"]=textV;
    acticity[@"place"]=didian;
    acticity[@"phone"]=dianhua;
    acticity[@"people"]=[NSNumber numberWithInteger:[rensu integerValue]];
    acticity[@"sigunpPe"]=@0;
    acticity[@"requirements"]=zhuyu;
    acticity[@"click"]=@0;
    acticity[@"user"]=currenUser;
    UIActivityIndicatorView *aiv =[Utilities getCoverOnView:self.view];
    [acticity saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        [aiv stopAnimating];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    if (image!=nil) {
        PFObject *imagepf=[PFObject objectWithClassName:@"Image"];
        NSData  *photoData=UIImagePNGRepresentation(image);
        //将上述数据流转化成PFFILE对象，这是个文件对象， 这里除了设置文件内容，还需要给文件取个文件名，这个文件名可以是任何名字
        PFFile  *photoFile=[PFFile fileWithName:@"photo.png" data:photoData];
        imagepf[@"image"]=photoFile;
        imagepf[@"nom"]=@"1";
        imagepf[@"acticitie"]=acticity;
        [imagepf saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            NSLog(@"第一个");
        }];
    }
    
    
    if (image1!=nil) {
        PFObject *imagepf1=[PFObject objectWithClassName:@"Image"];
        NSData  *photoData1=UIImagePNGRepresentation(image1);
        //将上述数据流转化成PFFILE对象，这是个文件对象， 这里除了设置文件内容，还需要给文件取个文件名，这个文件名可以是任何名字
        PFFile  *photoFile1=[PFFile fileWithName:@"photo.png" data:photoData1];
        imagepf1[@"image"]=photoFile1;
        imagepf1[@"nom"]=@"2";
        imagepf1[@"acticitie"]=acticity;
        [imagepf1 saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            NSLog(@"第二个");
        }];
    }
    if (image2!=nil){
        PFObject *imagepf2=[PFObject objectWithClassName:@"Image"];
        NSData  *photoData2=UIImagePNGRepresentation(image2);
        //将上述数据流转化成PFFILE对象，这是个文件对象， 这里除了设置文件内容，还需要给文件取个文件名，这个文件名可以是任何名字
        PFFile  *photoFile2=[PFFile fileWithName:@"photo.png" data:photoData2];
        imagepf2[@"image"]=photoFile2;
        imagepf2[@"nom"]=@"2";
        imagepf2[@"acticitie"]=acticity;
        [imagepf2 saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            NSLog(@"第三个");
        }];
    }
   
    if (image3!=nil) {
        PFObject *imagepf3=[PFObject objectWithClassName:@"Image"];
        NSData  *photoData3=UIImagePNGRepresentation(image3);
        //将上述数据流转化成PFFILE对象，这是个文件对象， 这里除了设置文件内容，还需要给文件取个文件名，这个文件名可以是任何名字
        PFFile  *photoFile3=[PFFile fileWithName:@"photo.png" data:photoData3];
        imagepf3[@"image"]=photoFile3;
        imagepf3[@"nom"]=@"2";
        imagepf3[@"acticitie"]=acticity;
        [imagepf3 saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            NSLog(@"第四个");
        }];
    }
    
    
    
    
}

//开始时间按钮
- (IBAction)kaiShiTimeAction:(UIButton *)sender forEvent:(UIEvent *)event {
    _i=1;
    
}

//结束时间按钮
- (IBAction)jieShuTimeAction:(UIButton *)sender forEvent:(UIEvent *)event {
    _i=2;
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
//选择相片的
-(void)picKImage:(UIImagePickerControllerSourceType)sourceType{
    NSLog(@"有相片");
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
    if (_c==1) {
        _image1IV.image=image;
    }else if (_c==2){
    
        _image2IV.image=image;
    }else if (_c==3){
    
        _image3IV.image=image;
    }else if (_c==4){
    
        _image4IV.image=image;
    }
   
    
    
    
}
@end
