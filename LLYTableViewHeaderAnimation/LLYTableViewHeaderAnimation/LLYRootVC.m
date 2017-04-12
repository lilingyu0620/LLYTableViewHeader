//
//  LLYRootVC.m
//  LLYTableViewHeaderAnimation
//
//  Created by lly on 2017/4/12.
//  Copyright © 2017年 lly. All rights reserved.
//

#import "LLYRootVC.h"
#import "LLYTableviewHeaderAnimation.h"

@interface LLYRootVC ()


@end

@implementation LLYRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClicked:(id)sender {
    
    LLYTableviewHeaderAnimation *vc = [[LLYTableviewHeaderAnimation alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
