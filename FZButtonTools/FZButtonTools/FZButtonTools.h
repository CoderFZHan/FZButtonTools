//
//  FZButtonTools.h
//  FZButtonTools
//
//  Created by hanf on 16/2/1.
//  Copyright © 2016年 FZHan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tapAction)( UIButton * _Nullable selectedButton, NSInteger index);

@interface FZButtonTools : UIView

@property (nonatomic, copy, nullable) tapAction tap;

+ (nullable instancetype)fzWithFrame:(CGRect)frame
                              titles:(nonnull NSArray *)btnTitles
                           tapAction:(nonnull tapAction)tapDone;

- (nullable instancetype)initWithFrame:(CGRect)frame
                                titles:(nonnull NSArray *)btnTitles
                             tapAction:(nonnull tapAction)tapDone;

@end
