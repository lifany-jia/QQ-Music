//
//  MenuVC.m
//  Music
//
//  Created by lifany on 2026/6/10.
//

#import "MenuVC.h"
#import "HomeModel.h"
#import "MenuCell.h"
@interface MenuVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray<NSArray<NSString *> *> *model;
@property (nonatomic, strong) NSMutableArray<NSMutableArray<NSNumber *> *> *isOns;
@end

@implementation MenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"更多";
    UIImage *image = [UIImage systemImageNamed:@"qrcode.viewfinder"];
    UIBarButtonItem *qrcode = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = qrcode;
    
    self.model = [HomeModel defaultMenuModel];
    self.isOns = [HomeModel defaultIsOnsModel];
    
    [self setupTableView];
}
- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleInsetGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[MenuCell class] forCellReuseIdentifier:@"chevronCell"];
    [self.tableView registerClass:[MenuCell class] forCellReuseIdentifier:@"switchCell"];
    [self.tableView registerClass:[MenuCell class] forCellReuseIdentifier:@"loginOutCell"];
    [self.view addSubview:self.tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.model.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model[section].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuCell *cell;
    if ((indexPath.section == 1 && indexPath.row == 0) || (indexPath.section == 2)) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"switchCell" forIndexPath:indexPath];
        __weak typeof(self) weakSelf = self;
        cell.isChanged = ^(BOOL isOn) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.isOns[indexPath.section][indexPath.row] = @(isOn);
            [strongSelf darkMode:isOn];
        };
        BOOL isOn = [self.isOns[indexPath.section][indexPath.row] boolValue];
        [cell updateWithLabel:self.model[indexPath.section][indexPath.row] isOn:isOn];
    } else if (indexPath.section == 5 && indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"loginOutCell" forIndexPath:indexPath];
        [cell updateWithLabel:self.model[indexPath.section][indexPath.row]];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"chevronCell" forIndexPath:indexPath];
        [cell updateWithLabel:self.model[indexPath.section][indexPath.row]];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)darkMode:(BOOL) isOn {
    UIWindow *window = self.view.window;
    if (isOn) {
        window.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    } else {
        window.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
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
