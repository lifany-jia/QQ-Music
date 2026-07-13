# QQ Music

一个使用 Objective-C 和 UIKit 编写的仿 QQ 音乐 iOS 练习项目。项目主要实现了音乐首页、个人中心、侧边菜单、迷你播放器、播放详情页和本地音频播放等基础功能，适合用于学习 UIKit 页面搭建、TableView/CollectionView 组合布局、Masonry 自动布局和 AVPlayer 播放控制。

## 功能简介

- 首页推荐流：包含歌单入口、歌曲推荐、AI 歌单等分区内容
- 我的页面：展示用户信息、自建歌单、收藏歌单和常用入口
- 侧边菜单：支持首页抽屉式菜单和个人页更多菜单
- 迷你播放器：底部显示当前播放歌曲，并支持播放/暂停
- 播放详情页：展示封面、歌曲名、歌手、进度条、上一首、下一首、播放/暂停
- 本地音乐播放：通过 `AVPlayer` 播放工程内置的 `.m4a` 音频文件
- 深色模式切换：更多菜单中支持切换浅色/深色外观

## 技术栈

- Objective-C
- UIKit
- AVFoundation / AVPlayer
- Masonry
- CocoaPods
- SF Symbols

## 项目结构

```text
Music
├── AppDelegate.* / SceneDelegate.*     # App 启动与窗口配置
├── MyTabBarVC.*                        # 底部 TabBar 与迷你播放器
├── Home/                               # 首页、首页模型、抽屉菜单、Header 视图
├── Person/                             # 我的页面和更多菜单
├── Music/                              # 播放详情页和播放器单例
├── Cell/                               # 首页、歌单、菜单相关自定义 Cell
├── Assets.xcassets                     # 图片资源
└── *.m4a                               # 本地音频资源
```

## 环境要求

- macOS
- Xcode
- iOS 26.2 或更高版本模拟器/真机
- CocoaPods

> 当前 Xcode 工程中的 `IPHONEOS_DEPLOYMENT_TARGET` 为 `26.2`。如果你的本地 Xcode 或模拟器版本较低，需要在 Xcode 的 Build Settings 中调整 Deployment Target，并确认代码中使用的 API 在目标系统可用。

## 安装与运行

1. 克隆或下载项目后进入工程目录：

   ```bash
   cd "oc/UIKit/Music"
   ```

2. 安装依赖：

   ```bash
   pod install
   ```

3. 使用 Xcode 打开工作区：

   ```bash
   open Music.xcworkspace
   ```

4. 选择 `Music` Scheme 和目标模拟器，点击 Run 运行。

> 注意：安装 CocoaPods 后请打开 `Music.xcworkspace`，不要直接打开 `Music.xcodeproj`，否则 Masonry 依赖可能无法正常链接。

## 核心实现

### 页面入口

`SceneDelegate` 中创建 `MyTabBarVC` 作为根控制器。`MyTabBarVC` 内部包含首页和我的两个 Tab，并管理底部迷你播放器。

### 数据来源

项目中的展示数据集中放在 `HomeModel` 中，目前为本地静态数组，没有接入网络接口。

### 播放器

`MusicPlay` 是播放器单例，负责：

- 设置播放列表和当前播放下标
- 播放、暂停、上一首、下一首
- 进度跳转
- 获取当前播放时间和总时长
- 通过通知广播当前歌曲和播放状态变化

### 播放状态同步

播放状态变化通过 `kMusicPlayerDidChangeNotification` 通知同步到迷你播放器和播放详情页。

## 依赖说明

项目使用 CocoaPods 管理第三方库：

```ruby
pod 'Masonry'
pod 'LookinServer', :configurations => ['Debug']
```

- `Masonry`：用于 Objective-C 自动布局
- `LookinServer`：仅 Debug 环境使用，便于调试 iOS 页面层级

## 资源说明

项目包含多张歌曲封面图片和少量本地 `.m4a` 音频文件。歌曲列表中的音频文件名在 `HomeModel.m` 中配置，播放时会从主 Bundle 中读取对应资源。

## 后续优化方向

- 接入真实音乐接口或本地数据库
- 完善搜索、歌单详情、歌词展示等功能
- 增加播放模式，例如顺序播放、随机播放、单曲循环
- 优化播放进度拖动交互，补充时间显示
- 适配更多屏幕尺寸和较低 iOS 版本
- 为播放器和数据模型补充单元测试

## 许可

本项目仅用于学习和练习 UIKit 开发。
