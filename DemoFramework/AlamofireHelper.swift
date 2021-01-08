//
//  AlamofireHelper.swift
//  FrameworkDemo
//
//  Created by MacPro3 on 23/12/20.
//

import UIKit
import Alamofire

typealias voidRequestCompletionBlock = (_ data:Data,_ response:Any?,_ error:Any?) -> (Void)

class AlamofireHelper: NSObject {
    static let POST_METHOD = "POST"
    static let GET_METHOD = "GET"
    static let PUT_METHOD = "PUT"
    
    var dataBlock:voidRequestCompletionBlock={_,_,_ in}
    private lazy var alamoFireManager: Session? = {
    
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 1000
        configuration.timeoutIntervalForResource = 1000        
        if !(((preferenceHelper.getAppControlObject()?.payload?.controlEndPoints)?[0].netEndPoint?.scheme)?[0].authority ?? "").isEmpty()
        {
            let serverTrustManager: [String: ServerTrustEvaluating] = [

                ((preferenceHelper.getAppControlObject()!.payload?.controlEndPoints)![0].netEndPoint?.scheme)![0].authority!: DisabledTrustEvaluator(),
                ((preferenceHelper.getAppControlObject()!.payload?.dataEndPoints)![0].netEndPoint?.scheme)![0].authority! : DisabledTrustEvaluator(),

                  ]
            let alamoFireManager = Session(configuration: configuration,serverTrustManager: ServerTrustManager.init(evaluators: serverTrustManager))
            return alamoFireManager
        }
        let serverTrustManager: [String: ServerTrustEvaluating] = [authorityForAppControlObj:DisabledTrustEvaluator()]
        let alamoFireManager = Session(configuration: configuration,serverTrustManager: ServerTrustManager.init(evaluators: serverTrustManager),redirectHandler:Redirector.init(behavior: .follow))
        
        
        
        return alamoFireManager
        
        
        
        
    }()
    func getResponseFromURL(url : String,methodName : String,paramData : Dictionary<String, Any>? , dictHeader : Dictionary<String, String>? ,block:@escaping voidRequestCompletionBlock) {
        self.dataBlock = block
        let urlString:String! = url
      
        
        if (methodName == AlamofireHelper.POST_METHOD) {

            let header: HTTPHeaders = HTTPHeaders.init(dictHeader!)
            
            alamoFireManager?.request(urlString, method: .post, parameters: paramData, encoding:JSONEncoding.default, headers: header).responseJSON {
                (response:AFDataResponse<Any>) in
                
                if self.isRequestSuccess(response: response) {
                    
                    switch(response.result) {
                    case .success(_):
                        if response.value != nil {
                            
                            print("Url : - \(String(describing: response.request?.urlRequest)) \n parameters :- \(String(describing: paramData)) \n  Response \(response.value)")
                            
                            do {
                                let data:Data = try JSONSerialization.data(withJSONObject: response.value as? [String:Any] ?? [:], options: .prettyPrinted)
                                self.dataBlock(data,response.value,nil)
                            }catch
                            {
                                let data:Data = Data()
                                self.dataBlock(data,response.value,nil)
                            }
                            
                        }
                        break
                        
                    case .failure(_):
                        
                        if response.error != nil {
                            let data:Data = Data()
                            self.dataBlock(data,response.value,response.error!)
                            
                        }
                        break
                    }
                }else {
                    let data:Data = Data()
                    self.dataBlock(data,response.value,response.error!)
                    Utility.hideLoading()
                }
            }
        }else if(methodName == AlamofireHelper.GET_METHOD) {
            let header: HTTPHeaders = HTTPHeaders.init(dictHeader!)
            alamoFireManager?.request(urlString,headers: header).responseJSON(completionHandler: { (response:AFDataResponse<Any>) in
                
                if self.isRequestSuccess(response: response) {
                    switch(response.result) {
                    case .success(_):
                        if response.value != nil {
                            
                            do {
                                print("Url : - \(String(describing: response.request?.urlRequest)) \n parameters :- \(String(describing: paramData)) \n  Response \(response.value)")

                                let data = try JSONSerialization.data(withJSONObject: response.value as? [String:Any] ?? [:], options: .prettyPrinted)
                                self.dataBlock(data,response.value,nil)
                            }catch
                            {
                                let data:Data = Data()
                                self.dataBlock(data,response.value,nil)
                            }
                        }
                        break
                    case .failure(_):
                        if response.error != nil {
                            let data:Data = Data()
                            self.dataBlock(data,response.value,response.error!)
                        }
                        break
                    }
                }else {
                    Utility.hideLoading()
                     let data:Data = Data()
                     self.dataBlock(data,response.value,response.error!)
                }
            })
        }
    }
    open func hello(){
         debugPrint("Hello from AlamoWater!")
        
    }
    func isRequestSuccess(response:AFDataResponse<Any>) -> Bool {
        var statusCode = response.response?.statusCode
        
        if let error = response.error {
            Utility.hideLoading()
            print(response.response?.url)
            print(statusCode)
            let status = "HTTP_ERROR_CODE_" + String(statusCode ?? 0)
            print(status)
//            Utility.showToast(message: status.localized)
            statusCode = error._code
            return false
        }
        else {
            return true
        }
        
    }
}
