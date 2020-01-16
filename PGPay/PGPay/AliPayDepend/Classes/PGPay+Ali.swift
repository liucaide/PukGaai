//Created  on 2019/6/24 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import CaamDau


//MARK:--- 支付宝支付 ----------
public extension PGPay {
    public struct Ali {}
}


extension PGPay.Ali: PGPayProtocol {
    public typealias DataSource = String
    
    public static var scheme: String {
        get {
            return PGPay.shared.schemes["ali"] as? String ?? CD.appId
        }
        set {
            PGPay.shared.schemes["ali"] = newValue
        }
    }
    public static func handleOpen(_ url: URL) {
        guard url.host == "safepay" else { return }
        guard url.scheme == scheme else { return }
        
        
        AlipaySDK.defaultService().processOrder(withPaymentResult: url, standbyCallback: { (result) -> Void in
            let code = result?.intValue("resultStatus") ?? 0
            var payStatus = PGPay.Status.dealing
            switch code {
            case 9000:
                payStatus = .succeed
            case 8000,6004:
                payStatus = .dealing
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
        PGPay.shared.completion = completion
        AlipaySDK.defaultService()?.payOrder(order, fromScheme: scheme, callback: { (result) in
            let code = result?.intValue("resultStatus") ?? 0
            var payStatus = PGPay.Status.dealing
            switch code {
            case 9000:
                payStatus = .succeed
            case 8000,6004:
                payStatus = .dealing
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
}

