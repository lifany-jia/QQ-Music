//
//  SceneDelegate.m
//  Music
//
//  Created by lifany on 2026/5/7.
//

#import "SceneDelegate.h"
#import "HomeVC.h"
#import "PersonVC.h"
@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    UITabBarController *tab = [[UITabBarController alloc] init];
    
    HomeVC *home = [[HomeVC alloc] init];
    home.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage systemImageNamed:@"house"] selectedImage:[UIImage systemImageNamed:@"house.fill"]];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:home];
    
    PersonVC *person = [[PersonVC alloc] init];
    person.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage systemImageNamed:@"person"] selectedImage:[UIImage systemImageNamed:@"person.fill"]];
    
    tab.viewControllers = @[homeNav, person];
    tab.tabBarMinimizeBehavior = UITabBarMinimizeBehaviorOnScrollDown;
    tab.tabBar.tintColor = [UIColor systemGreenColor];
    tab.tabBar.unselectedItemTintColor = [UIColor systemGreenColor];
    
    self.window.rootViewController = tab;
    [self.window makeKeyAndVisible];
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
