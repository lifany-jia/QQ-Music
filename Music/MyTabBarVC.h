//
//  MyTabBarVC.h
//  Music
//
//  Created by lifany on 2026/6/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyTabBarVC : UITabBarController
+ (instancetype)sharedTabBarVC;
- (void)updateWithAvatar:(NSString *)avatar authorName:(NSString *)authorName musicName:(NSString *)musicName visible:(BOOL)visible;
- (void)setMiniPlayerVisible:(BOOL) visible;
@end

NS_ASSUME_NONNULL_END
