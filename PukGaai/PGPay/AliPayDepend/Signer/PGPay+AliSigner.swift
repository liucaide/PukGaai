//Created  on 2019/6/24 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 * 支付宝客户端签名支付
 */




import Foundation
import CaamDau
import PGPay

extension PGPay.Ali.Signer:PGPayProtocol {
    typealias DataSource = (order:PGPay.Ali.Signer.Order, key:String)
    static var scheme: String {
        get {
            return PGPay.Ali._scheme
        }
        set {
            PGPay.Ali._scheme = newValue
        }
    }
    
    static func handleOpen(_ url: URL) {
        PGPay.Ali.handleOpen(url)
    }
    
    static func pay(_ order: (order:PGPay.Ali.Signer.Order, key:String), completion: ((PGPay.Status) -> Void)?) {
        let signer = APRSASigner(privateKey: order.key)
        let description = order.order.toString()
        guard let signedString = signer?.sign(description, withRSA2: false) else {
            completion?(.signerError)
            return
        }
        PGPay.Ali.pay(signedString, completion: completion)
    }
}
extension PGPay.Ali {
    struct Signer {
        public struct Order {
            public init() {}
            public var partner:String = ""
            public var seller_id:String = ""
            public var out_trade_no:String = ""
            public var total_fee:String = ""
            public var notify_url:String = ""
            public var body:String = ""
            public var subject:String = ""
            
            public var service = "alipay.trade.app.pay"
            public var payment_type = "1"
            public var _input_charset = "utf-8"
            public var it_b_pay = "30m"
            public var show_url = "m.alipay.com"
            func toString() -> String {
                let structMirror = Mirror(reflecting: self).children
                return structMirror.filter{$0.label != nil}.map{$0.label!.stringValue + "=" + "\($0.value)"}.joined(separator: "&")
            }
        }
    }
}


