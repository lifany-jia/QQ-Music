//
//  PersonPlayListsCell.m
//  Music
//
//  Created by lifany on 2026/6/7.
//

#import "PersonPlayListsCell.h"
#import <Masonry/Masonry.h>
@interface PersonPlayListsCell ()
@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *number;
@end
@implementation PersonPlayListsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
    }
    return self;
}
- (void)setupCell {
    self.contentView.backgroundColor = [UIColor systemGray6Color];
    self.avatar = [[UIImageView alloc] init];
    self.avatar.contentMode = UIViewContentModeScaleAspectFill;
    self.avatar.layer.cornerRadius = 5;
    self.avatar.clipsToBounds = YES;
    [self.contentView addSubview:self.avatar];
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(5);
        make.bottom.equalTo(self.contentView).offset(-5);
        make.left.equalTo(self.contentView);
        make.width.height.mas_equalTo(70);
    }];
    
    self.name = [[UILabel alloc] init];
    self.name.textColor = [UIColor labelColor];
    self.name.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avatar).offset(15);
            make.left.equalTo(self.avatar.mas_right).offset(10);
    }];
    
    self.number = [[UILabel alloc] init];
    self.number.textColor = [UIColor secondaryLabelColor];
    self.number.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.number];
    [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.name.mas_bottom).offset(6);
            make.left.equalTo(self.name);
    }];
}
- (void)updateWithModel:(NSArray<NSString *> *)model {
    self.name.text = model[0];
    self.number.text = model[1];
    UIImage *image = [UIImage imageNamed:model[0]];
    self.avatar.image = image;

}
@end
