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
        @[@"猜你喜欢", @"像晴天像雨天 - 汪苏泷"],
        @[@"每日30首", @"Say So - Steve Void"],
        @[@"雷达模式", @"Closer - The Chainsmokers"],
        @[@"百万收藏", @"If You Feel My Love - Blaxy Girls"],
        @[@"新歌推荐", @"NO LUCK(explicit) - Tiffany Day"]
    ];
    return model;
}
+ (NSArray<NSArray<NSString *> *> *)defaultSecondSectionModel {
    NSArray *model = [NSArray array];
    model = @[
        @[@"Diamonds(Album Version)", @"Rihanna", @"英国UK榜历史上榜", @"angel.m4a"],
        @[@"Be Kind", @"Marshmello/Halsey", @"“棉花糖和猴西简直了”", @"an.m4a"],
        @[@"South of the Border(feat.Camila Cabello & Cardi B", @"Ed Sheeran/Camila Cabello/Cardi B", @"“来一曲能量补给”", @"像晴天像雨天.m4a"],
        @[@"Paris In The Rain", @"Lauv", @"Melon榜历史上榜", @"angel.m4a"],
        @[@"不为谁而作的歌", @"林俊杰", @"”高深之处震撼人心“", @"像晴天像雨天.m4a"],
        @[@"就忘了吧", @"1K", @"腾讯音乐榜白金单曲4X", @"an.m4a"],
        @[@"走走", @"李荣浩", @"流行指数榜No.12", @"angel.m4a"],
        @[@"Lost", @"满舒克/Jony J", @"”前奏心里咯噔一下“", @"angel.m4a"],
        @[@"this is what winter feels like", @"JVKE", @"“前奏被积雪融化”", @"an.m4a"]
    ];
    return model;
}
+ (NSArray<NSArray<NSString *> *> *)defaultThirdSectionModel {
    NSArray *model = [NSArray array];
    model = @[
        @[@"从《Innocence》中发现热门旋律"],
        @[@"沿着《盐（Witch Condiment）》发现更好的音乐"],
        @[@"跟随「Avril Lavigne」发掘更多HitSong"],
        @[@"跟随「Nicki Minaj」动起来吧！"],
        @[@"跟随「林俊杰」发掘更多超燃游戏BGM"],
        @[@"随《Wake》开启旅途BGM"],
        @[@"携手「Justin Bieber」一起打开节奏布鲁斯音乐"]
    ];
    return model;
}
+ (NSArray<NSArray<NSString *> *> *)defaultFourthSectionModel {
    NSArray *model = [NSArray array];
    model = @[
        @[@"麻醉师", @"胡睿", @"“前奏简直封神”"],
        @[@"Ride It（TikTok Remix）", @"TommyMuzzic/ZeddMusique", @"昨日热播"],
        @[@"可惜没如果", @"林俊杰", @"1k人在听"],
        @[@"One Time", @"Justin Bieber", @"“比伯陪我走过青春”"],
        @[@"孤身", @"徐秉龙", @"”前奏贝斯好喜欢“"],
        @[@"You & Me", @"H-Slang & Choco", @"“前奏女声绝了”"],
        @[@"像过期的春天", @"吴和阳", @""],
        @[@"boyfriend(Explicit)", @"Ariana Grande/Social House", @"欧美历史上榜"],
        @[@"我还记得那天", @"ycccc", @"“心脏漏了一拍的好听”"]
    ];
    return model;
}
+ (NSArray<NSArray<NSString *> *> *)defaultSelfCreateModel {
    NSArray *model = [NSArray array];
    model = @[
        @[@"JJ", @"29首"],
        @[@"En", @"311首"],
        @[@"Ne", @"190首"],
        @[@"新建导入外部歌单", @"支持图片、文字、QQ号等多种导入方式"]
    ];
    return model;
}
+ (NSArray<NSArray<NSString *> *> *)defaultcollectionModel {
    NSArray *model = [NSArray array];
    model = @[
        @[@"抖音热门｜让生活变得有趣", @"29首"],
        @[@"欧美流行向｜爱于前奏死于高潮", @"1344首"],
        @[@"QQ飞车｜快闪开！我要上车神", @"255首"],
    ];
    return model;
}
+ (NSArray<NSArray<NSString *> *> *)defaultMenuModel {
    NSArray *model = [NSArray array];
    model = @[
        @[@"设置", @"个人资料"],
        @[@"定时关闭", @"碰一碰传歌", @"导入外部歌曲", @"添加小组件", @"清理占用内存"],
        @[@"深色模式", @"未成年人模式"],
        @[@"QQ音乐VIP兑换中心"],
        @[@"帮助与反馈", @"安全中心", @"第三方信息清理共享清单", @"已收集个人信息清单", @"隐私政策摘要", @"注销账号"],
        @[@"退出登录"]
    ];
    return model;
}
+ (NSMutableArray<NSMutableArray<NSNumber *> *> *)defaultIsOnsModel {
    NSArray<NSArray<NSString *> *> *model = [HomeModel defaultMenuModel];
    static NSMutableArray *isOns = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isOns = [NSMutableArray array];
        for (int i = 0; i < model.count; i++) {
            NSMutableArray *temp = [NSMutableArray array];
            for (int j = 0; j < model[i].count; j++) {
                [temp addObject:@(NO)];
            }
            [isOns addObject:temp];
        }
    });
    return isOns;
}
+ (NSArray<NSString *> *)defaultDrawerModel {
    NSArray *model = [NSArray array];
    model = @[
        @"设置", @"个人资料", @"定时关闭", @"碰一碰传歌", @"导入外部歌曲", @"QQ音乐VIP兑换中心", @"帮助与反馈",@"安全中心", @"第三方信息清理共享清单", @"已收集个人信息清单", @"隐私政策摘要"
    ];
    return model;
}
@end
