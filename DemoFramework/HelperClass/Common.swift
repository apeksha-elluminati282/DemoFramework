//
//  Common.swift
//  DemoFramework
//
//  Created by MacPro3 on 08/01/21.
//

import Foundation

var HTTP_PROTOCOL:String = "http://"

struct WebServices {
    
    static let GET_NODES = "/management/GetAccountNode"
    static let WS_GET_APP_CONTROL_OBJECT = "/management/GetAppControlObject?code=c5aCL3d0I7Fk3wW0sXdhX9w6V9NauiyMGXzlzyyk0vt3p21n7UvQrQ=="
    static let BSS_SIGN_IN = "https://bss-webapp.azurewebsites.net/link_app/00000001-5e84-224c-000000000065/"
    static let GET_NICE_ITEM_TYPES = "GetNICEItemTypes"
    static let GET_SCENE_MARK_MANIFEST = "/data/0000/0000/GetSceneMarkManifest"
    static let GET_PRIVACY_OBJECT = "/management/GetPrivacyObject"
}
struct DATE_CONSTANT {
    static let DATE_TIME_FORMAT_WEB  = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    static let DATE_FORMAT = "yyyy-MM-dd"
}
struct PARAMS {
    static let VERSION = "Version"
    static let MESSAGETYPE = "MessageType"
    static let SOURCEENDPOINTID = "SourceEndPointID"
    static let DESTINATIONENDPOINTID = "DestinationEndPointID"
    static let DATETIMESTAMP = "DateTimeStamp"
    static let COMMANDID = "CommandID"
    static let COMMANDTYPE = "CommandType"
    static let PAYLOAD = "Payload"
    static let ACCOUNTID = "AccountID"
    static let AUTHORIZATION = "Authorization"
    static let ACCEPT = "Accept"
    static let CONTENTTYPE = "Content-Type"
    static let CONTINUATIONTOKEN = "ContinuationToken"
    static let NODEIDS = "NodeIDs"
    static let STARTTIME = "StartTime"
    static let ENDTIME = "EndTime"
    static let PAGELENGTH = "PageLength"
    static let RETURNPAGE = "ReturnPage"
    static let NICEITEMTYPES = "ListNICEItemTypes"
    static let RETURNSCENEMARKLIST = "ReturnSceneMarkList"
    static let RETURNSCENEMARKDATES = "ReturnSceneMarkDates"
    static let RETURNNICEITEMTYPES = "ReturnNICEItemTypes"
    static let BODY = "Body"
    static let SCENEENCRYPTIONKEYID = "SceneEncryptionKeyID"
    static let ENCRYPTIONON =  "EncryptionOn"
}
