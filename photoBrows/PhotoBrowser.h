//
//  PhotoBrowser.h
//  GJGCChatInputPanel
//
//  Created by levy on 15/8/6.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoBrowser : UIView
@property (strong, nonatomic) NSMutableArray *data;
@property (assign, nonatomic) NSInteger index;

- (id)initWithSourceData:(NSMutableArray *)data withIndex:(NSInteger)index;
@end
