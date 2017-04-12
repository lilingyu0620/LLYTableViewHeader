//
//  ViewController.m
//  LLYTableViewHeaderAnimation
//
//  Created by lly on 2017/4/12.
//  Copyright © 2017年 lly. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (nonatomic,strong) UIImageView *mImageView;
@property (nonatomic,strong) UIView *headerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
//    self.mImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -16, self.view.frame.size.width, 200)];
//    [self.mImageView setImage:[UIImage imageNamed:@"headerImage"]];
//    self.mImageView.contentMode = UIViewContentModeScaleAspectFill;
////    self.mTableView.tableHeaderView = self.mImageView;
//    self.headerView = [[UIView alloc]initWithFrame:self.mImageView.frame];
//    self.mTableView.tableHeaderView = self.headerView;
//    [self.headerView addSubview:self.mImageView];
    
    
    
    [self.mTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 50;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [UIColor redColor];
    return  cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80.0f;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat width = self.view.frame.size.width; // 图片宽度
//        
//        self.headerImageView.frame =  CGRectMake(- (width * f - width) / 2, yOffset, width * f, totalOffset); //拉伸后的图片的frame应该是同比例缩放。
        

        
//    CGFloat offsetY = scrollView.contentOffset.y;
//    NSLog(@"===%f===",offsetY);
//    if (offsetY < 0) {
////        CGFloat scale = fabs(offsetY)/200 + 1;
//        CGFloat totalOffset = 200 + ABS(offsetY);
//        CGFloat f = totalOffset / 200;
////        self.mImageView.layer.affineTransform = CGAffineTransformMakeScale(f, f);
////        self.mImageView.layer.position = CGPointMake(self.view.frame.size.width/2, (200-offsetY)/2);
//        self.mImageView.frame =  CGRectMake(- (width * f - width) / 2, offsetY - 16, width * f, totalOffset);
//
//    }

}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//    return 200;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
////    self.mImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
////    [self.mImageView setImage:[UIImage imageNamed:@"headerImage"]];
////    self.mImageView.contentMode = UIViewContentModeScaleAspectFill;
//    
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
//    view.backgroundColor = [UIColor blueColor];
//    return view;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
