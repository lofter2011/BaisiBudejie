#ReadMe
项目期间代码不完整, 不严谨, 不优雅请不要担心, 我会在接下来的更新中一步步的抽取重构~完全从零开始做一个百思不得姐项目, 实现高仿界面+网络数据. 其中登录注册以及其衍生功能因为不知道百思的加密方式, 就做个样子.

##项目环境搭建
---
创建项目, 勾选git
###添加类前缀
BaisiBudejie.xcodeproj -> Class Prefix:类前缀
###修改应用名字
info.plist ->Bundle name

###软件图标
 Assets.xcassets -> Appicon

```
iPhone Spotlight	-> Spotlight搜索时候的图标
iPhone Settings		-> 在设置里, 访问用户隐私时候出现在设置底部的图标
iPhone App			-> 显示在手机桌面的图标
```

###启动图片

```
Xcode5 之前, 应用图标和启动图片直接在Supporting File中放置
Icon.png
Icon@2x.png
Icon-568@2x.png
Default.png
Default@2x.png
Default-568h@2x.png

现在:
默认加载LaunchScreen.storyboard
```
项目配置: General -> App Icons and Launch Images -> Launch Images Source, 删掉Launch Screen File

###屏幕方向

Deployment Info -> Device Orientation

- Portrait 竖屏
- Upside Down 竖屏,上下颠倒
- Landscape Left 向左颠倒
- Landscape Right 向右颠倒

如果说, 某个界面支持, 别的不支持, 也需要勾选左右的颠倒

```
// 在控制器中使用使用以下方法可以更改屏幕朝向
- shouldAutoRotate
- supportedInterfaceOrientations
```

##主界面UITabBarController
---
程序启动之后, 点击下面不同的按钮, 能跳转到不同的控制器, 显然是个UITabBarController

为了将控制器的细节隐藏, 我们选择自定义一个UITabBarController, 在它内部进行初始化

添加子控制器之后, 才能点击tabbar切换子控制器view

- (在这里给子控制器view设置颜色, 我直接写了一个颜色分类, 实现了随机颜色的方法, 关于iOS中的颜色我会在最近写一篇微博介绍的)

我们需要对TabBarItem进行一些设置, 让其变得更像原App一些

- 字体 (根据子控制器的tabBarItem的title属性, 需要什么在"NSAttributedString.h"头文件中找)

	`setTitleTextAttributes:forState:`方法来设置
	- 改变字体大小(NSFontAttributeName)
	- 改变字体颜色(NSForegroundColorAttributeName)
	- Tips:只要发现方法名中有attribute, 参数需要传字典, 都是我们设置的这个字体字典

	你还要知道
	
	```
	iOS7之前: UITextAttributeXXX, 可以在UIStringDrawing.h中找到 (只能用在iOS中)
	
	iOS7开始: NSXXXXAttributeName, 可以在NSAttributedString.h中找到 (iOS/Mac)
	```
- 图片 (tabBarItem的image和selectedImage设置)
	- 默认添加的图片是经过渲染的, 一下两种解决办:
		- 通过image的`imageWithRenderingMode`方法
		- 直接在图片assets中设置
		
	在之前做一个小项目的时候我已经写过一个分类, 打包了获取图片和渲染, 这里直接拿过来用了, 这个分类是UIImage + Image
		
####appearence对象
只要给appearance对象设置了一些属性, 那么这个类型的对象都设置了这些属性

注意: 只有属性或方法后面带有`UI_APPEARANCE_SELECTOR`的宏, 就可以通过appearance来统一设置

####方法抽取Tips: 涉及到中文输入的参数放在最后面, 先输中文的话后面参数会没有自动提示