//Created  on 2019/6/24 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import CaamDau


public extension PGPay {
    public struct WX {
        static let delegate = Delegate()
        static func registerApp(_ id:String, universalLink:String){
            //WXApi.registerApp(id, universalLink: universalLink)
            WXApi.registerApp(id)
        }
        public struct Order {
            public init(partnerId:String, prepayId:String, nonceStr:String, timeStamp:UInt32, sign:String) {
                self.partnerId = partnerId
                self.prepayId = prepayId
                self.nonceStr = nonceStr
                self.timeStamp = timeStamp
                self.sign = sign
            }
            public var partnerId:String
            public var prepayId:String
            public var nonceStr:String
            public var timeStamp:UInt32
            public var sign:String
            public var package = "Sign=WXPay"
        }
    }
}
extension PGPay.WX: PGPayProtocol {
    public typealias DataSource = PGPay.WX.Order
    public static var scheme: String {
        get {
            return PGPay.shared.schemes["wechat"] as? String ?? CD.appId
        }
        set {
            PGPay.shared.schemes["wechat"] = newValue
        }
    }
    
    public static func handleOpen(_ url: URL) {
        guard url.scheme == scheme else {
            return
        }
        WXApi.handleOpen(url, delegate: delegate)
    }
    
    public static func pay(_ order: PGPay.WX.Order, completion: ((PGPay.Status) -> Void)?) {
        PGPay.shared.completion = completion
        let  req = PayReq()
        guard !order.partnerId.isEmpty,
            !order.prepayId.isEmpty,
            !order.nonceStr.isEmpty,
            !order.sign.isEmpty else {
                completion?(.error(-88, "支付配置错误"))
                return
        }
        req.partnerId = order.partnerId
        req.prepayId = order.prepayId
        req.nonceStr = order.nonceStr
        req.sign = order.sign
        req.timeStamp = order.timeStamp
        req.package = order.package
        WXApi.send(req)
    }
}

extension PGPay.WX {
    class Delegate: NSObject, WXApiDelegate  {
        func onReq(_ req: BaseReq) {
            
        }
        
        func onResp(_ resp: BaseResp) {
            if let resp = resp as? PayResp {
                self.callPayResp(resp)
            }
        }
        func callPayResp(_ res:PayResp) {
            var payStatus = PGPay.Status.dealing
            if res.errCode == WXSuccess.rawValue {
                payStatus = .succeed
            }else{
                payStatus = .error(Int(res.errCode), res.errStr)
            }
            PGPay.shared.completion?(payStatus)
            PGPay.Notic.callBack.post(userInfo:["status":payStatus])
        }
    }
}
