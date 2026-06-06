//
//  SecondCollectionCell.m
//  Music
//
//  Created by lifany on 2026/6/4.
//

#import "SecondCollectionCell.h"
#import <Masonry/Masonry.h>
@interface SecondCollectionCell ()
@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UIImageView *like;
@property (nonatomic, strong) UILabel *musicName;
@property (nonatomic, strong) UILabel *authorName;
@property (nonatomic, strong) UILabel *label;
@end
@implementation SecondCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    self.contentView.layer.cornerRadius = 5;
    self.contentView.clipsToBounds = YES;
    
    self.avatar = [[UIImageView alloc] init];
    self.avatar.layer.cornerRadius = 5;
    self.avatar.clipsToBounds = YES;
    self.avatar.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.avatar];
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.contentView);
        make.height.width.mas_equalTo(60);
    }];
    
    self.musicName = [[UILabel alloc] init];
    self.musicName.font = [UIFont systemFontOfSize:15];
    self.musicName.textColor = [UIColor labelColor];
    self.musicName.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:self.musicName];
    [self.musicName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).offset(10);
        make.top.equalTo(self.avatar).offset(15);
        make.width.mas_equalTo(200);
    }];
    
    self.authorName = [[UILabel alloc] init];
    self.authorName.font = [UIFont systemFontOfSize:12];
    self.authorName.textColor = [UIColor secondaryLabelColor];
    self.authorName.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:self.authorName];
    [self.authorName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.musicName.mas_bottom).offset(5);
        make.left.equalTo(self.musicName);
        make.width.mas_equalTo(130);
    }];
    
    self.like = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"heart"]];
    self.like.tintColor = [UIColor secondaryLabelColor];
    [self.contentView addSubview:self.like];
    [self.like mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.avatar);
        make.right.equalTo(self.contentView).offset(-5);
        make.width.height.mas_equalTo(25);
    }];
    
    UIView *back = [[UIView alloc] init];
    back.backgroundColor = [UIColor systemBackgroundColor];
    back.layer.cornerRadius = 5;
    back.clipsToBounds = YES;
    [self.contentView addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.authorName);
        make.right.equalTo(self.like.mas_left).offset(-5);
    }];
    self.label = [[UILabel alloc] init];
    self.label.font = [UIFont systemFontOfSize:9];
    self.label.backgroundColor = [UIColor clearColor];
    self.label.textColor = [UIColor secondaryLabelColor];
    self.label.layer.cornerRadius = 4;
    self.label.layer.masksToBounds = YES;
    [back addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(back).insets(UIEdgeInsetsMake(2, 3, 2, 3));
    }];
    
}
- (void)updateWithModel:(NSArray<NSString *> *)model {
    UIImage *ima = [UIImage imageNamed:model[0]];
    self.avatar.image = ima;
    self.musicName.text = model[0];
    self.authorName.text = model[1];
    self.label.text = model[2];
}
@end
