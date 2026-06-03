//
//  FirstSectionCell.m
//  Music
//
//  Created by lifany on 2026/6/3.
//

#import "FirstSectionCell.h"
#import "FirstCollectionCell.h"
#import <Masonry/Masonry.h>
@interface FirstSectionCell () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, copy) NSArray<NSArray<NSString *> *> *model;
@end
@implementation FirstSectionCell

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
        self.model = [NSArray array];
        [self setupCollection];
    }
    return self;
}
- (void)setupCollection {
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.layout.minimumInteritemSpacing = 10;
    self.layout.headerReferenceSize = CGSizeZero;
    self.layout.footerReferenceSize = CGSizeZero;
    self.layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
    self.layout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20);
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    self.collection.showsHorizontalScrollIndicator = NO;
    [self.collection registerClass:[FirstCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    [self.contentView addSubview:self.collection];
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(180);
    }];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FirstCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell updateWithModel:self.model[indexPath.item]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}
- (void)updateWithModel:(NSArray<NSArray<NSString *> *> *)model {
    self.model = model;
    [self.collection reloadData];
}
@end
