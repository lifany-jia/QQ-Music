//
//  MusicPlay.m
//  Music
//
//  Created by lifany on 2026/6/17.
//

#import "MusicPlay.h"

NSString *const kMusicPlayerDidChangeNotification = @"kMusicPlayerDidChangeNotification";
NSString *const kMusicPlayerSongKey = @"kMusicPlayerSongKey";
NSString *const kMusicPlayerIsPlayingKey = @"kMusicPlayerIsPlayingKey";

@interface MusicPlay ()
// 对外只读，对内都可
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, assign) BOOL isPlayed;
@property (nonatomic, copy) NSArray<NSString *> *currentSong;
@property (nonatomic, copy) NSArray<NSArray<NSString *> *> *songList;
@property (nonatomic, assign) NSInteger currentIndex;
@end
@implementation MusicPlay
+ (instancetype)sharedManager {
    static MusicPlay *musicPlayer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        musicPlayer = [[MusicPlay alloc] init];
    });
    return musicPlayer;
}
- (void)setPlaylist:(NSArray<NSArray<NSString *> *> *)songList startIndex:(NSInteger)index {
    if (songList.count == 0) return;
    self.songList = songList;
    self.currentIndex = index;
    [self playSongAtCurrentIndex];
}
- (void)playSongAtCurrentIndex {
    if (self.currentIndex < 0 || self.currentIndex >= self.songList.count) {
        return;
    }
    self.currentSong = self.songList[self.currentIndex];
    if (self.player.currentItem) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
    }
    if (self.currentSong.count <= 3) {
        NSLog(@"MusicPlay error: invalid song model: %@", self.currentSong);
        self.player = nil;
        self.isPlayed = NO;
        [self broadcastChange];
        return;
    }
    NSString *fileName = self.currentSong[3];
    NSURL *url = nil;
    if (fileName.pathExtension.length > 0) {
        url = [[NSBundle mainBundle] URLForResource:fileName.stringByDeletingPathExtension withExtension:fileName.pathExtension];
    } else {
        url = [[NSBundle mainBundle] URLForResource:fileName withExtension:@"m4a"];
    }
    if (!url) {
        NSLog(@"MusicPlay error: audio resource not found: %@", fileName);
        self.player = nil;
        self.isPlayed = NO;
        [self broadcastChange];
        return;
    }
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    self.player = [AVPlayer playerWithPlayerItem:item];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFinishAction:) name:AVPlayerItemDidPlayToEndTimeNotification object:item];
    [self.player play];
    self.isPlayed = YES;
    [self broadcastChange];
}
- (void)play {
    if (!self.player) return;
    [self.player play];
    self.isPlayed = YES;
    [self broadcastChange];
}
- (void)pause {
    if (!self.player) return;
    [self.player pause];
    self.isPlayed = NO;
    [self broadcastChange];
}
- (void)togglePlayPause {
    if (self.isPlayed) {
        [self pause];
    } else {
        [self play];
    }
}
- (void)playPreVious {
    if (self.songList.count == 0) return;
    self.currentIndex--;
    if (self.currentIndex < 0) {
        self.currentIndex = self.songList.count - 1;
    }
    [self playSongAtCurrentIndex];
}
- (void)playNext {
    if (self.songList.count == 0) return;
    self.currentIndex++;
    if (self.currentIndex >= self.songList.count) {
        self.currentIndex = 0;
    }
    [self playSongAtCurrentIndex];
}
- (void)seekToTime:(CGFloat)seconds {
    if (!self.player) return;
    // 把 seconds 这个“秒数”，转换成一个以“纳秒”为精度单位的 CMTime
    // NSEC_PER_SEC = 1000000000，也就是 1 秒有 10 亿纳秒
    CMTime time = CMTimeMakeWithSeconds(seconds, NSEC_PER_SEC);
    [self.player seekToTime:time];
}
- (CGFloat)duration {
    if (!self.player.currentItem) return 0;
    CMTime duration = self.player.currentItem.duration;
    CGFloat seconds = CMTimeGetSeconds(duration);
    // NaN 全称是：Not a Number，isnan表示是不是一个数字
    return isnan(seconds) ? 0 : seconds;
}
- (CGFloat)currentTime {
    if (!self.player) return 0;
    CGFloat seconds = CMTimeGetSeconds(self.player.currentItem.currentTime);
    return isnan(seconds) ? 0 : seconds;
}
- (void)playFinishAction:(NSNotification *) noti {
    [self playNext];
}
// 广播通知给所有监听页面
- (void)broadcastChange {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (self.currentSong) {
        dictionary[kMusicPlayerSongKey] = self.currentSong;
    }
    dictionary[kMusicPlayerIsPlayingKey] = @(self.isPlayed);
    [[NSNotificationCenter defaultCenter] postNotificationName:kMusicPlayerDidChangeNotification object:nil userInfo:dictionary];
}
@end
