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

##广告
---
###展示方案
一般来说, 程序的启动速度是非常快的, 通常启动图片都是一闪而过, 为了在展示广告的时候不是那么生硬并且保证广告的展示时间, 我们可以在启动图片和程序主界面之间, 搞一个广告控制器, 广告控制器的view和启动图片显示保持一致, 并且在启动图片的空白处展示广告.

整个项目的启动过程大概是这样的

1. 加载启动图片<br/><br/>
2. app根控制器设置为广告控制器
	- 用户点击广告内容 -> 第3步
	- 广告展示结束 / 用户跳过广告 -> 第4步<br/><br/>
3. 进入广告的详情
	- 用户关闭详情 -> 第4步<br/><br/>
4. 根控制器-主界面控制器

###根据不同的设备加载不同的启动图片
启动图片可以根据屏幕大小而改变, 但是普通图片不可以的. 我们的广告界面希望背景图片和启动图片是无缝转换的(不要让用户看出来), 所以要根据不同的设备选择合适的图片作为默认背景图片

```
根据设备屏幕尺寸, 来决定用什么启动图片
screenHeight : 
736 展示6p/6sp的启动图片
667 展示6/6s的启动图片
568 展示5/5s的启动图片
480 展示Other iphone的启动图片
```


### 展示广告的流程
在广告控制器上添加一个显示广告View

启动完毕之后, 先检测沙盒中是否有广告内容.

- 如果有: 直接显示沙盒中的广告内容
- 如果没有: 显示默认的广告图片(在程序运行过程中, 随时获取新的广告内容, 写入沙盒)
	- 广告获取的策略根据你的公司来定, 比如每周一次啦, 每天一次啦什么什么的, 但是最好尽可能少的来获取广告, 不然体验会不太好
	- 有些策略是: 检测到用户是wifi情况下, 不从沙盒检测了, 直接从服务器获取数据. 但是这种方式比较依赖于WiFi的速度
- 添加一个定时器, 用来设置广告的展示

### 用户交互事件

在展示广告的时候, 需要在屏幕上添加一个按钮来让用户选择跳过广告

####跳过广告
- 点击按钮执行跳过广告的方法 / 广告时间达到预设时间
	- 根控制器切换成主界面的控制器
- 关闭定时器

####查看广告详情
点击广告图片跳转到广告详情

点击广告图片的事件需要我们自己添加

- UIImage如果需要与用户交互, 需要userInteractionEnable为YES. 然后我们给广告图片添加手势即可


点击广告图片

1. 关闭定时器
2. 跳转到广告的内容


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

######方法抽取Tips: 涉及到中文输入的参数放在最后面, 先输中文的话后面参数会没有自动提示

### 发布按钮
- 作用:
	- app中该按钮点击之后用于发布一些新东西. 界面会类似于modal弹出东西, 需要特殊处理

- 布局
	- 发布按钮需要添加到UITabBar上, 居中

####方案1: ~~添加占位控制器~~
添加一个空的UIViewController作为占位控制器, 不设置标题和图片, 然后用发布按钮挡住后面的UIBarButton.

- 操作
	- 在viewDidLoad方法中添加按钮

	- 出现的问题:
		- 我们发现按钮不能点击, 打开调试视图发现按钮在最下面
	- 原因:
		- 在viewDidLoad方法中调用之后, 发布按钮被添加到UITabBar中, 但是TabBarButton还没有添加, UITabBar会在比较靠后的时间才添加TabBarButton
	- 解决办法: 尽可能迟的添加发布按钮		
		- 我们在viewWillAppear添加 解决这个问题. 但是因为viewWillA片per会执行多次, 所以按钮也被添加了多次

		```
		调用时刻不同, 而且
		viewDidLoad只调用一次
		viewWillAppear会调用多次
		```
		- 那就只让发布按钮的创建添加代码只执行一次
			1. dispatch_onece
			2. 添加一个记录属性
			3. 按钮懒加载

至此解决了按钮不能点击, 或者添加多次的问题
#####总结:

这么做虽然完成了需求, 但是多了一个TabBarButton, 多了一个控制器, 逼死强迫症.

这个方案添加简单, 但是不能知道确切的布局时刻, ***所以不要过度依赖于控制器的生命周期方法***

####方案2: 修改TabBarButton的frame
遍历TabBar来挨个挪动TabBarButton的位置(减小宽度, 前两个左移, 后两个右移)

- 这样做的话, 就需要在viewDidAppear方法里调用才行
- 但是我们发现UITabBarButton 可以改变位置, 不能改变尺寸
	- 如果想调整tabbar内部子控件frame, 那么重写tabbar的layoutSubviews

- 解决方案
	- 新建一个类继承自UITabBar, 重写layoutSubviews. 然后用我们自定义的TabBar覆盖系统的TabBar
	
	```
	- (void)replaceTabBar
	{
    	[self setValue:[[XYTabBar alloc] init] forKeyPath:@"tabBar"];
	}
	```
	- 疑惑:
		- 替换了tabbar之后, 并没有给它添加子控件, 但是为什么tabbarbutton都添加上去了? 
	- 解答:
		- 因为添加的时候是viewDidLoad, 之前我们发现viewDidLoad之后, tabbarbutton其实还没添加上去. 直到viewWillAppear才添加进去. 到哪个时候, self.tabBar已经替换成我们自己定义的了

既然已经封装了TabBar了, 加号按钮也是加到TabBar上了, 那干脆就把加号按钮封装进TabBar中, 在layoutSubviews中为其布局就ok!

- 细节
	- 我们都知道,UIButton内部有imageView和textLabel两个子控件, 但是如果只设置了标题, 我们在调试视图中发现按钮没有imageView子控件<br/><br/>
- 由此我们发现
	- 苹果的按钮中imageView和Label都是懒加载的, 性能可靠<br/><br/>
- 因此
	- 我们在封装子控件的时候, 也可以采用懒加载, 用到时再创建


该方案优点:

1. 不需要多添加控制器和TabBarButton, 节省了内存空间
2. 不用去思考在控制器的哪个生命周期方法来做
3. 封装了一切和tabbar相关的东西, 控制器不需要关心tabbar里面的东西


到此为止, 主界面的UITabBar我们就设置完了