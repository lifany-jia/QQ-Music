//
//  HomeModel.m
//  Music
//
//  Created by lifany on 2026/6/3.
//

#import "HomeModel.h"

@implementation HomeModel
+ (NSArray<NSArray<NSString *> *> *)defaultFirstSectionModel {
    NSArray *model = [NSArray array];
    model = @[
        @[
            @"猜你喜欢", @"像晴天像雨天 - 汪苏泷"
        ],
        @[
            @"每日30首", @"Say So - Steve Void"
        ],
        @[
            @"雷达模式", @"Closer - The Chainsmokers"
        ],
        @[
            @"百万收藏", @"If You Feel My Love - Blaxy Girls"
        ],
        @[
            @"新歌推荐", @"NO LUCK(explicit) - Tiffany Day"
        ]
    ];
    return model;
}
@end
