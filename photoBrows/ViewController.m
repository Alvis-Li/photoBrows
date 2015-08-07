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
    
    NSArray * array = @[[UIImage imageNamed:@"photo4.jpg"], [UIImage imageNamed:@"photo5.jpg"], [UIImage imageNamed:@"photo6.jpg"]];

    PhotoBrowser * view = [[PhotoBrowser alloc]initWithSourceData:_arr withIndex:2];
    
    __weak PhotoBrowser * tempView = view;
    [view setBlock:^{
        NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:
                               NSMakeRange(0,[array count])];
        
        [_arr insertObjects:array atIndexes:indexes];
        [tempView setIndex:array.count+1];
        [tempView setData:_arr];
        [tempView setCanRefresh:YES];
        [tempView viewDidLoad];
    }];
    
    
    [view setFrame:self.view.frame];
    [view setAlpha:0];
    [self.view addSubview:view];

    [UIView animateWithDuration:0.2 animations:^{
        [view setAlpha:1];
    }];
}


@end
