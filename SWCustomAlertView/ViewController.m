//
//  ViewController.m
//  SWCustomAlertView
//
//  Created by sunwei on 16/10/19.
//  Copyright © 2016年 sunwei. All rights reserved.
//

#import "ViewController.h"
#import "SWCustomAlertView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)oneAlert:(id)sender {
    SWCustomAlertView *alert = [[SWCustomAlertView alloc] initWithTitle:@"一个弹框" message:@"1" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] actionBlock:^(NSInteger buttonIndex) {
        
    }];
    [alert show];
}
- (IBAction)twoAlert:(id)sender {
    SWCustomAlertView *alert = [[SWCustomAlertView alloc] initWithTitle:@"第一个弹框" message:@"1" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] actionBlock:^(NSInteger buttonIndex) {
        
    }];
    [alert show];
    
    SWCustomAlertView *alert1 = [[SWCustomAlertView alloc] initWithTitle:@"第二个弹框" message:@"2" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] actionBlock:^(NSInteger buttonIndex) {
        
    }];
    [alert1 show];
}
- (IBAction)onlyOneAlert:(id)sender {
    SWCustomAlertView *alert = [[SWCustomAlertView alloc] initWithTitle:@"第一个弹框" message:@"1" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] actionBlock:^(NSInteger buttonIndex) {
        
    }];
    //当前有SWCustomAlertView展示时，就不在展示这个
    alert.isOnlyOne = YES;
    [alert show];
    
    SWCustomAlertView *alert1 = [[SWCustomAlertView alloc] initWithTitle:@"第二个弹框" message:@"2" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] actionBlock:^(NSInteger buttonIndex) {
        
    }];
    alert1.isOnlyOne = YES;
    [alert1 show];
}
- (IBAction)moreAlert:(id)sender {
    SWCustomAlertView *alert = [[SWCustomAlertView alloc] initWithTitle:@"第一个弹框" message:@"1" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] actionBlock:^(NSInteger buttonIndex) {
        
    }];
    alert.isOnlyOne = YES;
    [alert show];
    
    SWCustomAlertView *alert1 = [[SWCustomAlertView alloc] initWithTitle:@"第二个弹框" message:@"2" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] actionBlock:^(NSInteger buttonIndex) {
        
    }];
    alert1.isOnlyOne = YES;
    [alert1 show];
    SWCustomAlertView *alert2 = [[SWCustomAlertView alloc] initWithTitle:@"第三个弹框" message:@"3" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] actionBlock:^(NSInteger buttonIndex) {
        
    }];
    [alert2 show];
}


- (IBAction)notDisappear:(id)sender {
    SWCustomAlertView *alert = [[SWCustomAlertView alloc] initWithTitle:@"第一个弹框" message:@"1" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] actionBlock:^(NSInteger buttonIndex) {
        
    }];
    //SWCustomAlertView 不掉用dismiss那么就不会消失
    alert.alwayDisplay = YES;
    [alert show];
    
    [self performSelector:@selector(close:) withObject:alert afterDelay:5.0];
}

- (void)close:(SWCustomAlertView *)alert {
    [alert dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
