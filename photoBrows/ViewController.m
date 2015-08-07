//
//  ViewController.m
//  photoBrows
//
//  Created by levy on 15/8/6.
//  Copyright (c) 2015年 levy. All rights reserved.
//

#import "ViewController.h"
#import "PhotoBrowser.h"
@interface ViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSMutableArray *arr;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * array = @[[UIImage imageNamed:@"photo1.jpg"], [UIImage imageNamed:@"photo2.jpg"], [UIImage imageNamed:@"photo3.jpg"]];
    
    _arr = [NSMutableArray arrayWithArray:array];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tap:(UITapGestureRecognizer *)sender {
    PhotoBrowser * view = [[PhotoBrowser alloc]initWithSourceData:_arr withIndex:1];
    [view setFrame:self.view.frame];
    [view setAlpha:0];
    [self.view addSubview:view];

    [UIView animateWithDuration:0.2 animations:^{
        [view setAlpha:1];
    }];
}


@end
