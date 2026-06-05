//
//  HomeModel.h
//  Music
//
//  Created by lifany on 2026/6/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeModel : NSObject
+ (NSArray<NSArray<NSString *> *> *)defaultFirstSectionModel;
+ (NSArray<NSArray<NSString *> *> *)defaultSecondSectionModel;
+ (NSArray<NSArray<NSString *> *> *)defaultThirdSectionModel;
+ (NSArray<NSArray<NSString *> *> *)defaultFourthSectionModel;
@end

NS_ASSUME_NONNULL_END
