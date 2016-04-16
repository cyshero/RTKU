//
//  RTLoopViewController.m
//  0415网易新闻1951
//
//  Created by apple on 16/4/16.
//  Copyright © 2016年 eason. All rights reserved.
//

#import "RTLoopViewController.h"
#import "RTNetWorkManger.h"
#import "RTLoopView.h"
#import "RTNetWorkManger.h"
@interface RTLoopViewController ()

@end

@implementation RTLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //先获取数据
    [[RTNetWorkManger manager]GET:@"http://c.m.163.com/nc/ad/headline/0-4.html" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary*dic=responseObject;
        NSString* nextkey=dic.keyEnumerator.nextObject;
        NSArray* array=dic[nextkey];
        NSArray* urls=[array valueForKeyPath:@"imgsrc"];
        NSArray*  titles=[array valueForKeyPath:@"title"];
        RTLoopView* loop=[[RTLoopView alloc]initWithUrls:urls AndTitles:titles AndDidSelectBlock:^(NSInteger index) {
        }];
        [loop setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:loop];
        loop.frame=self.view.bounds;
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
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

@end
