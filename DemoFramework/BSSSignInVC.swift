//
//  BSSSignInVC.swift
//  DemoFramework
//
//  Created by MacPro3 on 08/01/21.
//

import Foundation
import UIKit
import WebKit
import ECDHESSwift
import JOSESwift

var authorityForAppControlObj:String = ""

public class BSSSignInVC: UIViewController {
    
    // MARK: - User Defined Variables
    
    var privateKey:String = ""
    var webView:WKWebView!
    var activityIndicator: UIActivityIndicatorView!
    var bssProvider:String = ""
    
    // MARK: - ViewController Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        generateKeyPairs()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    // MARK:- Web Serivice Calls
    
    func wsGetAppControlObject(dictParam: [String:Any],url:String)
    {
        let afh:AlamofireHelper = AlamofireHelper.init()
        Utility.showLoading()
        afh.getResponseFromURL(url: url + WebServices.WS_GET_APP_CONTROL_OBJECT, methodName: AlamofireHelper.POST_METHOD, paramData: dictParam, dictHeader: [:]) {  (data,response, error) -> (Void) in
            Utility.hideLoading()
            do {
                let decoder = JSONDecoder()
                let objAppControlObjectResponse = try decoder.decode(AppControlObjectResponse.self, from: data)
                preferenceHelper.setAppControlObject(objAppControlObjectResponse)
                preferenceHelper.setBSSProvider(self.bssProvider)
            
            
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK:- User Defined Function
    func setupLayout()  {
        self.navigationController?.navigationBar.topItem?.title = ""
        webView = WKWebView(frame: self.view.frame)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.isUserInteractionEnabled = true
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        activityIndicator = UIActivityIndicatorView.init(frame: CGRect.init(x: UIScreen.main.bounds.width/2 - 25, y: UIScreen.main.bounds.height/2 - 25, width: 50, height: 50))
        // add activity
        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
            activityIndicator.style = .whiteLarge
            // Fallback on earlier versions
        }
        activityIndicator.color = UIColor.lightGray
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
        self.activityIndicator.hidesWhenStopped = true
    }
    
    func generateKeyPairs()  {
        let keyPair = try! generateECKeyPair(curveType: .P256)

        privateKey = """
        {"crv":"P-256","d":"\(keyPair.parameters["d"]!)","kty":"EC","x":"\(keyPair.getPrivate().x)","y":"\(keyPair.getPrivate().y)"}
        """
        let publicKey = """
        {"crv":"P-256","kty":"EC","x":"\(keyPair.getPublic().x)","y":"\(keyPair.getPublic().y)"}
        """
        let dictPublicKey:String = """
        {"Algorithm":"ECDH-ES+A256KW","EncryptionKey": \(publicKey),"SigningKeyID": "00000002-5cdd-280b-8003-000000000000"}
        """
        let myURLString = WebServices.BSS_SIGN_IN + jsonToBaseString(str: dictPublicKey)!
        let url = URL(string: myURLString)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    func jsonToBaseString (str: String) -> String? {
        return Data(str.utf8).base64EncodedString()
    }
    func processEncryptedPayload(data:Data,strEncryptedPayload:String)  {
        do {

            let decoder = JSONDecoder()
            let objEncryptionHeader = try decoder.decode(EncryptionHeader.self, from: data)
            
            // Create PublicKey that verifies JWS Signature
            var publicKey:SecKey? = nil
            
            // Creating SecCertificate with data get from encrypted payload which is in Der X.509 certificate format
            let certificate = SecCertificateCreateWithData(nil, Data.init(base64Encoded: objEncryptionHeader.x5c![0])! as CFData)
            let policy = SecPolicyCreateBasicX509()
            var trust: SecTrust?
            let status = SecTrustCreateWithCertificates(certificate!, policy, &trust)
            if status == errSecSuccess {

                let key = SecTrustCopyPublicKey(trust!)!;
                publicKey = key
            }

            // Verifies JWS Payload
            let jws = try JWS.init(compactSerialization: strEncryptedPayload.replacingOccurrences(of: "\"", with: ""))
            let verifier = Verifier.init(verifyingAlgorithm: .RS512, publicKey: publicKey!)
            let payload = try jws.validate(using: verifier!).payload
            
            //Creating ECDH-ES JWE compact serialized string and decrypt it using private key(jwk fomate)
            let decryptionJwe = try EcdhEsJwe(compactSerializedString: String(decoding: payload.data(), as: UTF8.self))
            let data = try! decryptionJwe.decrypt(privKeyJwkJson: self.privateKey)

            //Decoding Decripted Payload into AppSecrityObject type
            let objAppSecurity = try decoder.decode(AppSecurityObject.self, from: data)

            //Setting essential data from AppSecurityObject
            preferenceHelper.setAccountId(objAppSecurity.accountID!)
            //preferenceHelper.setAppInstanceId(objSignInResponse.appInstanceID!)
            preferenceHelper.setAppInstanceId("00000001-5e84-224c-8003-000000000065")
            preferenceHelper.setApiVersion((objAppSecurity.nICEASEndPoint?.appEndPoint?.aPIVersion)!)
            authorityForAppControlObj = (objAppSecurity.nICEASEndPoint?.netEndPoint?.scheme)![0].authority!
            preferenceHelper.setEndPointId((objAppSecurity.nICEASEndPoint?.netEndPoint?.endPointID)!)
            
            let dictPayload:[String:String] = ["AppID":objAppSecurity.appID!]

            let dictParam:[String:Any] =
                ["Version":objAppSecurity.version!,
                 "MessageType":"request",
                 "SourceEndPointID":objAppSecurity.appInstanceID!,
                 "DestinationEndPointID":(objAppSecurity.nICEASEndPoint?.netEndPoint?.endPointID)!,
                 "DateTimeStamp":Utility.dateToString(date: Date(), withFormat: DATE_CONSTANT.DATE_TIME_FORMAT_WEB),
                 "CommandID":0,
                 "CommandType":"/1.0/00000000-5eab-2e10-8003-000000000000/management/GetAppControlObject",
                 "Payload":dictPayload]
            
            self.wsGetAppControlObject(dictParam: dictParam,url: HTTP_PROTOCOL + authorityForAppControlObj)

        }
        catch{
            print("ERROR localized descryption: \(error.localizedDescription) \n Error :\(error)")
        }
    }
    
}
extension BSSSignInVC:WKNavigationDelegate
{
    // MARK: - WKNavigationDelegate Delegate Methods
    
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        
        webView.evaluateJavaScript("document.body.textContent") { response, error in
            
            let dict = Utility.convertToDictionary(text: response as! String)
            if dict != nil {
                if dict?["success"] != nil && !(dict?["success"] as? Bool ?? false) {
                    var alert:UIAlertController? = nil
                    if dict?["error"] != nil {
                        alert = UIAlertController(title: "Try Again", message: dict?["error"] as? String,   preferredStyle: .alert)
                    }else{
                        alert = UIAlertController(title: "Try Again", message: dict?["error_message"] as? String,   preferredStyle: .alert)
                    }
                    
                    alert?.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                        //Cancel Action
                    }))
                    
                    self.present(alert!, animated: true, completion: nil)
                }
            }else{
                if let strResponse = response as? String {
                    let strEncryptedPayload = strResponse.replacingOccurrences(of: "\"", with: "")
                    let encryptedPayload = strEncryptedPayload.components(separatedBy: ".")
                    //If the length of string is not multiple of 4,string needed padding with “=“
                    if encryptedPayload.count > 0 {
                        var header    = encryptedPayload[0]
                        let remainder = header.count % 4
                        if remainder > 0 {
                            header = header.padding(toLength: header.count + 4 - remainder,
                                                    withPad: "=",
                                                    startingAt: 0)
                        }
                        
                        if let decodedData = Data(base64Encoded:header)
                        {
                            self.processEncryptedPayload(data:decodedData, strEncryptedPayload: strEncryptedPayload)
                        }
                    }
                }
            }
        }
    }
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}
