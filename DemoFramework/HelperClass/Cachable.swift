//
//  Cachable.swift
//  JSONTutorialFinal
//
//  Created by James Rochabrun on 4/3/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit
import CryptoSwift

//1 Create the protocol
protocol Cachable {}

//2 creating a imageCache private instance
private let imageCache = NSCache<NSString, UIImage>()

//3 UIImageview conforms to Cachable
extension UIImageView: Cachable {}

//4 creating a protocol extension to add optional function implementations, 
public extension Cachable where Self: UIImageView {
    
    //5 creating the function
    typealias SuccessCompletion = (Bool) -> ()
    func loadImageUsingCacheWithURLString(_ URLString: String, placeHolder: UIImage?,mode:UIView.ContentMode = .scaleAspectFill, completion: @escaping SuccessCompletion) {
        self.contentMode = mode
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
//            DispatchQueue.main.async {
                self.image = cachedImage
                completion(true)
//            }
            return
        }
        self.image = placeHolder
        
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    return
                }
                if httpResponse.statusCode == 200 {
                    
                    if let data = data {
                        if let downloadedImage = UIImage(data: self.decryptImageData(imageData: data)) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            DispatchQueue.main.async {
                                
                                self.image = downloadedImage
                                completion(true)
                            }
                        }else{
                             self.image = placeHolder
                        }
                    }
                } else {
                    self.image = placeHolder
                }
            }).resume()
        } else {
            self.image = placeHolder
        }
    }
    func decryptImageData(imageData:Data) -> Data  {
        do {
            
            let objEncryptionKey = preferenceHelper.getSceneEncryptionKey()
            let key:Array<UInt8> = Data.init(base64Encoded: (objEncryptionKey?.k) ?? "")!.bytes
            let iv:Array<UInt8> = Data.init(base64Encoded:(objEncryptionKey?.iv) ?? "")!.bytes
            let encryptedText:Array<UInt8> = imageData.bytes
            let decrypted = try AES(key: key, blockMode: CTR.init(iv: iv), padding: .pkcs7).decrypt(encryptedText)
            return Data(decrypted)

            
        }
        catch{
            print(error)
        }
        return Data()
    }
}


