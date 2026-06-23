//
//  MyTabBarVC.m
//  Music
//
//  Created by lifany on 2026/6/17.
//

#import "MyTabBarVC.h"
#import "HomeVC.h"
#import "PersonVC.h"
#import "MusicVC.h"
#import <Masonry/Masonry.h>
@interface MyTabBarVC ()
@property (nonatomic, strong) UIView *miniPlayer;
@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UIButton *pausePlayer;
@property (nonatomic, strong) UITabAccessory *accessory;

@property (nonatomic, copy) NSArray<NSString *> *model;
@property (nonatomic, assign) BOOL isPlayed;
@end

@implementation MyTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabBar];
    [self setMiniPlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleMusicChange:) name:kMusicPlayerDidChangeNotification object:nil];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)handleMusicChange:(NSNotification *) noti {
    self.model = noti.userInfo[kMusicPlayerSongKey];
    self.isPlayed = [noti.userInfo[kMusicPlayerIsPlayingKey] boolValue];
    self.name.text = self.model[0];
    UIImage *image = [UIImage imageNamed:self.model[0]];
    self.avatar.image = image;
    self.pausePlayer.selected = self.isPlayed;
}
- (void)setTabBar {
    HomeVC *home = [[HomeVC alloc] init];
    home.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage systemImageNamed:@"house"] selectedImage:[UIImage systemImageNamed:@"house.fill"]];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:home];
    
    PersonVC *person = [[PersonVC alloc] init];
    person.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage systemImageNamed:@"person"] selectedImage:[UIImage systemImageNamed:@"person.fill"]];
    UINavigationController *personNav = [[UINavigationController alloc] initWithRootViewController:person];
    
    self.viewControllers = @[homeNav, personNav];
    self.tabBarMinimizeBehavior = UITabBarMinimizeBehaviorOnScrollDown;
    self.tabBar.tintColor = [UIColor systemGreenColor];
    self.tabBar.unselectedItemTintColor = [UIColor systemGreenColor];
}
- (void)setMiniPlayer {
    self.miniPlayer = [[UIView alloc] init];
    
    self.avatar = [[UIImageView alloc] init];
    self.avatar.layer.cornerRadius = 15;
    self.avatar.clipsToBounds = YES;
    self.avatar.backgroundColor = [UIColor systemGray4Color];
    self.avatar.contentMode = UIViewContentModeScaleAspectFill;
    [self.miniPlayer addSubview:self.avatar];
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.miniPlayer);
        make.width.height.mas_equalTo(30);
        make.top.left.equalTo(self.miniPlayer).offset(10);     // 顶部留白
        make.bottom.equalTo(self.miniPlayer).offset(-10);
    }];
    
    self.name = [[UILabel alloc] init];
    self.name.textColor = [UIColor labelColor];
    self.name.lineBreakMode = NSLineBreakByTruncatingTail;
    self.name.font = [UIFont systemFontOfSize:14];
    [self.miniPlayer addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.avatar);
        make.left.equalTo(self.avatar.mas_right).offset(10);
        make.width.mas_equalTo(200);
    }];
    
    UIImageView *list = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"list.triangle"]];
    list.tintColor = [UIColor systemGreenColor];
    [self.miniPlayer addSubview:list];
    [list mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.avatar);
            make.right.equalTo(self.miniPlayer).offset(-20);
            make.width.height.mas_equalTo(25);
    }];
    
    self.pausePlayer = [UIButton buttonWithType:UIButtonTypeCustom];
    self.pausePlayer.tintColor = [UIColor systemGreenColor];
    self.pausePlayer.imageView.contentMode = UIViewContentModeScaleAspectFill;
    UIImageSymbolConfiguration *config = [UIImageSymbolConfiguration configurationWithPointSize:22];
    UIImage *play = [[UIImage systemImageNamed:@"play.circle"] imageWithConfiguration:config];
    UIImage *pause = [[UIImage systemImageNamed:@"pause.circle"] imageWithConfiguration:config];
    [self.pausePlayer setImage:play forState:UIControlStateNormal];
    [self.pausePlayer setImage:pause forState:UIControlStateSelected];
    [self.pausePlayer addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.miniPlayer addSubview:self.pausePlayer];
    [self.pausePlayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.avatar);
        make.right.equalTo(list.mas_left).offset(-15);
        make.width.height.mas_equalTo(25);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(miniAction)];
    [self.miniPlayer addGestureRecognizer:tap];
    
    self.accessory = [[UITabAccessory alloc] initWithContentView:self.miniPlayer];
}
- (void)updateWithModel:(NSArray<NSString *> *)model isPlayed:(BOOL)isPlayed {
    self.model = model;
    self.name.text = self.model[0];
    UIImage *image = [UIImage imageNamed:self.model[0]];
    self.avatar.image = image;
    self.pausePlayer.selected = isPlayed;
    self.isPlayed = isPlayed;
    [self setMiniPlayerVisible:YES];
}
- (void)setMiniPlayerVisible:(BOOL)visible {
    self.bottomAccessory = visible ? self.accessory : nil;
}
- (void)playAction:(UIButton *) but {
    [[MusicPlay sharedManager] togglePlayPause];
}
- (void)miniAction {
    MusicVC *music = [[MusicVC alloc] init];
    [music updateWithModel:self.model isPlayed:self.isPlayed];
    [self presentViewController:music animated:YES completion:nil];
}
+ (instancetype)sharedTabBarVC {
    for (UIScene *scene in [UIApplication sharedApplication].connectedScenes) {
        if ([scene isKindOfClass:[UIWindowScene class]]) {
            UIWindowScene *windowScene = (UIWindowScene *)scene;
            UIWindow *window = windowScene.keyWindow;
            if ([window.rootViewController isKindOfClass:[MyTabBarVC class]]) {
                return (MyTabBarVC *)window.rootViewController;
            }
        }
    }
    return nil;
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
