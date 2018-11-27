import UIKit

// 所有的加密都需要导入 Security.framework

class Aes: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
        
        // CBC mode
        // https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#Cipher_Block_Chaining_.28CBC.29
        let clearData = "clearData0123456".data(using: .utf8)!
        let keyData = "keyData890123456".data(using: .utf8)! // 使用指定的 iv
        
        print("clearData: \(clearData as NSData)") // clearData: <636c6561 72446174 61303132 33343536>
        print("keyData: \(keyData as NSData)") // keyData: <6b657944 61746138 39303132 33343536>
        
        var cryptData: Data?
        
        do {
            cryptData = try aesCBCEncrypt(data: clearData, keyData: keyData)
            print("cryptData:\(cryptData! as NSData)")
            // cryptData:<3631f266 e7afee14 03e49092 24b61fae a168d30c 50d68e3a 7301818b a0d6e9a9 7b9d32f4 9be91eb1 aac3910d bbe2b360>
        } catch (let status) {
            print("Error aesCBCEncrypt: \(status)")
        }
        
        let decryptData: Data?
        
        do {
            decryptData = try aesCBCDecrypt(data: cryptData!, keyData: keyData)
            print("decryptData: \(decryptData! as NSData)")
            // decryptData: <636c6561 72446174 61303132 33343536>
        } catch (let status) {
            print("Error aesCBCDecrypt: \(status)")
        }
    }
}

enum AESError: Error {
    case KeyError((String, Int))
    case IVError((String, Int))
    case CryptorError((String, Int))
}
// the iv is prefixed to the encrypted data
func aesCBCEncrypt(data:Data, keyData:Data) throws -> Data {
    let keyLength = keyData.count
    
    let validKeyLengths = [kCCKeySizeAES128, kCCKeySizeAES192, kCCKeySizeAES256]
    
    if validKeyLengths.contains(keyLength) == false {
        throw AESError.KeyError(("Invalid key length", keyLength))
    }
    
    let ivSize = kCCKeySizeAES128
    let cryptLength = size_t(ivSize + data.count + kCCBlockSizeAES128)
    var cryptData = Data(count: cryptLength)
    
    let status = cryptData.withUnsafeMutableBytes {ivBytes in
        SecRandomCopyBytes(kSecRandomDefault, kCCBlockSizeAES128, ivBytes)
    }
    
    if status != 0 {
        throw AESError.IVError(("IV generation failed", Int(status)))
    }
    
    var numBytesEncrypted: size_t = 0
    let options = CCOptions(kCCOptionPKCS7Padding)
    
    let cryptStatus = cryptData.withUnsafeMutableBytes { cryptBytes in
        data.withUnsafeBytes { dataBytes in
            keyData.withUnsafeBytes { keyBytes in
                CCCrypt(CCOperation(kCCEncrypt),
                        CCAlgorithm(kCCAlgorithmAES),
                        options,
                        keyBytes, keyLength,
                        cryptBytes,
                        dataBytes, data.count,
                        cryptBytes + kCCBlockSizeAES128, cryptLength,
                        &numBytesEncrypted)
            }
        }
    }
    
    if UInt32(cryptStatus) == UInt32(kCCSuccess) {
        cryptData.count = numBytesEncrypted + ivSize
    } else {
        throw AESError.CryptorError(("Encryption failed", Int(cryptStatus)))
    }
    
    return cryptData
}

// The iv is prefixed to the encrypted data
func aesCBCDecrypt(data:Data, keyData:Data) throws -> Data? {
    let keyLength = keyData.count
    let validKeyLengths = [kCCKeySizeAES128, kCCKeySizeAES192, kCCKeySizeAES256]
    if validKeyLengths.contains(keyLength) == false {
        throw AESError.KeyError(("Invalid key length", keyLength))
    }
    
    let ivSize = kCCBlockSizeAES128
    let clearLength = size_t(data.count - ivSize)
    var clearData = Data(count: clearLength)
    
    var numBytesDecrypted: size_t = 0
    let options = CCOptions(kCCOptionPKCS7Padding)
    
    let cryptStatus = clearData.withUnsafeMutableBytes { cryptBytes in
        data.withUnsafeBytes { dataBytes in
            keyData.withUnsafeBytes { keyBytes in
                CCCrypt(CCOperation(kCCDecrypt),
                        CCAlgorithm(kCCAlgorithmAES128),
                        options,
                        keyBytes, keyLength,
                        dataBytes, dataBytes + kCCBlockSizeAES128, clearLength,
                        cryptBytes, clearLength,
                        &numBytesDecrypted)
            }
        }
    }
    
    if UInt32(cryptStatus) == UInt32(kCCSuccess) {
        clearData.count = numBytesDecrypted
    } else {
        throw AESError.CryptorError(("Decryption failed", Int(cryptStatus)))
    }
    return clearData
}
