# ![](https://github.com/liucaide/Images/blob/master/CD/pukgaai.jpg)PukGaai
第三方SDK扩展&amp;组件化，OC进行Swift化； 包含常用  三大支付SDK、友盟、推送、地图……

# 目录
- [支付插件](#支付插件)
  - [支付宝](#支付宝)
  - [微信](#微信)
  - [银联](#银联)
- [友盟](#友盟)

## 支付插件
![](https://github.com/liucaide/Images/blob/master/PGPay/1.png)
- 你需要下载仓库中的 PGPay、PGPay.podspec，添加到你的主工程目录下
- 当然不要忘记在 info.plist 中添加 LSApplicationQueriesSchemes 项
- 三大支付插件已经完全进行组件化，只需要在 AppDelegate 中如此使用
```
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    lazy var composite: CD_AppDelegateComposite = {
        window = UIWindow(frame: UIScreen.main.bounds)
        var arr:[CD_AppDelegate] = [
            App_AliPay("alipay"),
            App_WXPay("wx", link: ""),
            App_UnionPay("uppay")
        ]
        return CD_AppDelegateComposite(arr)
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        composite.application(application, didFinishLaunchingWithOptions:launchOptions)
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return composite.application(app, open: url, options: options)
    }
}

```
**当然也可以这样使用，即：复制 PGPay 中 App_ 内容**
### 支付宝
```
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        PGPay.Ali.scheme = scheme
        return true
    }
    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        PGPay.Ali.handleOpen(url)
        return true
    }
```
### 微信
```
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        PGPay.WX.scheme = scheme
        PGPay.WX.registerApp(appid, universalLink:link)
        return true
    }
    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        PGPay.WX.handleOpen(url)
        return true
    }
```
### 银联
```
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        PGPay.Union.scheme = scheme
        return true
    }
    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        PGPay.Union.handleOpen(url)
        return true
    }
```
[回顶部目录](#回顶部目录)
## 友盟
```
```
[回顶部目录](#回顶部目录)