//
//  FZButtonTools.m
//  FZButtonTools
//
//  Created by hanf on 16/2/1.
//  Copyright © 2016年 FZHan. All rights reserved.
//

#import "FZButtonTools.h"
#import "NSString+FZSize.h"

#define BTN_FONT [UIFont systemFontOfSize:17.0]
#define WIDTH self.bounds.size.width
#define HEIGHT self.bounds.size.height

const CGFloat sliderHeight = 2.0;

@interface FZButtonTools () <UIScrollViewDelegate>

/** 主视图 */
@property (nonatomic, strong) UIScrollView *mainView;
/** 滑条 */
@property (nonatomic, strong) UIView *sliderView;
/** 标题数组 */
@property (nonatomic, strong) NSArray *titles;
/** 按钮数组 */
@property (nonatomic, strong) NSMutableArray *buttons;
/** 选中下标 */
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, assign) float tempX;// 临时x坐标, 方便添加 Button 用

@end

@implementation FZButtonTools

+ (nullable instancetype)fzWithFrame:(CGRect)frame
                              titles:(nonnull NSArray *)btnTitles
                           tapAction:(nonnull tapAction)tapDone
{
    return [[self alloc] initWithFrame:frame
                                titles:btnTitles
                             tapAction:[tapDone copy]];
}

- (nullable instancetype)initWithFrame:(CGRect)frame
                                titles:(nonnull NSArray *)btnTitles
                             tapAction:(nonnull tapAction)tapDone
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.frame = frame;
        
        if (tapDone) {
            _tap = [tapDone copy];
        }
        _tempX = 0.0;
        _titles = [btnTitles copy];
        _buttons = [NSMutableArray array];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    
    _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _mainView.delegate = self;
    _mainView.showsHorizontalScrollIndicator = NO;
    _mainView.showsVerticalScrollIndicator = NO;
    [self addSubview:_mainView];
    
    if (!_titles.count) return;
    
    for (NSInteger i = 0; i < _titles.count; i ++) {
        UIButton *btn = [self creatBtn:i];
        [_buttons addObject:btn];
        [_mainView addSubview:btn];
    }
    
    UIButton *firstBtn = [_buttons firstObject];
    _sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT - sliderHeight, firstBtn.bounds.size.width, sliderHeight)];
    _sliderView.backgroundColor = [UIColor redColor];
    [_mainView addSubview:_sliderView];
}

- (UIButton *)creatBtn:(NSInteger)index {
    
    float btnWidth = [_titles[index] calculationSize:CGSizeMake(MAXFLOAT, MAXFLOAT) font:BTN_FONT].width + 20.0;
    CGRect btnFrame = CGRectMake(_tempX, 0, btnWidth, HEIGHT - sliderHeight);
    
    UIButton *button = [[UIButton alloc] initWithFrame:btnFrame];
    button.tag = 7000 + index;
    [button setTitle:_titles[index] forState:UIControlStateNormal];
    [button.titleLabel setFont:BTN_FONT];
    [button setAdjustsImageWhenHighlighted:NO];
    if (index == 0) {
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button setSelected:YES];
        _selectedIndex = button.tag;
        _tap(button, button.tag);
    } else {
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setSelected:NO];
    }
    [button addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
    _tempX = CGRectGetMaxX(button.frame);
    
    if (index == _titles.count - 1) {
        _mainView.contentSize = CGSizeMake(CGRectGetMaxX(button.frame), HEIGHT);
    }
    
    return button;
}

- (void)btnTap:(UIButton *)sender {
    
    if (!sender.selected) {
        
        UIButton *lastSelectedBtn = _buttons[_selectedIndex - 7000];
        [lastSelectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [lastSelectedBtn setSelected:NO];
        
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [sender setSelected:YES];
        _selectedIndex = sender.tag;
        
        _tap(sender, sender.tag);
        [self scrollFZToolsView:sender];
        
        [UIView animateWithDuration:0.2 animations:^{
            _sliderView.frame = CGRectMake(sender.frame.origin.x, HEIGHT - sliderHeight, sender.frame.size.width, sliderHeight);
        } completion:nil];
    }
}

- (void)scrollFZToolsView:(UIButton *)selected {
    
    if (_mainView.contentSize.width > WIDTH) {
        
        CGPoint offsetPoint;
        float offset = _mainView.contentOffset.x;
        
        if (selected.center.x <= self.center.x)
        {
            if (offset) {
                offsetPoint = CGPointMake(0, 0);
            } else {
                return;
            }
        }
        else if (selected.center.x > self.center.x && CGRectGetMinX(selected.frame) < _mainView.contentSize.width - WIDTH)
        {
            CGRect rest = [selected.superview convertRect:selected.frame toView:self.superview];
            UIView *tempV = [[UIView alloc] initWithFrame:rest];
            
            if (offset != tempV.center.x - self.center.x) {
                offset += (tempV.center.x - self.center.x);
                offsetPoint = CGPointMake(offset, 0);
            } else {
                return;
            }
        }
        else if (CGRectGetMinX(selected.frame) >= _mainView.contentSize.width - WIDTH)
        {
            if (offset != _mainView.contentSize.width - WIDTH) {
                offset = _mainView.contentSize.width - WIDTH;
                offsetPoint = CGPointMake(offset, 0);
            } else {
                return;
            }
        }
        [_mainView setContentOffset:offsetPoint animated:YES];
    }
}

@end
