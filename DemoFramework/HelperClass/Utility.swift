//
//  Utility.swift
//  DemoFramework
//
//  Created by MacPro3 on 08/01/21.
//

import Foundation
import UIKit
import CryptoSwift

public class Utility
{
    static var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    static var overlayView = UIView()
    static var mainView = UIView()
    init() {
        
    }
    static func showLoading(color: UIColor = UIColor.white){
        DispatchQueue.main.async {
            if(!activityIndicator.isAnimating) {
                self.mainView = UIView()
                self.mainView.frame = UIScreen.main.bounds
                self.mainView.backgroundColor = UIColor.clear
                self.overlayView = UIView()
                self.activityIndicator = UIActivityIndicatorView()
                
                overlayView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
                overlayView.backgroundColor = UIColor(white: 0, alpha: 0.7)
                overlayView.clipsToBounds = true
                overlayView.layer.cornerRadius = 10
                overlayView.layer.zPosition = 1
                
                activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
                activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
                activityIndicator.style = .whiteLarge
                overlayView.addSubview(activityIndicator)
                self.mainView.addSubview(overlayView)
                if UIApplication.shared.keyWindow?.viewWithTag(701) != nil {
                    
                }else{
                    overlayView.center = (UIApplication.shared.keyWindow?.center)!
                    mainView.tag = 701
                    UIApplication.shared.keyWindow?.addSubview(mainView)
                    activityIndicator.startAnimating()
                }

            }
            
        }
    }
    
    static func hideLoading(){
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            mainView.removeFromSuperview()
            UIApplication.shared.keyWindow?.viewWithTag(701)?.removeFromSuperview()
        }
    }
    static func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    public static func dateToString(date: Date, withFormat:String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC") ?? TimeZone(identifier: "UTC") ??  TimeZone.ReferenceType.default
        dateFormatter.dateFormat = withFormat
        let currentDate = dateFormatter.string(from: date)
        return currentDate
    }
    public static func stringToDate(strDate: String, withFormat:String) -> Date{
           let dateFormatter = DateFormatter()
           dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC") ?? TimeZone(identifier: "UTC") ??  TimeZone.ReferenceType.default
           dateFormatter.dateFormat = withFormat
           return dateFormatter.date(from: strDate) ?? Date()
    }
    public static func saveVideo(urlString: String,completionHandler: @escaping (URL?) -> ()) {
        guard let videoUrl = URL(string: urlString) else {
            Utility.hideLoading()
            completionHandler(nil)
            print("error in playing video")
            return
        }
        DispatchQueue.global().async {
            do {
                let videoData = try Utility.decryptVideoData(videoData: Data(contentsOf: videoUrl))
                
                
                let fm = FileManager.default
                guard let docUrl = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {
                    print("Unable to reach the documents folder")
                    
                    return
                }
                var fileName:String = "myVideo.mp4"
                if let strVideoRange = urlString.range(of: ".mp4")
                {
                    let test = String(urlString[..<strVideoRange.upperBound])
                    if let range = test.range(of: "/",options: .backwards)
                    {
                        print(test[..<range.upperBound])
                        let startPos = Int(test.distance(from: urlString.startIndex, to: range.upperBound))
                        fileName = String(test[String.Index(utf16Offset: startPos, in: test)..<String.Index(utf16Offset: test.count, in: test)])
                        print(fileName)
                    }
                }
                let filePath =  docUrl.appendingPathComponent("Videos")
                if !fm.fileExists(atPath: filePath.path) {
                    do {
                        try fm.createDirectory(atPath: filePath.path, withIntermediateDirectories: true, attributes: nil)
                    } catch {
                        NSLog("Couldn't create document directory")
                    }
                }
                let localUrl = filePath.appendingPathComponent(fileName)
                try videoData.write(to: localUrl)
                DispatchQueue.main.async {
                    completionHandler(localUrl)
                    Utility.hideLoading()
                    
                }
                
                
            } catch  {
                completionHandler(nil)
                Utility.hideLoading()
                print("could not save data")
            }
        }
        
    }
    public static func decryptVideoData(videoData:Data) -> Data  {
        do {
            let objEncryptionKey = preferenceHelper.getSceneEncryptionKey()
            let key:Array<UInt8> = Data.init(base64Encoded: (objEncryptionKey?.k) ?? "")!.bytes
            let iv:Array<UInt8> = Data.init(base64Encoded:(objEncryptionKey?.iv) ?? "")!.bytes
            let encryptedText:Array<UInt8> = videoData.bytes
            let decrypted = try AES(key: key, blockMode: CTR.init(iv: iv), padding: .pkcs7).decrypt(encryptedText)
            return Data(decrypted)

            
        }
        catch{
            print(error)
        }
        return Data()
    }
}
extension String
{
    func isEmpty() -> Bool {
        return  self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }   
}
