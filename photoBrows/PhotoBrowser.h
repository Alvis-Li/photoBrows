//
//  PhotoBrowser.h
//  GJGCChatInputPanel
//
//  Created by levy on 15/8/6.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^refreshBlock)();

@interface PhotoBrowser : UIView
@property (strong, nonatomic) NSMutableArray *data;
@property (strong, nonatomic) NSMutableArray *dataUrl;

@property (assign, nonatomic) NSInteger index;
@property (assign, nonatomic) BOOL canRefresh;

-(id)initWithSourceData:(NSMutableArray *)data dataUrl:(NSMutableArray *)dataUrl withIndex:(NSInteger)index;

-(void)setBlock:(refreshBlock)block;
-(void)viewDidLoad;
@end
