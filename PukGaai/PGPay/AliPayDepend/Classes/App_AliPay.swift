//Created  on 2019/6/24 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import CaamDau
import PGPay
class App_AliPay: CD_AppDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        PGPay.Ali.scheme = CD.appUrlScheme("own")
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        PGPay.Ali.handleOpen(url)
        return true
    }
}
