//
//  ViewController.m
//  0415多线程考试02题
//
//  Created by apple on 16/4/15.
//  Copyright © 2016年 eason. All rights reserved.
//

#import "ViewController.h"
#import "AFHTTPSessionManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self upload];

}


-(void)upload{

    //http://localhost/post/upload.php
    // NSURL * url=[NSURL URLWithString:@"http://localhost/post/upload.php"];
  //  NSURLRequest * requset=[NSURLRequest requestWithURL:url];
    NSURL* urlpath=[[NSBundle mainBundle]URLForResource:@"test.png" withExtension:nil];
[[AFHTTPSessionManager manager]POST:@"http://localhost/post/upload.php" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    NSError* error=nil;
    [formData appendPartWithFileURL:urlpath name:@"userfile" fileName:@"test.png" mimeType:@"image/png" error:&error];
   // NSLog(@"%@",error);
} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    self.label.text=@"你的黄色小电影已经成功上传，恭喜你红了";
    NSLog(@"成功上传");
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"%@",error);
}];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
