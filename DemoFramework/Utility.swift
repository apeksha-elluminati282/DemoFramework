//
//  Utility.swift
//  DemoFramework
//
//  Created by MacPro3 on 08/01/21.
//

import Foundation
import UIKit

class Utility
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
    static func dateToString(date: Date, withFormat:String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC") ?? TimeZone(identifier: "UTC") ??  TimeZone.ReferenceType.default
        dateFormatter.dateFormat = withFormat
        let currentDate = dateFormatter.string(from: date)
        return currentDate
    }
}
extension String
{
    func isEmpty() -> Bool {
        return  self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }   
}
