//
//  ViewController.m
//  0415网易新闻1951
//
//  Created by apple on 16/4/15.
//  Copyright © 2016年 eason. All rights reserved.
//

#import "ViewController.h"
#import "RTLoopView.h"
#import "RTNetWorkManger.h"
#import "RTNews.h"
@interface ViewController ()
@property(nonatomic,weak)RTLoopView* loopView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
[RTNews loadNewWitnSuccessBlock:^(NSArray *array) {
    NSLog(@"%@",array);
} AndFailed:^(NSError *error) {
    NSLog(@"%@",error);
}];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
