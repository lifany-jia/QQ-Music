//
//  PersonPlayListsCell.h
//  Music
//
//  Created by lifany on 2026/6/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonPlayListsCell : UITableViewCell
- (void)updateWithModel:(NSArray<NSString *> *) model;
@end

NS_ASSUME_NONNULL_END
