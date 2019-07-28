//Created  on 2019/6/24 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import CaamDau
import PGPay
class App_UnionPay: CD_AppDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        PGPay.Union.scheme = CD.appUrlScheme("uppay")
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        PGPay.Union.handleOpen(url)
        return true
    }
}

