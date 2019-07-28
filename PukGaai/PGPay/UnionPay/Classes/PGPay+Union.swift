//Created  on 2019/6/24 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import CaamDau
import PGPay

extension PGPay.Union: PGPayProtocol {
    public typealias DataSource = (tn:String, mode:String?, vc:UIViewController?)
    public static var scheme: String {
        get {
            return PGPay.Union._scheme
        }
        set {
            PGPay.Union._scheme = newValue
        }
    }
    
    public static func handleOpen(_ url: URL) {
        guard url.scheme == scheme else { return}
        UPPaymentControl.default()?.handlePaymentResult(url, complete: { (str, json) in
            var payStatus = PGPay.Status.deal
            switch str {
            case "success":
                payStatus = .succeed
            case "cancel":
                payStatus = .cancel
            case "fail":
                payStatus = .cancel
            default:
                payStatus = .error(0, "错误")
            }
            PGPay.shared.completion?(payStatus)
            PGPay.Notic.callBack.post(userInfo:["status":payStatus])
        })
    }
    
    public static func pay(_ order: (tn:String, mode:String?, vc:UIViewController?), completion: ((PGPay.Status) -> Void)?) {
        UPPaymentControl.default()?.startPay(order.tn, fromScheme: scheme, mode: order.mode ?? "00", viewController: order.vc ?? CD.visibleVC ?? CD.window?.rootViewController)
    }
    
    
    
    
}
public extension PGPay{
    public struct Union {
        static var _scheme = ""
    }
}


