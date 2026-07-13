//
//  MusicPlay.h
//  Music
//
//  Created by lifany on 2026/6/17.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

extern NSString * const kMusicPlayerDidChangeNotification;
extern NSString * const kMusicPlayerSongKey;      
extern NSString * const kMusicPlayerIsPlayingKey;

@interface MusicPlay : NSObject
// 对外只读，对内都可
@property (nonatomic, strong, readonly) AVPlayer *player;
@property (nonatomic, assign, readonly) BOOL isPlayed;
@property (nonatomic, copy, readonly, nullable) NSArray<NSString *> *currentSong;
@property (nonatomic, copy, readonly) NSArray<NSArray<NSString *> *> *songList;
@property (nonatomic, assign, readonly) NSInteger currentIndex;

+ (instancetype)sharedManager;
- (void)setPlaylist:(NSArray<NSArray<NSString *> *> *) songList startIndex:(NSInteger) index;
- (void)play;
- (void)pause;
- (void)togglePlayPause;
- (void)playNext;
- (void)playPreVious;
- (void)seekToTime:(CGFloat)seconds;
- (CGFloat)duration;
- (CGFloat)currentTime;
@end

NS_ASSUME_NONNULL_END
