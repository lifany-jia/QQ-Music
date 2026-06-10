//
//  MenuCell.m
//  Music
//
//  Created by lifany on 2026/6/10.
//

#import "MenuCell.h"
#import <Masonry/Masonry.h>
@interface MenuCell ()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *chevron;
@property (nonatomic, strong) UISwitch *switchIcon;
@end
@implementation MenuCell

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
        if ([reuseIdentifier isEqualToString:@"chevronCell"]) {
            [self setupChevron];
        } else if ([reuseIdentifier isEqualToString:@"switchCell"]) {
            [self setupSwitch];
        } else if ([reuseIdentifier isEqualToString:@"loginOutCell"]) {
            [self setupLoginOut];
        }
    }
    return self;
}
- (void)setupChevron {
    self.label = [[UILabel alloc] init];
    self.label.textColor = [UIColor labelColor];
    [self.contentView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(20);
    }];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}
- (void)setupSwitch {
    self.label = [[UILabel alloc] init];
    self.label.textColor = [UIColor labelColor];
    [self.contentView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(20);
    }];
    
    self.switchIcon = [[UISwitch alloc] init];
    [self.contentView addSubview:self.switchIcon];
    [self.switchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-20);
    }];
    [self.switchIcon addTarget:self action:@selector(switchIsSelected) forControlEvents:UIControlEventValueChanged];
    self.switchIcon.on = NO;
}
- (void)setupLoginOut {
    self.label = [[UILabel alloc] init];
    self.label.textColor = [UIColor labelColor];
    [self.contentView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self.contentView);
    }];
    
    UIImageView *loginOut = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"rectangle.portrait.and.arrow.right"]];
    loginOut.tintColor = [UIColor labelColor];
    loginOut.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:loginOut];
    [loginOut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.label);
        make.right.equalTo(self.label.mas_left).offset(-8);
        make.width.height.mas_equalTo(20);
    }];
}
- (void)updateWithLabel:(NSString *)label {
    self.label.text = label;
}
- (void)updateWithLabel:(NSString *)label isOn:(BOOL)isOn {
    self.label.text = label;
    self.switchIcon.on = isOn;
}
- (void)switchIsSelected {
    if (self.isChanged) {
        self.isChanged(self.switchIcon.on);
    }
}
@end
