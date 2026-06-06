//
//  PersonVC.m
//  Music
//
//  Created by lifany on 2026/6/2.
//

#import "PersonVC.h"
#import <Masonry/Masonry.h>
@interface PersonVC () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scr;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UISearchBar *search;
@end

@implementation PersonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    
    self.scr = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scr.backgroundColor = [UIColor systemGray6Color];
    self.scr.showsVerticalScrollIndicator = NO;
    self.scr.contentSize = CGSizeMake(self.scr.bounds.size.width, 900);
    self.scr.delegate = self;
    [self.view addSubview:self.scr];
    
    self.contentView = [[UIView alloc] init];
    [self.scr addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.scr);
            make.width.equalTo(self.scr);
            make.height.mas_equalTo(900);
    }];
    
    UIImageSymbolConfiguration *micConfig = [UIImageSymbolConfiguration configurationWithPaletteColors:@[
        [UIColor systemGreenColor],
        [UIColor systemGray4Color]
    ]];
    UIImage *mic = [UIImage systemImageNamed:@"microphone.circle" withConfiguration:micConfig];
    UIImageView *micV = [[UIImageView alloc] initWithImage:mic];
    micV.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:micV];
    
    self.search = [[UISearchBar alloc] init];
    self.search.placeholder = @"搜索";
    self.search.searchBarStyle = UISearchBarStyleMinimal;
    [self.contentView addSubview:self.search];
    
    [self.search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(micV.mas_left).offset(-10);
        make.width.mas_equalTo(300);
    }];
    
    [micV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.search);
        make.right.equalTo(self.contentView).offset(-20);
        make.width.height.mas_equalTo(30);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
