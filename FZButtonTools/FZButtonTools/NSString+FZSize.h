//
//  NSString+FZSize.h
//  FZButtonTools
//
//  Created by hanf on 16/2/1.
//  Copyright © 2016年 FZHan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FZSize)

/**
 *  UILabel自适应
 *
 *  @param size 期望UILabel显示区域的大小
 *
 *  @return CGSize对象
 */
- (CGSize)calculationSize:(CGSize)size font:(UIFont *)font;

@end
