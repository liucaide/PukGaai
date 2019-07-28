//Created  on 2019/6/24 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import CaamDau
import PGPay

extension PGPay.WX: PGPayProtocol {
    public static var scheme: String {
        get {
            return PGPay.WX._scheme
        }
        set {
            PGPay.WX._scheme = newValue
        }
    }
    
    public static func handleOpen(_ url: URL) {
        guard url.scheme == scheme else {
            return
        }
        WXApi.handleOpen(url, delegate: PGPay.WX.delegate)
    }
    
    public static func pay(_ order: PGPay.WX.Order, completion: ((PGPay.Status) -> Void)?) {
        let  req = PayReq()
        req.partnerId = order.partnerId
        req.prepayId = order.prepayId
        req.nonceStr = order.nonceStr
        req.timeStamp = order.timeStamp
        req.sign = order.sign
        req.package = order.package
        WXApi.send(req)
    }
    
    public typealias DataSource = PGPay.WX.Order
    
    
}


public extension PGPay {
    public struct WX {
        static var _scheme = ""
        static func registerApp(_ id:String){
            WXApi.registerApp(id)
        }
        static var delegate:Delegate = Delegate()
        public struct Order {
            public init() {}
            public var partnerId:String = ""
            public var prepayId:String = ""
            public var nonceStr:String = ""
            public var timeStamp:UInt32 = 0
            public var sign:String = ""
            public var package = "Sign=WXPay"
        }
    }
    
    class Delegate: NSObject, WXApiDelegate {
        //var completion: ((PGPay.Status) -> Void)?
        public func onReq(_ req: BaseReq) {
            
        }
        
        public func onResp(_ resp: BaseResp) {
            if let resp = resp as? PayResp {
                self.callPayResp(resp)
            }
        }
        func callPayResp(_ res:PayResp) {
            var payStatus = PGPay.Status.deal
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

