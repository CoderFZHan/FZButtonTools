//
//  ViewController.m
//  FZButtonTools
//
//  Created by hanf on 16/2/1.
//  Copyright © 2016年 FZHan. All rights reserved.
//

#import "ViewController.h"
#import "FZButtonTools.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *imageNames = @[@"zhangs", @"lis", @"wangw", @"zhaoliu", @"qianqi", @"wangba", @"aksdkasdk", @"ChangeCount", @"lis"];
    FZButtonTools *tools = [FZButtonTools fzWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 40)
                                               titles:imageNames
                                            tapAction:^(UIButton * _Nullable selectedButton, NSInteger index) {
                                                NSLog(@"click : %@ index %ld", selectedButton, (unsigned long)index);
                                            }];
    
    [self.view addSubview:tools];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
