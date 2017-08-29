# 聊聊换肤

# 一、前言
      
   一个App发展到后期，没有几套主题，完全拿不出手啊。特别是toB的公 司，客户要求自己的个性更是正常不过的需求了。换肤是个细活、细活、细活，重要的事说三遍，方案设计也是相当关键。

# 二、方案对比
## 2.1 换肤要处理的问题
    1.配置抽离。
    2.已存在界面的动态变换。
## 2.2 分析
针对第一点，确实没太多说道，主要是和UI撕抽取公共配置和细节配置，这是一个细活。而界面的动态变换，这是一个麻烦事。
##### 2.2.1 通知切换主题
这个事我们首先想到的就是通知，但是用通知太麻烦了，监听移除一个改变写两地。而且一个大型app,很多view其实并没有属性引用，使用通知又需要把这些view属性引用出来，无形中增加了很多工作量。既然已经有通知保底了，我们何不尝试一下其它方案。
##### 2.2.2 RX OR RAC
针对上面所说关于通知的两个问题，我们使用 ReactiveCocoa 或 RXSwift 来优雅的处理这个问题。不过大部分项目并没有使用链式编程，为了换肤导入貌似不太划算。

##### 2.2.3 使用block来处理
在项目中建一个单例来管理配置，将所有颜色配置代码块放入block中并加入到单例的数组中管理，在切换主题时，遍历数组执行一遍block即可。当然使用时要注意block引用问题，保证视图的正常释放，随着app的使用block会越来越多，要及时清理已释放view的block。

# 三、block方案的实现
写了个小Demo具体可看 [github －ArtChangeTheme](https://github.com/weijingyunIOS/ArtChangeTheme) 下面做一些简单的讲解。
##3.1 配置的模块划分
换肤是个细活，项目过大就需要进行模块划分，每个人负责自己的模块，看似麻烦的事分到个人也就不多了。Demo写了 Module1到Module4 四个模块，每个模块下都建了一个UIStyle文件夹用于管理当前模块的配置。公共UIStyle则和模块目录同级。通过分类扩展。
        
    - (NSString *)getStyleName_Module1;
    每个模块都要写该方法，用于返回本模块使用的配置文件plist。
    方法的命名规则是  getStyleName_模块名。 以此解耦，解耦思路是参考
    测试用例执行所有 以test开头的方法，为此写了个分类NSObject+ArtPrefix。

## 3.2 配置的解析
![配置plist图示](http://upload-images.jianshu.io/upload_images/1697924-ae8792757008ae93.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
如上图模块下配置分为 Image 与 Style，Image为图片配置，
##### 3.2.1 图片的配置
 toPath表示图片所在的相对文件夹，imageConfigs里面包含了需要动态配置的文件名以及备注，这是一个规范，我们可以很清楚的看到处理了哪些图片，如果打包动态替换主题，也可通过该配置去替换需要的图片。
##### 3.2.2 Style样式配置
color：000000,0.5  前面表示 Hex设置 0.5表示透明度。
font： 表示字体大小。
还有 ArtLayoutInfo 类对应的属性 是用于描述约束关系配置的，比如某些客户可能对 banner 的宽高比有所要求，这个可以在这做扩展配置。

## 3.3 block方案接口设计

    - (void)saveStrongSelf:(id)strongSelf block:(void(^)(id weakSelf))aBlock;

如上：考虑代码的调用方便，和block及时的清理标记，设计了如上的调用接口，这样大家不用写__weak typeof(self) weakSelf = self,这么麻烦，但是如果block内有用非weakSelf. 调用的view请注意弱引用声明。
ArtUIStyleManager内部开启了定时器（默认60s可设置clearInterval控制间隔）去检测清理无用的block。实现原理是将 strongSelf 弱引用存储，检测其被释放后删除对应的block。至于弱引用存储的实现大家可以看看 [iOS - 如何实现弱引用字典](http://www.jianshu.com/p/51156d4ae885)，我这里使用的是block封装与解封。这种小技巧平时用不到，关键时刻还是能帮你一把的。

      - (void)reloadStylePath:(NSString *)aStylePath;
      - (void)reloadStyleBundleName:(NSString *)aStyleBundleName;
      - (void)reloadStyleBundle:(NSBundle *)aStyleBundle;
      这三个方法是用于加载其它样式的，具体可看demo中ArtModule4ViewController。

# 四、几个小技巧
## 4.1 能用Color解决的就别麻烦UI出新图了
   很多UI控件都有个 tintColor 属性，很多图片是纯色的，大家直接通过tintColor渲染就好了。Demo也提供了一个分类UIImage+ArtDraw来进行渲染绘制。不过我遇到了一个坑，我把渲染的图做了拉伸，点击了返回时，颜色还原成图片本身的颜色。大家使用时注意一下即可。

## 4.2 iOS 8后系统自动会将@3x图片自动适配图片
如题，大家搜一下即可，也就是说来张@3x即可，要适配iOS8 一下的话，自己用代码切一下也是没问题的。不过虽说系统自动适配，但是我在1x的老iPad上出现了图片虚化有毛边的情况，加了1x图就好很多，这个大家自己看着办。

## 4.3 为什么不用iconfont呢
[在iOS开发中使用iconfont图标](http://www.jianshu.com/p/3b10bb95b332)
为什么不用呢？唉，长叹一声。

# 五、来个HotReloader
![HotReloader演示](http://upload-images.jianshu.io/upload_images/1697924-e6c62ae58cc743a0.gif?imageMogr2/auto-orient/strip)

换肤这个事，最蛋疼的应该是，改一点跑一次代码，这个耗时太久了，加一个小插件ArtUIStyleHotReloader 修改之后，command+s ，就能动态变了，当然只能模拟器使用。代码很简单，感谢[VKCssProtocol](https://github.com/Awhisper/VKCssProtocol)。

# 六、结尾
2017.08.28，今天是个好日子，但是出了点事，心情不太好，这篇文章也就简单的写写了。这个OC在原有的一些上面扩展的ArtUIStyle看着可能有些臃肿。改天抽空写个swift版的，还是这个 [github －ArtChangeTheme](https://github.com/weijingyunIOS/ArtChangeTheme)。赶紧去github给个小星星吧。
 换肤这个事，UI自己要有套设计规范，如果前期没有规范不要紧，做个换肤看他还有没规范，再没规范大家就GG了。最后来个扩展阅读 [VKCssProtocol](https://github.com/Awhisper/VKCssProtocol)。
