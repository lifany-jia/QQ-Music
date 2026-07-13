//
//  FirstSectionHeaderView.m
//  Music
//
//  Created by lifany on 2026/6/3.
//

#import "FirstSectionHeaderView.h"
#import <Masonry/Masonry.h>
@implementation FirstSectionHeaderView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    UIImageView *avatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar"]];
    avatar.contentMode = UIViewContentModeScaleAspectFill;
    avatar.layer.cornerRadius = 15;
    avatar.clipsToBounds = YES;
    [self addSubview:avatar];
    [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(20);
        make.width.height.mas_equalTo(30);
        make.bottom.equalTo(self).offset(-10);
    }];
    UILabel *name = [[UILabel alloc] init];
    name.textColor = [UIColor labelColor];
    name.text = @"黑化旺仔";
    [self addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(avatar);
        make.left.equalTo(avatar.mas_right).offset(10);
    }];
    
    UILabel *vip = [[UILabel alloc] init];
    vip.text = @"SVIP5";
    vip.backgroundColor = [UIColor colorWithRed:73 / 255.0 green:56 / 255.0 blue:34 / 255.0 alpha:1.0];
    vip.layer.cornerRadius = 8;
    vip.clipsToBounds = YES;
    vip.textAlignment = UITextAlignmentCenter;
    vip.font = [UIFont systemFontOfSize:11];
    vip.textColor = [UIColor systemYellowColor];
    [self addSubview:vip];
    [vip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(avatar);
        make.left.equalTo(name.mas_right).offset(7);
        make.width.mas_equalTo(42);
        make.height.mas_equalTo(15);
    }];
    
    UIImageSymbolConfiguration *config = [UIImageSymbolConfiguration configurationWithPointSize:12];
    UIImage *arrowIma = [[UIImage systemImageNamed:@"chevron.right"] imageWithConfiguration:config];
    UIImageView *arrow = [[UIImageView alloc] initWithImage:arrowIma];
    arrow.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:arrow];
    arrow.tintColor = [UIColor secondaryLabelColor];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(avatar);
        make.right.equalTo(self).offset(-20);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor secondaryLabelColor];
    label.text = @"查看我的音乐DNA";
    label.font = [UIFont systemFontOfSize:13];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(avatar);
        make.right.equalTo(arrow.mas_left).offset(-5);
    }];
}
@end
