//
//  MyTabBarVC.h
//  Music
//
//  Created by lifany on 2026/6/17.
//

#import <UIKit/UIKit.h>
#import "MusicPlay.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyTabBarVC : UITabBarController
+ (instancetype)sharedTabBarVC;
- (void)updateWithModel:(NSArray<NSString *> *) model isPlayed:(BOOL)isPlayed;
- (void)setMiniPlayerVisible:(BOOL) visible;
@end

NS_ASSUME_NONNULL_END
