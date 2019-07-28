//Created  on 2019/6/24 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import CaamDau
import PGPay


//MARK:--- 支付宝支付 ----------
extension PGPay.Ali: PGPayProtocol {
    public typealias DataSource = String
    
    public static var scheme: String {
        get {
            return PGPay.Ali._scheme
        }
        set {
            PGPay.Ali._scheme = newValue
        }
    }
    public static func handleOpen(_ url: URL) {
        guard url.host == "safepay" else { return }
        AlipaySDK.defaultService().processOrder(withPaymentResult: url, standbyCallback: { (result) -> Void in
            let code = result?.intValue("resultStatus") ?? 0
            var payStatus = PGPay.Status.deal
            switch code {
            case 9000:
                payStatus = .succeed
            case 8000,6004:
                payStatus = .deal
            case 6001:
                payStatus = .cancel
            case 4000:
                payStatus = .error(code, "支付失败")
            default:
                payStatus = .error(code, "错误")
            }
            PGPay.shared.completion?(payStatus)
            PGPay.Notic.callBack.post(userInfo:["status":payStatus])
        })
    }
    
    public static func pay(_ order: String, completion: ((PGPay.Status) -> Void)?) {
        AlipaySDK.defaultService()?.payOrder(order, fromScheme: "eyxstore", callback: { (result) in
            let code = result?.intValue("resultStatus") ?? 0
            var payStatus = PGPay.Status.deal
            switch code {
            case 9000:
                payStatus = .succeed
            case 8000,6004:
                payStatus = .deal
            case 6001:
                payStatus = .cancel
            case 4000:
                payStatus = .error(code, "支付失败")
            default:
                payStatus = .error(code, "错误")
            }
            completion?(payStatus)
            PGPay.Notic.callBack.post(userInfo:["status":payStatus])
        })
    }
}

public extension PGPay {
    public struct Ali {
        public static var _scheme:String = ""
    }
}
