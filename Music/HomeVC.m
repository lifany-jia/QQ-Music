//
//  HomeVC.m
//  Music
//
//  Created by lifany on 2026/6/2.
//

#import "HomeVC.h"
#import "FirstSectionHeaderView.h"
#import "FirstSectionCell.h"
#import "HomeModel.h"
#import "HomeHeaderView.h"
#import <Masonry/Masonry.h>
@interface HomeVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray<NSString *> *> *firstSectionModel;
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    
    self.firstSectionModel = [HomeModel defaultFirstSectionModel];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 64)];
    // iOS15之后，UITableView默认会给section和header顶部加一段padding，设为0
    self.tableView.sectionHeaderTopPadding = 0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    [self.tableView registerClass:[FirstSectionCell class] forCellReuseIdentifier:@"firstSectionCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
}
#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        FirstSectionHeaderView *view = [[FirstSectionHeaderView alloc] init];
        return view;
    } else if (section == 1) {
        UIView *view = [self secondSectionHeader:@"听 「Shy Girl」 也会喜欢"];
        return view;
    } else if (section == 2) {
        UIView *view = [self threeSectionHeader];
        return view;
    } else if (section == 3) {
        UIView *view = [self secondSectionHeader:@"「黑化旺仔」的专属好歌"];
        return view;
    }
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        FirstSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstSectionCell" forIndexPath:indexPath];
        [cell updateWithModel:self.firstSectionModel];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

#pragma mark - SectionHeader
- (UIView *)secondSectionHeader:(NSString *) name {
    UIView *view = [[UIView alloc] init];
    UILabel *title = [[UILabel alloc] init];
    title.text = name;
    [view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(10);
        make.left.equalTo(view).offset(20);
        make.bottom.equalTo(view).offset(-10);
    }];
    
    UIImageSymbolConfiguration *config = [UIImageSymbolConfiguration configurationWithPaletteColors:@[
        [UIColor blackColor],
        [UIColor systemGray4Color]
    ]];
    UIImage *ima = [[UIImage systemImageNamed:@"play.circle"] imageWithConfiguration:config];
    UIImageView *imaV = [[UIImageView alloc] initWithImage:ima];
    imaV.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imaV];
    [imaV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(title);
        make.left.equalTo(title.mas_right).offset(10);
        make.width.height.mas_equalTo(25);
    }];
    return view;
}
- (UIView *)threeSectionHeader {
    UIView *view = [[UIView alloc] init];
    UILabel *title = [[UILabel alloc] init];
    title.text = @"为你精选的AI歌单";
    [view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view).offset(10);
            make.left.equalTo(view).offset(20);
        make.bottom.equalTo(view).offset(-10);
    }];
    
    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"chevron.right"]];
    arrow.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:arrow];
    arrow.tintColor = [UIColor secondaryLabelColor];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(title);
            make.right.equalTo(view).offset(-20);
    }];
    return view;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
