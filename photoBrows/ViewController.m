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
    NSArray * array = @[[UIImage imageNamed:@"photo1.jpg"]];
    
    _arr = [NSMutableArray arrayWithArray:array];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tap:(UITapGestureRecognizer *)sender {
    
    NSMutableArray * imageArray = [NSMutableArray arrayWithArray:@[[UIImage imageNamed:@"photo1.jpg"]]];
    NSMutableArray * imageUrlArray = [NSMutableArray arrayWithArray:@[@"http://img.bugwe.com/1yun/1c36e87a20f62bd87dc4ee93c4890aa2.jpg"]];
    PhotoBrowser * view = [[PhotoBrowser alloc]initWithSourceData:imageArray dataUrl:imageUrlArray withIndex:0];
    UIWindow * window = [[UIApplication sharedApplication].windows lastObject];
    
    [view setFrame:window.frame];
    [view setAlpha:0];
    [window addSubview:view];
    
    [UIView animateWithDuration:0.2 animations:^{
        [view setAlpha:1];
    }];
}


@end
