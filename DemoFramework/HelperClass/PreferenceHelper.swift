//
//  PreferenceHelper.swift
//  DemoFramework
//
//  Created by MacPro3 on 08/01/21.
//


import UIKit

public let preferenceHelper = PreferenceHelper.preferenceHelper

public class PreferenceHelper: NSObject {
    private let KEY_APP_CONTROL_OBJECT = "appcontrolobject"
    private let API_VERSION = "api_version"
    private let KEY_ACCOUNT_ID = "account_id"
    private let KEY_APP_INSTANCE = "app_instance"
    private let END_POINT_ID = "end_point_id"
    private let KEY_PROVIDER = "bss_provider"
    private let KEY_SCENE_ENCRYPTION_KEY = "scene_encryption_key"
    
    let ph = UserDefaults.standard
    static let preferenceHelper = PreferenceHelper()
    private override init() {
    }
    
    func setAppControlObject(_ obj:AppControlObjectResponse)  {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(obj)
        {
            ph.set(encoded, forKey: KEY_APP_CONTROL_OBJECT)
        }
    }
    public func getAppControlObject() -> AppControlObjectResponse?  {
        if let savedAppControlObject = ph.object(forKey: KEY_APP_CONTROL_OBJECT) as? Data{
            let decoder = JSONDecoder()
            if let objAppControlObject = try? decoder.decode(AppControlObjectResponse.self, from: savedAppControlObject)
            {
                return objAppControlObject
            }
        }
        return nil
    }
    
    func setAccountId(_ accountId:String)
    {
        ph.set(accountId, forKey: KEY_ACCOUNT_ID)
        ph.synchronize()
    }
    public func getAccountId() -> String
    {
        return (ph.value(forKey: KEY_ACCOUNT_ID) as? String) ?? ""
    }
    
    func setAppInstanceId(_ appInstance:String)  {
        ph.set(appInstance, forKey: KEY_APP_INSTANCE)
        ph.synchronize()
    }
    public func getAppInstanceId() -> String {
        return (ph.value(forKey: KEY_APP_INSTANCE) as? String) ?? ""
    }
    
    func setApiVersion(_ version:String)  {
        ph.set(version, forKey: API_VERSION)
        ph.synchronize()
    }
    public func getApiVersion() -> String{
         return (ph.value(forKey: API_VERSION) as? String) ?? ""
    }
    
    func setEndPointId(_ endPoint:String)  {
        ph.set(endPoint, forKey: END_POINT_ID)
        ph.synchronize()
    }
    public func getEndPointId() -> String{
         return (ph.value(forKey: END_POINT_ID) as? String) ?? ""
    }
    
    func setSceneEncryptionKey(_ encryptionKey:SceneEncryptionKey)   {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(encryptionKey)
        {
            ph.set(encoded, forKey: KEY_SCENE_ENCRYPTION_KEY)
        }
    }
    func getSceneEncryptionKey() -> SceneEncryptionKey? {
        if let savedSceneEncryptionKey = ph.object(forKey: KEY_SCENE_ENCRYPTION_KEY) as? Data{
            let decoder = JSONDecoder()
            if let objSceneEncryptionKey = try? decoder.decode(SceneEncryptionKey.self, from: savedSceneEncryptionKey)
            {
                return objSceneEncryptionKey
            }
        }
        return nil
    }
}
