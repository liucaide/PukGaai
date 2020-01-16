//Created  on 2019/6/24 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import CaamDau

public class App_WXPay: CD_AppDelegate {
    private override init() {
        
    }
    var scheme = ""
    var appid = ""
    var link = ""
    /// 用此方法初始化 传如 URLTypes 设置的可s判定识别的 Scheme 前缀即可
    /// 如果不传入 appid 则取实际的 scheme
    public init(_ scheme:String, link:String, appid:String = "") {
        self.scheme = CD.appUrlScheme(scheme)
        self.link = link
        self.appid = appid.isEmpty ? self.scheme : appid
    }
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        PGPay.WX.scheme = scheme
        PGPay.WX.registerApp(appid, universalLink:link)
        return true
    }
    
    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        PGPay.WX.handleOpen(url)
        return true
    }
}
