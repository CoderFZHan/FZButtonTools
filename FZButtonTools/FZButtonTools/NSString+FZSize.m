//
//  NSString+FZSize.m
//  FZButtonTools
//
//  Created by hanf on 16/2/1.
//  Copyright © 2016年 FZHan. All rights reserved.
//

#import "NSString+FZSize.h"

@implementation NSString (FZSize)

- (CGSize)calculationSize:(CGSize)size font:(UIFont *)font {
    
    // 设置计算字符串高度时使用的断行模式（设置了该属性，才能和UILabel的此属性呼应）
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    NSDictionary *attribute = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    
#ifdef __IPHONE_7_0
    CGSize adaptiveSize = [self boundingRectWithSize:size
                                             options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
#else
    CGSize adaptiveSize = [self sizeWithFont:font constrainedToSize:size]
#endif
    
    return adaptiveSize;
}

@end
