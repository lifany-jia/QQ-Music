//
//  SecondSectionCell.m
//  Music
//
//  Created by lifany on 2026/6/4.
//

#import "SecondSectionCell.h"
#import "SecondCollectionCell.h"
#import <Masonry/Masonry.h>
@interface SecondSectionCell () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSArray<NSArray<NSString *> *> *model;
@end
@implementation SecondSectionCell

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
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.layout.minimumLineSpacing = 40;
    self.layout.minimumInteritemSpacing = 10;
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout.headerReferenceSize = CGSizeZero;
    self.layout.footerReferenceSize = CGSizeZero;
    self.layout.estimatedItemSize = CGSizeZero;
    self.layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    
    self.collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    self.collection.backgroundColor = [UIColor systemGray6Color];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    self.collection.pagingEnabled = YES;
    self.collection.showsHorizontalScrollIndicator = NO;
    self.collection.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.collection registerClass:[SecondCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    [self.contentView addSubview:self.collection];
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
            make.height.mas_equalTo(200);
    }];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SecondCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell updateWithModel:self.model[indexPath.item]];
    return cell;
}

- (void)updateWithModel:(NSArray<NSArray<NSString *> *> *)model {
    self.model = model;
    [self.collection reloadData];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.collection.bounds.size.width - self.layout.sectionInset.left - self.layout.sectionInset.right;
    self.layout.itemSize = CGSizeMake(width, 60);
}

@end
