import UIKit

// 需要在桥接文件中导入 #import <CommonCrypto/CommonCrypto.h>
// 如果没有，则自己创建
// 再至專案 → TARGETS → Build setting → 搜尋 bri → 雙擊 Objective-C Bridging Header
// 将 Header.h 添加到对话框中，注意路径
// https://medium.com/@mikru168/ios-%E5%A6%82%E4%BD%95%E5%9C%A8-swift-%E5%B0%88%E6%A1%88%E4%B8%AD%E4%BD%BF%E7%94%A8-objective-c-%E7%9A%84%E5%87%BD%E5%BC%8F%E5%BA%AB%E6%88%96%E6%AA%94%E6%A1%88-943de5a8c71

class Hmac: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let clearString = "clearData0123456"
        let keyString = "keyData8901234562"
        let clearData = clearString.data(using: .utf8)!
        let keyData = keyString.data(using: .utf8)!
        
        print("clearString: \(clearString)") // clearString: clearData0123456
        print("keyString:   \(keyString)") // keyString:   keyData8901234562
        print("clearData: \(clearData as NSData)") // clearData: <636c6561 72446174 61303132 33343536>
        print("keyData:   \(keyData as NSData)") // keyData:   <6b657944 61746138 39303132 33343536 32>
            

        // 下面的全部结果 <bb358f41 79b68c08 8e93191a da7dabbc 138f2ae6>
        let hmacData1 = hmac(hashName:"SHA1", message:clearData, key:keyData)
        print("hmacData1: \(hmacData1! as NSData)")
        
        let hmacData2 = hmac(hashName:"SHA1", message:clearString, key:keyString)
        print("hmacData2: \(hmacData2! as NSData)")
        
        let hmacData3 = hmac(hashName:"SHA1", message:clearString, key:keyData)
        print("hmacData3: \(hmacData3! as NSData)")
    }
}
// MD5, SHA1, SHA224, SHA256, SHA384, SHA512

// AES encryption
// aesCBC128Encrypt: create a random IV
// aesCBC128Decrypt
// key: 128bits(16bytes), 192bits(24bytes), 256bits(32bytes)
extension Hmac {
    func hmac(hashName:String, message:Data, key:Data) -> Data? {
        let algos = [
            "SHA1": (kCCHmacAlgSHA1, CC_SHA1_DIGEST_LENGTH),
            "MD5":  (kCCHmacAlgMD5, CC_MD5_DIGEST_LENGTH),
            "SHA224":(kCCHmacAlgSHA224, CC_SHA224_DIGEST_LENGTH),
            "SHA256":(kCCHmacAlgSHA256, CC_SHA256_DIGEST_LENGTH),
            "SHA384":(kCCHmacAlgSHA384, CC_SHA384_DIGEST_LENGTH),
            "SHA512":(kCCHmacAlgSHA512, CC_SHA512_DIGEST_LENGTH)
        ]
        guard let (hashAlgorithm, length) = algos[hashName] else {
            return nil
        }
        
        var macData = Data(count: Int(length))
        macData.withUnsafeMutableBytes { macBytes in
            message.withUnsafeBytes { messageBytes in
                key.withUnsafeBytes { keyBytes in
                    CCHmac(CCHmacAlgorithm(hashAlgorithm),
                           keyBytes, key.count,
                           messageBytes, message.count,
                           macBytes)
                }
            }
        }
        return macData
    }
    // 支持其它格式
    func hmac(hashName:String, message:String, key:String) -> Data? {
        let messageData = message.data(using: .utf8)!
        let keyData = key.data(using: .utf8)!
        return hmac(hashName: hashName, message: messageData, key: keyData)
    }
    
    func hmac(hashName:String, message:String, key:Data) -> Data? {
        let messageData = message.data(using: .utf8)!
        return hmac(hashName: hashName, message: messageData, key: key)
    }
}
