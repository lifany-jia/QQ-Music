//
//  MusicVC.m
//  Music
//
//  Created by lifany on 2026/6/20.
//

#import "MusicVC.h"
#import "MusicPlay.h"
#import <Masonry/Masonry.h>
@interface MusicVC ()
@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *musicName;
@property (nonatomic, strong) UILabel *authorName;
@property (nonatomic, strong) UIButton *pause;
@property (nonatomic, strong) UIButton *prev;
@property (nonatomic, strong) UIButton *next;
@property (nonatomic, strong) UIButton *back;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, copy) NSArray<NSString *> *model;
@property (nonatomic, assign) BOOL isPlayed;
@property (nonatomic, assign) BOOL isDragging;
@end

@implementation MusicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemGray5Color];
    [self setupUI];
    [self refreshMusicInfo];
    [self startProgressTimer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleMusicChange:) name:kMusicPlayerDidChangeNotification object:nil];
}
- (void)startProgressTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
}
- (void)updateTimer {
    if (self.isDragging) return;
    MusicPlay *music = [MusicPlay sharedManager];
    CGFloat current = music.currentTime;
    CGFloat total = music.duration;
    if (total > 0 && !isnan(total)) {
        self.slider.value = (current / total) * 100.0;
    }
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.timer invalidate];
    self.timer = nil;
}
- (void)handleMusicChange:(NSNotification *)noti {
    self.model = noti.userInfo[kMusicPlayerSongKey];
    self.isPlayed = [noti.userInfo[kMusicPlayerIsPlayingKey] boolValue];
    [self updateWithModel:self.model isPlayed:self.isPlayed];
}
- (void)setupUI {
    self.back = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.back setImage:[UIImage systemImageNamed:@"chevron.down.2"] forState:UIControlStateNormal];
    [self.back addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.back.tintColor = [UIColor labelColor];
    [self.view addSubview:self.back];
    [self.back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.view).offset(25);
            make.width.height.mas_equalTo(30);
    }];
    
    self.avatar = [[UIImageView alloc] init];
    self.avatar.layer.cornerRadius = 125;
    self.avatar.clipsToBounds = YES;
    self.avatar.backgroundColor = [UIColor systemGray4Color];
    self.avatar.layer.borderWidth = 2;
    self.avatar.layer.borderColor = [UIColor tertiaryLabelColor].CGColor;
    [self.view addSubview:self.avatar];
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view).offset(50);
            make.width.height.mas_equalTo(250);
    }];
    
    self.musicName = [[UILabel alloc] init];
    self.musicName.textColor = [UIColor labelColor];
    self.musicName.font = [UIFont boldSystemFontOfSize:24];
    self.musicName.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.view addSubview:self.musicName];
    [self.musicName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avatar.mas_bottom).offset(50);
            make.left.equalTo(self.view).offset(30);
        make.width.mas_equalTo(270);
    }];
    
    self.authorName = [[UILabel alloc] init];
    self.authorName.textColor = [UIColor secondaryLabelColor];
    self.authorName.lineBreakMode = NSLineBreakByTruncatingTail;
    self.authorName.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:self.authorName];
    [self.authorName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.musicName.mas_bottom).offset(10);
            make.left.equalTo(self.view).offset(30);
        make.width.mas_equalTo(200);
    }];
    
    self.pause = [UIButton buttonWithType:UIButtonTypeCustom];
    self.pause.tintColor = [UIColor labelColor];
    self.pause.imageView.contentMode = UIViewContentModeScaleAspectFill;
    UIImageSymbolConfiguration *config = [UIImageSymbolConfiguration configurationWithPointSize:70];
    UIImage *play = [[UIImage systemImageNamed:@"play.circle"] imageWithConfiguration:config];
    UIImage *pause = [[UIImage systemImageNamed:@"pause.circle"] imageWithConfiguration:config];
    [self.pause setImage:play forState:UIControlStateNormal];
    [self.pause setImage:pause forState:UIControlStateSelected];
    [self.pause addTarget:self action:@selector(pauseAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.pause];
    [self.pause mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-60);
        make.width.height.mas_equalTo(60);
    }];
    
    self.slider = [[UISlider alloc] init];
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 100;
    self.slider.value = 6;
    self.slider.minimumTrackTintColor = [UIColor labelColor];
    self.slider.maximumTrackTintColor = [UIColor tertiaryLabelColor];
    self.slider.thumbTintColor = [UIColor labelColor];
    [self.view addSubview:self.slider];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.pause.mas_top).offset(-30);
            make.left.equalTo(self.view).offset(10);
            make.right.equalTo(self.view).offset(-10);
    }];
    [self.slider addTarget:self action:@selector(sliderStart) forControlEvents:UIControlEventTouchDown];
    [self.slider addTarget:self action:@selector(sliderStop) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageSymbolConfiguration *configIma = [UIImageSymbolConfiguration configurationWithPointSize:22];
    UIImage *bell = [[UIImage systemImageNamed:@"bell"] imageWithConfiguration:configIma];
    UIImageView *bellV = [[UIImageView alloc] initWithImage:bell];
    bellV.contentMode = UIViewContentModeScaleAspectFit;
    bellV.tintColor = [UIColor secondaryLabelColor];
    [self.view addSubview:bellV];
    [bellV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.slider.mas_top).offset(-40);
        make.left.equalTo(self.musicName);
    }];
    
    UIImage *wave = [[UIImage systemImageNamed:@"waveform.badge.microphone"] imageWithConfiguration:configIma];
    UIImageView *waveV = [[UIImageView alloc] initWithImage:wave];
    waveV.contentMode = UIViewContentModeScaleAspectFit;
    waveV.tintColor = [UIColor secondaryLabelColor];
    [self.view addSubview:waveV];
    [waveV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bellV);
        make.left.equalTo(bellV.mas_right).offset(50);
    }];
    
    UIImage *down = [[UIImage systemImageNamed:@"square.and.arrow.down.fill"] imageWithConfiguration:configIma];
    UIImageView *downV = [[UIImageView alloc] initWithImage:down];
    downV.contentMode = UIViewContentModeScaleAspectFit;
    downV.tintColor = [UIColor secondaryLabelColor];
    [self.view addSubview:downV];
    [downV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bellV);
        make.centerX.equalTo(self.view);
    }];
    
    UIImage *message = [[UIImage systemImageNamed:@"ellipsis.message"] imageWithConfiguration:configIma];
    UIImageView *messageV = [[UIImageView alloc] initWithImage:message];
    messageV.contentMode = UIViewContentModeScaleAspectFit;
    messageV.tintColor = [UIColor secondaryLabelColor];
    [self.view addSubview:messageV];
    [messageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bellV);
        make.left.equalTo(downV.mas_right).offset(50);
    }];
    
    UIImage *ellipsis = [[UIImage systemImageNamed:@"ellipsis"] imageWithConfiguration:configIma];
    UIImageView *ellipsisV = [[UIImageView alloc] initWithImage:ellipsis];
    ellipsisV.contentMode = UIViewContentModeScaleAspectFit;
    ellipsisV.tintColor = [UIColor secondaryLabelColor];
    [self.view addSubview:ellipsisV];
    [ellipsisV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bellV);
        make.right.equalTo(self.view).offset(-30);
    }];
    
    UIImageSymbolConfiguration *configPlay = [UIImageSymbolConfiguration configurationWithPointSize:30];
    UIImage *prevIma = [[UIImage systemImageNamed:@"backward.end.fill"] imageWithConfiguration:configPlay];
    self.prev = [UIButton buttonWithType:UIButtonTypeCustom];
    self.prev.tintColor = [UIColor labelColor];
    [self.prev setImage:prevIma forState:UIControlStateNormal];
    [self.view addSubview:self.prev];
    [self.prev mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.pause.mas_left).offset(-30);
            make.centerY.equalTo(self.pause);
            make.width.height.mas_equalTo(30);
    }];
    UITapGestureRecognizer *prevTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(prevSong)];
    [self.prev addGestureRecognizer:prevTap];
    
    UIImage *nextIma = [[UIImage systemImageNamed:@"forward.end.fill"] imageWithConfiguration:configPlay];
    self.next = [UIButton buttonWithType:UIButtonTypeCustom];
    self.next.tintColor = [UIColor labelColor];
    [self.next setImage:nextIma forState:UIControlStateNormal];
    [self.view addSubview:self.next];
    [self.next mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.pause.mas_right).offset(30);
            make.centerY.equalTo(self.pause);
            make.width.height.mas_equalTo(30);
    }];
    UITapGestureRecognizer *nextTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nextSong)];
    [self.next addGestureRecognizer:nextTap];
}
- (void)prevSong {
    [[MusicPlay sharedManager] playPreVious];
}
- (void)nextSong {
    [[MusicPlay sharedManager] playNext];
}
- (void)pauseAction:(UIButton *) but {
    but.selected = !but.selected;
    if (but.selected) {
        [[MusicPlay sharedManager] play];
    } else {
        [[MusicPlay sharedManager] pause];
    }
}
- (void)sliderStart {
    NSLog(@"start");
    self.isDragging = YES;
}

- (void)sliderStop {
    NSLog(@"stop");
    CGFloat total = [MusicPlay sharedManager].duration;
    CGFloat target = (self.slider.value / 100.0) * total;
    [[MusicPlay sharedManager] seekToTime:target];
    self.isDragging = NO;
}
- (void)updateWithModel:(NSArray<NSString *> *)model isPlayed:(BOOL)isPlayed{
    self.model = model;
    self.isPlayed = isPlayed;
    [self refreshMusicInfo];
}

- (void)refreshMusicInfo {
    self.avatar.image = [UIImage imageNamed:self.model[0]];
    self.authorName.text = self.model[1];
    self.musicName.text = self.model[0];
    self.pause.selected = self.isPlayed;
}
- (void)backAction {
    [self dismissViewControllerAnimated:YES completion:nil];
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
