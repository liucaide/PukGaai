//Created  on 2019/6/24 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import CaamDau

public protocol PGPayProtocol {
    associatedtype DataSource
    static var scheme:String {get set}
    static func handleOpen(_ url:URL)
    static func pay(_ order: DataSource, completion:((PGPay.Status)->Void)?)
}


public class PGPay {
    private init(){}
    public static let shared = PGPay()
    open var schemes:[String:String] = [:]
    open var completion:((PGPay.Status)->Void)?
}

public extension PGPay {
    enum Style {
        case ali
        case wx
        case union
    }
    
    enum Status {
        case succeed
        case dealing
        case cancel
        case error(_ code:Int, _ msg:String)
        case signerError
        case none
    }
    enum Notic:String {
        case callBack = "callBack"
    }
    
}
extension PGPay.Notic: CaamDauNotificationProtocol {
    public var name: Notification.Name {
        return Notification.Name(CD.appId + ".pay." + self.rawValue)
    }
}
