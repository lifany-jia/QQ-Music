//
//  FirstCollectionCell.m
//  Music
//
//  Created by lifany on 2026/6/3.
//

#import "FirstCollectionCell.h"
#import <Masonry/Masonry.h>
@interface FirstCollectionCell ()
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *music;
@end
@implementation FirstCollectionCell
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
    
    self.image = [[UIImageView alloc] init];
    self.image.layer.cornerRadius = 5;
    self.image.clipsToBounds = YES;
    self.image.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.image];
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
        make.right.left.equalTo(self.contentView);
        make.height.mas_equalTo(125);
    }];
    
    self.music = [[UILabel alloc] init];
    self.music.font = [UIFont systemFontOfSize:13];
    self.music.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:self.music];
    [self.music mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.image.mas_bottom).offset(7);
            make.left.right.equalTo(self.contentView);
    }];
    
    self.title = [[UILabel alloc] init];
    self.title.font = [UIFont systemFontOfSize:13];
    self.title.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:self.title];
    [self.title mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.music.mas_bottom).offset(3);
            make.left.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
    }];
    
}
- (void)updateWithModel:(NSArray<NSString *> *)model {
    UIImage *ima = [UIImage imageNamed:model[0]];
    self.image.image = ima;
    self.title.text = model[0];
    self.music.text = model[1];
    
    CGFloat radio = ima.size.width / ima.size.height;
    CGFloat width = 125 * radio;
    [self.image mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
    }];
}
@end
