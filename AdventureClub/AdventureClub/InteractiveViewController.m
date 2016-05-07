//
//  InteractiveViewController.m
//  AdventureClub
//
//  Created by wang on 16/5/7.
//  Copyright © 2016年 Family. All rights reserved.
//

#import "InteractiveViewController.h"

#import <MobileCoreServices/MobileCoreServices.h>
@interface InteractiveViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(strong,nonatomic)UIImagePickerController *imagePC;
@end

@implementation InteractiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//获取值
-(void)obtain{
    NSString *antitl=_antitle.text;
    NSString *conten=_content.text;
    UIImage *image1=_image.image;
    if (antitl.length==0 || conten.length==0) {
        [Utilities popUpAlertViewWithMsg:@"内容填写不完整，请填写完整" andTitle:nil onView:self];
        return;
    }
    if (image1==nil) {
        [Utilities popUpAlertViewWithMsg:@"您尚未选择相片" andTitle:nil onView:self];
        return;
    }
    PFUser *currenUser=[PFUser currentUser];
    PFObject *acticity=[PFObject objectWithClassName:@"Dynamic"];
    acticity[@"user"]=currenUser;
    acticity[@"contenttext"]=conten;
    acticity[@"dyname"]=antitl;
    acticity[@"praise"]=@0;
    acticity[@"stepon"]=@0;
    acticity[@"click"]=@0;
    UIActivityIndicatorView *aiv =[Utilities getCoverOnView:self.view];
    [acticity saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        [aiv stopAnimating];
        NSNotification *nota = [NSNotification notificationWithName:@"namehome" object:nil];
        
        //结合线程触发上述通知（让通知要完成的事先执行完以后再触发通知这一行代码后面的代码）
        [[NSNotificationCenter defaultCenter]performSelectorOnMainThread:@selector(postNotification:) withObject: nota waitUntilDone:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    if (image1!=nil) {
        PFObject *imagepf=[PFObject objectWithClassName:@"Image"];
        NSData  *photoData=UIImagePNGRepresentation(image1);
        //将上述数据流转化成PFFILE对象，这是个文件对象， 这里除了设置文件内容，还需要给文件取个文件名，这个文件名可以是任何名字
        PFFile  *photoFile=[PFFile fileWithName:@"photo.png" data:photoData];
        imagepf[@"image"]=photoFile;
        imagepf[@"nom"]=@"1";
        imagepf[@"dynamic"]=acticity;
        [imagepf saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            NSLog(@"第一个");
        }];
    }

}
-(void)sing{
    
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
    
    
    
}//每次页面出现时
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    PFUser *cus=[PFUser currentUser];
    if (cus) {
        
    }else {
        
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"您尚未登入，无法使其功能，烦请登入" preferredStyle:UIAlertControllerStyleAlert];
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

    
}
//当选择完媒体文件后被调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //根据UIImagePickerControllerEditedImage这个健去拿到我们选择的图片
    UIImage *image1=info[UIImagePickerControllerEditedImage];
    //用mode的方式返回上一页
    [self dismissViewControllerAnimated:YES completion:nil];
    _image.image=image1;
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
//让text view 控件实现：当键盘右下角按钮被按时，收回键盘
//当文体输入框视图中文字内容发生变化时调用（返回YES表示同意这个变化发生：返回NO表示不同意）
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(nonnull NSString *)text{
    //捕捉到键盘右下角按钮按下这一事件（键盘右下角按钮被按钮实现上在文本输入视图中执行的是换行\n）
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
    
}
- (IBAction)ok:(UIButton *)sender forEvent:(UIEvent *)event {
    [self obtain];
}
@end
