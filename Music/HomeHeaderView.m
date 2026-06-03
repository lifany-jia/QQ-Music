//
//  HomeHeaderView.m
//  Music
//
//  Created by lifany on 2026/6/3.
//

#import "HomeHeaderView.h"
#import "Symbols/Symbols.h"
#import <Masonry/Masonry.h>
@implementation HomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    UISearchBar *search = [[UISearchBar alloc] init];
    search.searchBarStyle = UISearchBarStyleMinimal;
    search.placeholder = @"请搜索";
    [self addSubview:search];
    [search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.width.mas_equalTo(295);
    }];
    
    // 调色板模式
    UIImageSymbolConfiguration *micConfig = [UIImageSymbolConfiguration configurationWithPaletteColors:@[
        [UIColor systemGreenColor],
        [UIColor systemGray4Color]
    ]];
    UIImage *mic = [UIImage systemImageNamed:@"microphone.circle" withConfiguration:micConfig];
    UIImageView *micV = [[UIImageView alloc] initWithImage:mic];
    micV.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:micV];
    [micV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(search);
        make.right.equalTo(self).offset(-20);
        make.width.height.mas_equalTo(30);
    }];
    
    UIImage *money = [UIImage systemImageNamed:@"chineseyuanrenminbisign.circle.fill"];
    UIImageView *moneyV = [[UIImageView alloc] initWithImage:money];
    moneyV.tintColor = [UIColor systemYellowColor];
    moneyV.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:moneyV];
    [moneyV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(search);
        make.right.equalTo(micV.mas_left).offset(-10);
        make.width.height.mas_equalTo(30);
    }];
    
    NSSymbolEffectOptionsRepeatBehavior *repeat = [NSSymbolEffectOptionsRepeatBehavior behaviorPeriodic];
    NSSymbolEffectOptions *option = [NSSymbolEffectOptions optionsWithRepeatBehavior:repeat];
    [moneyV addSymbolEffect:[NSSymbolBounceEffect effect]
                    options:option
                   animated:YES
                 completion:nil];
    
}
@end
