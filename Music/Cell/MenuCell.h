//
//  MenuCell.h
//  Music
//
//  Created by lifany on 2026/6/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuCell : UITableViewCell
@property (nonatomic, strong) void(^isChanged)(BOOL isOn);
- (void)updateWithLabel:(NSString *) label;
- (void)updateWithLabel:(NSString *)label isOn:(BOOL) isOn;
@end

NS_ASSUME_NONNULL_END
