//Created  on 2019/6/24 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import CaamDau

public class App_AliPay: CD_AppDelegate {
    
    private override init() {
        
    }
    var scheme = ""
    /// 用此方法初始化 传如 URLTypes 设置的可s判定识别的 Scheme 前缀即可
    public init(_ scheme:String) {
        self.scheme = CD.appUrlScheme(scheme)
        
    }
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        PGPay.Ali.scheme = scheme
        return true
    }
    
    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        PGPay.Ali.handleOpen(url)
        return true
    }
}
