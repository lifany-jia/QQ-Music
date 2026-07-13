//
//  DrawerVC.m
//  Music
//
//  Created by lifany on 2026/6/10.
//

#import "DrawerVC.h"
#import "HomeModel.h"
#import <Masonry/Masonry.h>
@interface DrawerVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *drawView;
@property (nonatomic, assign) CGFloat drawerWidth;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, copy) NSArray<NSString *> *model;
@end

@implementation DrawerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.drawerWidth = 290;
    self.view.backgroundColor = [UIColor clearColor];
    self.model = [HomeModel defaultDrawerModel];
    [self setupMaskView];
    [self setupDrawerView];
    [self setupTableView];
}
- (void)setupMaskView {
    self.maskView = [[UIView alloc] init];
    self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.35];
    self.maskView.alpha = 0;
    [self.view addSubview:self.maskView];
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeDrawer)];
    [self.maskView addGestureRecognizer:tap];
}

- (void)setupDrawerView {
    self.drawView = [[UIView alloc] init];
    self.drawView.layer.cornerRadius = 50;
    self.drawView.backgroundColor = [UIColor systemBackgroundColor];
    [self.view addSubview:self.drawView];
    
    [self.drawView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.view);
            make.width.mas_equalTo(self.drawerWidth);
            make.left.mas_equalTo(-self.drawerWidth);
    }];
    self.label = [[UILabel alloc] init];
    self.label.text = @"菜单";
    self.label.font = [UIFont systemFontOfSize:19];
    self.label.textColor = [UIColor labelColor];
    [self.drawView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.drawView);
            make.top.equalTo(self.drawView).offset(70);
    }];
}
- (void)openDrawer {
    self.maskView.hidden = NO;
    [self.drawView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        self.maskView.alpha = 1;
        [self.view layoutIfNeeded];
    }];
}
- (void)closeDrawer {
    [self.drawView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(-self.drawerWidth);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        self.maskView.alpha = 0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.maskView.hidden = YES;
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self openDrawer];
}
- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleInsetGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.layer.cornerRadius = 50;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label.mas_bottom).offset(20);
            make.left.right.bottom.equalTo(self.drawView);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.model[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
