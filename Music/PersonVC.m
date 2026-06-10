//
//  PersonVC.m
//  Music
//
//  Created by lifany on 2026/6/2.
//

#import "PersonVC.h"
#import "HomeModel.h"
#import "MenuVC.h"
#import "PersonPlayListsCell.h"
#import <Masonry/Masonry.h>
@interface PersonVC () <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIScrollView *scr;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UISearchBar *search;
// 自定义tab
@property (nonatomic, strong) UIButton *selfCreatedBtn;
@property (nonatomic, strong) UIButton *collectedBtn;
@property (nonatomic, strong) UIView *indicator;
@property (nonatomic, strong) UIScrollView *segScr;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray<NSString *> *> *model;
@property (nonatomic, strong) NSArray<NSArray<NSString *> *> *collectionModel;
@property (nonatomic, strong) NSArray<NSArray<NSString *> *> *selfCreateModel;
@end

@implementation PersonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    
    self.selfCreateModel = [HomeModel defaultSelfCreateModel];
    self.collectionModel = [HomeModel defaultcollectionModel];
    self.model = self.selfCreateModel;
    
    UIImage *image = [UIImage systemImageNamed:@"line.3.horizontal"];
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(pushMenu)];
    self.navigationItem.rightBarButtonItem = menuButton;
    
    [self setupBack];
    [self setupHeader];
    [self setupFavorite];
    [self setupTab];
    [self setupSegView];
}
#pragma mark - setupBack

- (void)setupBack {
    self.scr = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scr.backgroundColor = [UIColor systemGray6Color];
    self.scr.showsVerticalScrollIndicator = NO;
    self.scr.contentSize = CGSizeMake(self.scr.bounds.size.width, 900);
    self.scr.delegate = self;
    self.scr.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:self.scr];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.scr addGestureRecognizer:tap];
    
    self.contentView = [[UIView alloc] init];
    [self.scr addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.scr);
            make.width.equalTo(self.scr);
            make.height.mas_equalTo(900);
    }];
    
    UIImageSymbolConfiguration *micConfig = [UIImageSymbolConfiguration configurationWithPaletteColors:@[
        [UIColor systemGreenColor],
        [UIColor systemGray4Color]
    ]];
    UIImage *mic = [UIImage systemImageNamed:@"microphone.circle" withConfiguration:micConfig];
    UIImageView *micV = [[UIImageView alloc] initWithImage:mic];
    micV.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:micV];
    
    self.search = [[UISearchBar alloc] init];
    self.search.placeholder = @"搜索";
    self.search.searchBarStyle = UISearchBarStyleMinimal;
    [self.contentView addSubview:self.search];
    
    [self.search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(micV.mas_left).offset(-10);
        make.width.mas_equalTo(300);
    }];
    
    [micV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.search);
        make.right.equalTo(self.contentView).offset(-20);
        make.width.height.mas_equalTo(30);
    }];
}
- (void)tapAction {
    [self.view endEditing:YES];
}

#pragma mark - setupHeader
- (void)setupHeader {
    UIView *back = [[UIView alloc] init];
    back.backgroundColor = [UIColor systemBackgroundColor];
    back.layer.cornerRadius = 8;
    back.clipsToBounds = YES;
    [self.contentView addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.search.mas_bottom).offset(20);
            make.left.equalTo(self.contentView).offset(20);
            make.right.equalTo(self.contentView).offset(-20);
            make.height.mas_equalTo(140);
    }];
    
    UIImageView *avatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar"]];
    avatar.contentMode = UIViewContentModeScaleToFill;
    avatar.layer.cornerRadius = 25;
    avatar.clipsToBounds = YES;
    [back addSubview:avatar];
    [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(back).offset(15);
            make.width.height.mas_equalTo(50);
    }];
    UILabel *name = [[UILabel alloc] init];
    name.text = @"黑化旺仔";
    name.font = [UIFont boldSystemFontOfSize:18];
    name.textColor = [UIColor labelColor];
    [back addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(avatar);
            make.left.equalTo(avatar.mas_right).offset(15);
    }];
    
    UIImageView *loginOut = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"rectangle.portrait.and.arrow.right"]];
    loginOut.tintColor = [UIColor secondaryLabelColor];
    loginOut.contentMode = UIViewContentModeScaleAspectFill;
    [back addSubview:loginOut];
    [loginOut mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(name);
        make.left.equalTo(name.mas_right).offset(8);
        make.width.height.mas_equalTo(15);
    }];
    
    UILabel *vip = [[UILabel alloc] init];
    vip.text = @"SVIP5";
    vip.backgroundColor = [UIColor colorWithRed:73 / 255.0 green:56 / 255.0 blue:34 / 255.0 alpha:1.0];
    vip.layer.cornerRadius = 8;
    vip.clipsToBounds = YES;
    vip.textAlignment = UITextAlignmentCenter;
    vip.font = [UIFont systemFontOfSize:11];
    vip.textColor = [UIColor systemYellowColor];
    [back addSubview:vip];
    [vip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(name.mas_bottom).offset(10);
        make.left.equalTo(name).offset(3);
        make.width.mas_equalTo(42);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *follower = [[UILabel alloc] init];
    follower.text = @"30";
    follower.font = [UIFont systemFontOfSize:18];
    follower.textColor = [UIColor labelColor];
    [back addSubview:follower];
    [follower mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(name);
            make.right.equalTo(back).offset(-30);
    }];
    
    UILabel *follow = [[UILabel alloc] init];
    follow.font = [UIFont systemFontOfSize:14];
    follow.text = @"关注";
    follow.textColor = [UIColor labelColor];
    [back addSubview:follow];
    [follow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(vip);
            make.centerX.equalTo(follower);
    }];
    
    UILabel *clothesLabel = [[UILabel alloc] init];
    clothesLabel.text = @"装扮中心";
    clothesLabel.font = [UIFont systemFontOfSize:15];
    clothesLabel.textColor = [UIColor labelColor];
    [back addSubview:clothesLabel];
    [clothesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(back).offset(-20);
        make.right.equalTo(back).offset(-65);
    }];
    
    UIImageView *card = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"creditcard.fill"]];
    card.tintColor = [UIColor systemGreenColor];
    card.contentMode = UIViewContentModeScaleAspectFill;
    [back addSubview:card];
    [card mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(clothesLabel);
            make.left.equalTo(back).offset(60);
            make.width.height.mas_equalTo(23);
    }];
    
    UILabel *centerLabel = [[UILabel alloc] init];
    centerLabel.text = @"会员中心";
    centerLabel.font = [UIFont systemFontOfSize:15];
    centerLabel.textColor = [UIColor labelColor];
    [back addSubview:centerLabel];
    [centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(card.mas_right).offset(5);
        make.centerY.equalTo(clothesLabel);
    }];

    UIImage *paint = [UIImage systemImageNamed:@"paintpalette.fill"];
    paint = [paint imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImageView *paintV = [[UIImageView alloc] initWithImage:paint];
    paintV.contentMode = UIViewContentModeScaleToFill;
    [back addSubview:paintV];
    [paintV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(clothesLabel);
            make.right.equalTo(clothesLabel.mas_left).offset(-5);
            make.width.height.mas_equalTo(23);
    }];
    
    UIImageView *recent = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"clock.fill"]];
    recent.tintColor = [UIColor labelColor];
    recent.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:recent];
    
    UIImageView *download = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"square.and.arrow.down.fill"]];
    download.tintColor = [UIColor labelColor];
    download.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:download];
    
    UIImageView *sound = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"music.microphone"]];
    sound.tintColor = [UIColor labelColor];
    sound.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:sound];
    
    UIImageView *shopping = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"bag.fill"]];
    shopping.tintColor = [UIColor labelColor];
    shopping.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:shopping];
    
    [recent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(back.mas_bottom).offset(40);
            make.left.equalTo(self.contentView).offset(60);
            make.width.height.mas_equalTo(30);
    }];
    [download mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(recent);
            make.left.equalTo(recent.mas_right).offset(53);
            make.width.height.mas_equalTo(30);
    }];
    [shopping mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(recent);
            make.right.equalTo(self.contentView).offset(-60);
            make.width.height.mas_equalTo(30);
    }];
    [sound mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(recent);
            make.right.equalTo(shopping.mas_left).offset(-53);
            make.height.width.mas_equalTo(30);
    }];
    
    UILabel *recentLabel = [[UILabel alloc] init];
    recentLabel.text = @"最近";
    recentLabel.font = [UIFont systemFontOfSize:14];
    recentLabel.textColor = [UIColor labelColor];
    [self.contentView addSubview:recentLabel];
    
    UILabel *downLabel = [[UILabel alloc] init];
    downLabel.text = @"本地";
    downLabel.font = [UIFont systemFontOfSize:14];
    downLabel.textColor = [UIColor labelColor];
    [self.contentView addSubview:downLabel];
    
    UILabel *soundLabel = [[UILabel alloc] init];
    soundLabel.text = @"有声";
    soundLabel.font = [UIFont systemFontOfSize:14];
    soundLabel.textColor = [UIColor labelColor];
    [self.contentView addSubview:soundLabel];
    
    UILabel *shopLabel = [[UILabel alloc] init];
    shopLabel.text = @"已购";
    shopLabel.font = [UIFont systemFontOfSize:14];
    shopLabel.textColor = [UIColor labelColor];
    [self.contentView addSubview:shopLabel];
    
    [recentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(recent);
            make.top.equalTo(recent.mas_bottom).offset(5);
    }];
    [downLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(download);
            make.top.equalTo(download.mas_bottom).offset(5);
    }];
    [soundLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(sound);
            make.top.equalTo(sound.mas_bottom).offset(5);
    }];
    [shopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(shopping);
            make.top.equalTo(shopping.mas_bottom).offset(5);
    }];
    
    UILabel *recentNum = [[UILabel alloc] init];
    recentNum.text = @"500";
    recentNum.font = [UIFont systemFontOfSize:12];
    recentNum.textColor = [UIColor secondaryLabelColor];
    [self.contentView addSubview:recentNum];
    
    UILabel *downNum = [[UILabel alloc] init];
    downNum.text = @"2049";
    downNum.font = [UIFont systemFontOfSize:12];
    downNum.textColor = [UIColor secondaryLabelColor];
    [self.contentView addSubview:downNum];
    
    UILabel *soundNum = [[UILabel alloc] init];
    soundNum.text = @"24";
    soundNum.font = [UIFont systemFontOfSize:12];
    soundNum.textColor = [UIColor secondaryLabelColor];
    [self.contentView addSubview:soundNum];
    
    UILabel *shopNum = [[UILabel alloc] init];
    shopNum.text = @"2";
    shopNum.font = [UIFont systemFontOfSize:12];
    shopNum.textColor = [UIColor secondaryLabelColor];
    [self.contentView addSubview:shopNum];
    
    [recentNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(recentLabel);
            make.top.equalTo(recentLabel.mas_bottom).offset(3);
    }];
    [downNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(downLabel);
            make.top.equalTo(downLabel.mas_bottom).offset(3);
    }];
    [soundNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(soundLabel);
            make.top.equalTo(soundLabel.mas_bottom).offset(3);
    }];
    [shopNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(shopLabel);
            make.top.equalTo(shopLabel.mas_bottom).offset(3);
    }];
}

#pragma mark - setupFavorite
- (void)setupFavorite {
    UILabel *favorite = [[UILabel alloc] init];
    favorite.text = @"我收藏的歌曲";
    favorite.textColor = [UIColor labelColor];
    [self.contentView addSubview:favorite];
    [favorite mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(25);
            make.top.equalTo(self.search).offset(380);
    }];
    
    UILabel *num = [[UILabel alloc] init];
    num.text = @"124";
    num.font = [UIFont systemFontOfSize:11];
    num.textColor = [UIColor secondaryLabelColor];
    [self.contentView addSubview:num];
    [num mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(favorite);
            make.left.equalTo(favorite.mas_right).offset(8);
    }];
    
    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"chevron.right"]];
    arrow.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:arrow];
    arrow.tintColor = [UIColor labelColor];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(favorite);
            make.right.equalTo(self.contentView).offset(-25);
    }];
    
    UIImageView *avatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Diamonds(Album Version)"]];
    avatar.contentMode = UIViewContentModeScaleAspectFill;
    avatar.layer.cornerRadius = 5;
    avatar.clipsToBounds = YES;
    [self.contentView addSubview:avatar];
    [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(favorite.mas_bottom).offset(17);
            make.left.equalTo(favorite);
            make.width.height.mas_equalTo(60);
    }];
    
    UILabel *musicName = [[UILabel alloc] init];
    musicName.text = @"Diamonds(Album Version)";
    musicName.font = [UIFont systemFontOfSize:16];
    musicName.textColor = [UIColor labelColor];
    [self.contentView addSubview:musicName];
    [musicName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(avatar).offset(8);
            make.left.equalTo(avatar.mas_right).offset(8);
    }];
    
    UILabel *authName = [[UILabel alloc] init];
    authName.text = @"Rihanna";
    authName.font = [UIFont systemFontOfSize:13];
    authName.textColor = [UIColor secondaryLabelColor];
    [self.contentView addSubview:authName];
    [authName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(musicName.mas_bottom).offset(7);
            make.left.equalTo(musicName);
    }];
    
    UIImageSymbolConfiguration *config = [UIImageSymbolConfiguration configurationWithPaletteColors:@[
        [UIColor blackColor],
        [UIColor systemGreenColor]
    ]];
    UIImage *play = [[UIImage systemImageNamed:@"play.rectangle.fill"] imageWithConfiguration:config];
    UIImageView *playView = [[UIImageView alloc] initWithImage:play];
    playView.layer.cornerRadius = 15;
    playView.backgroundColor = [UIColor systemGreenColor];
    playView.clipsToBounds = YES;
    [self.contentView addSubview:playView];
    [playView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(avatar);
            make.right.equalTo(self.contentView).offset(-20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(33);
    }];
}

#pragma mark - setupTab
- (void)setupTab {
    self.selfCreatedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selfCreatedBtn.frame = CGRectMake(20, 515, 70, 30);
    [self.selfCreatedBtn setTitle:@"自建歌单" forState:UIControlStateNormal];
    self.selfCreatedBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.selfCreatedBtn setTitleColor:[UIColor labelColor] forState:UIControlStateNormal];
    [self.selfCreatedBtn addTarget:self action:@selector(tabTapAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.collectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.collectedBtn.frame = CGRectMake(120, 515, 70, 30);
    [self.collectedBtn setTitle:@"收藏歌单" forState:UIControlStateNormal];
    self.collectedBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.collectedBtn setTitleColor:[UIColor secondaryLabelColor] forState:UIControlStateNormal];
    [self.collectedBtn addTarget:self action:@selector(tabTapAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:self.selfCreatedBtn];
    [self.contentView addSubview:self.collectedBtn];
    self.indicator = [[UIView alloc] initWithFrame:CGRectMake(20, 545, 70, 2)];
    self.indicator.backgroundColor = [UIColor systemGreenColor];
    [self.contentView addSubview:self.indicator];
    
    UILabel *selfNum = [[UILabel alloc] init];
    selfNum.text = @"3";
    selfNum.textColor = [UIColor secondaryLabelColor];
    selfNum.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:selfNum];
    [selfNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.selfCreatedBtn);
            make.left.equalTo(self.selfCreatedBtn.mas_right).offset(3);
    }];
    
    UILabel *likeNum = [[UILabel alloc] init];
    likeNum.text = @"3";
    likeNum.textColor = [UIColor secondaryLabelColor];
    likeNum.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:likeNum];
    [likeNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.collectedBtn);
            make.left.equalTo(self.collectedBtn.mas_right).offset(3);
    }];
    
    UIImageView *move = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"rectangle.portrait.and.arrow.right"]];
    move.tintColor = [UIColor labelColor];
    [self.contentView addSubview:move];
    [move mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.selfCreatedBtn);
            make.right.equalTo(self.contentView).offset(-20);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(18);
    }];
    
    UIImageView *add = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"plus"]];
    add.tintColor = [UIColor labelColor];
    [self.contentView addSubview:add];
    [add mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.selfCreatedBtn);
            make.right.equalTo(move.mas_left).offset(-10);
        make.width.height.mas_equalTo(20);
        make.height.mas_equalTo(25);
    }];
}
- (void)tabTapAction:(UIButton *) but {
    BOOL isSelf = (but == self.selfCreatedBtn);
    [self.selfCreatedBtn setTitleColor:isSelf ? UIColor.labelColor : UIColor.secondaryLabelColor forState:UIControlStateNormal];
    [self.collectedBtn setTitleColor:isSelf ? UIColor.secondaryLabelColor : UIColor.labelColor forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
            self.indicator.frame = CGRectMake(but.frame.origin.x, but.frame.origin.y + but.bounds.size.height, but.bounds.size.width, 2);
    }];
    self.model = isSelf ? self.selfCreateModel : self.collectionModel;
    [self.tableView reloadData];
}

#pragma mark - pushMenu
- (void)pushMenu {
    MenuVC *menu = [[MenuVC alloc] init];
    [self.navigationController pushViewController:menu animated:YES];
}

#pragma mark - setupSegView
- (void)setupSegView {
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerClass:[PersonPlayListsCell class] forCellReuseIdentifier:@"cell"];
    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(555);
            make.left.equalTo(self.contentView).offset(20);
            make.right.equalTo(self.contentView).offset(-20);
            make.bottom.equalTo(self.contentView);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonPlayListsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell updateWithModel:self.model[indexPath.row]];
    return cell;
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
