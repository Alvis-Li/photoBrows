//
//  PhotoBrowser.m
//  GJGCChatInputPanel
//
//  Created by levy on 15/8/6.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import "PhotoBrowser.h"
@interface PhotoBrowser()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    UIScrollView *bottomScrollView;
    NSMutableArray *imagePointArray;
    NSMutableArray *imageScaleArray;
}
@end

@implementation PhotoBrowser
-(id)initWithSourceData:(NSMutableArray *)data withIndex:(NSInteger)index
{
    self = [super init];
    if (self) {
        _data = [data copy];
        _index = index ? index : 0;
        [self viewDidLoad];
    }
    return self;
}

-(void)viewDidLoad
{
    imagePointArray = [NSMutableArray array];
    imageScaleArray = [NSMutableArray array];
    
    [self setBackgroundColor:[UIColor blackColor]];
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
    
    [self creatBottomScrollView];
    
    for (int i = 0 ; i< _data.count; i++) {
        UIImage * image = (UIImage *)_data[i];
        [self createImageScroll:image index:i];
    }
}
-(void)creatBottomScrollView{
    bottomScrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen ].applicationFrame];
    
    bottomScrollView.delegate = self;
    bottomScrollView.showsHorizontalScrollIndicator = NO;
    bottomScrollView.showsVerticalScrollIndicator = NO;
    bottomScrollView.pagingEnabled = YES;
    bottomScrollView.backgroundColor = [UIColor clearColor];
    bottomScrollView.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen ].applicationFrame)*_data.count, 0);
    bottomScrollView.contentOffset = CGPointMake(CGRectGetWidth([UIScreen mainScreen ].applicationFrame)*_index, 0);
    [self addSubview:bottomScrollView];
    
}

-(void)createImageScroll:(UIImage *)image index:(int)index{
    
    CGFloat width = CGRectGetWidth([UIScreen mainScreen ].applicationFrame);
    CGSize size = image.size;
    CGFloat hight = CGRectGetHeight([UIScreen mainScreen ].applicationFrame);
    CGFloat yHight = size.height*1./size.width * width;
    CGRect rect = CGRectMake(0,  hight>yHight ?(hight - yHight)/2.f : 0, width, yHight);
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView setImage:image];
    [imageView setFrame:rect];
    [imageView setUserInteractionEnabled:YES];
    [imageView setTag:(1000+index)];
     UIScrollView * bottomView = [[UIScrollView alloc]initWithFrame:CGRectMake(width*index, 0, width, hight)];
    [bottomView setBackgroundColor:[UIColor clearColor]];
    
    UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePin:)];
    pin.delegate = self;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    pan.delegate = self;
    pan.minimumNumberOfTouches = 2;

    [imageView addGestureRecognizer:pin];
    [imageView addGestureRecognizer:pan];
    
    CGFloat imageScale = 1;
    CGPoint imagePoint = imageView.center;
    [imagePointArray addObject:NSStringFromCGPoint(imagePoint)];
    [imageScaleArray addObject:[NSNumber numberWithFloat:imageScale]];
    
    [bottomView addSubview:imageView];
    [bottomScrollView addSubview:bottomView];
    
}
-(void)handlePin:(UIPinchGestureRecognizer *)pin
{   if(pin.view.tag<1000) return;
    
    CGFloat imageScale = [imageScaleArray[pin.view.tag-1000] floatValue];
    
    if (pin.state == UIGestureRecognizerStateEnded) {
        imageScale = pin.scale;
        
        if (pin.scale<1) {
            imageScale = pin.scale = 1;
            [UIView animateWithDuration:0.3 animations:^{
                pin.view.transform = CGAffineTransformMakeScale(1,1);
                
            }];
            return;
        }
    }else if(pin.state == UIGestureRecognizerStateBegan && imageScale != 0.0f){
        pin.scale = imageScale;
    }
    if (pin.scale>2.0f) {
        imageScale = pin.scale = 2;
    }
    
    if (pin.scale !=NAN && pin.scale != 0.0) {
        pin.view.transform = CGAffineTransformMakeScale(pin.scale, pin.scale);
    }
}

-(void)handlePan:(UIPanGestureRecognizer *)pan
{
    if(pan.view.tag<1000) return;
    CGPoint imagePoint = CGPointFromString(imagePointArray[pan.view.tag-1000]);
    CGPoint point=[pan translationInView:pan.view.superview];// translation :平移 获取相对坐标原点的坐标
    pan.view.center=CGPointMake(pan.view.center.x+point.x, pan.view.center.y+point.y);
    [pan setTranslation:CGPointZero inView:pan.view];//设置坐标原点位上次的坐标
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.2 animations:^{
            pan.view.center = imagePoint;
        }];
        bottomScrollView.scrollEnabled = YES;
    }else if(pan.state == UIGestureRecognizerStateBegan){
        bottomScrollView.scrollEnabled = NO;
    }
}




-(void)tapAction:(UITapGestureRecognizer *)tap
{
    [UIView animateWithDuration:0.3f animations:^{
        [tap.view setAlpha:0];
    } completion:^(BOOL finished) {
        [tap.view removeFromSuperview];
    }];
}


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
