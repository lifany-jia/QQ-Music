//
//  MusicVC.h
//  Music
//
//  Created by lifany on 2026/6/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MusicVC : UIViewController
- (void)updateWithName:(NSString *) authorName musicName:(NSString *)musicName avatar:(NSString *) avatar isPlayed:(BOOL) isPlayed;
@end

NS_ASSUME_NONNULL_END
