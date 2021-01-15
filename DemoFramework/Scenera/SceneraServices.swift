//
//  SceneraServices.swift
//  DemoFramework
//
//  Created by MacPro3 on 15/01/21.
//

import Foundation

var arrNodes:[Node]? = []
var listOfNICEItemTypes:[String]! = []
var continuesToken:String = ""
var arrScenesDate:[Date] = []
var arrScenes:[SceneMarkList] = []
func getNodes()  {
    Utility.showLoading()
    let dictParam:[String:Any] = [PARAMS.ACCOUNTID:preferenceHelper.getAccountId()]
    let dictHeader:[String:String] = [PARAMS.AUTHORIZATION: (preferenceHelper.getAppControlObject()!.payload?.dataEndPoints![0].netEndPoint?.scheme![0].accessToken)!,PARAMS.ACCEPT:"application/json",PARAMS.CONTENTTYPE:"application/json"]
    let afh:AlamofireHelper = AlamofireHelper.init()
    afh.getResponseFromURL(url: "https://" + ((preferenceHelper.getAppControlObject()!.payload?.controlEndPoints)![0].netEndPoint?.scheme)![0].authority! + "/" + preferenceHelper.getApiVersion() + "/" + preferenceHelper.getEndPointId() + WebServices.GET_NODES, methodName: AlamofireHelper.POST_METHOD, paramData: dictParam, dictHeader: dictHeader) {  (data,response, error) -> (Void) in
        Utility.hideLoading()
        arrNodes?.removeAll()
        print(data)
        do {
            
            let decoder = JSONDecoder()
            
            let objNodeResponseModel = try decoder.decode(NodeResponseModel.self, from: data)
            arrNodes = objNodeResponseModel.nodeList
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
func getNICEItemTypes()
{
    Utility.showLoading()
    let afh:AlamofireHelper = AlamofireHelper.init()
    Utility.showLoading()
    let url = HTTP_PROTOCOL + ((preferenceHelper.getAppControlObject()!.payload?.dataEndPoints)![0].netEndPoint?.scheme)![0].authority! + "/" + preferenceHelper.getApiVersion() + "/"  + WebServices.GET_NICE_ITEM_TYPES
    let dictHeader:[String:String] = [PARAMS.AUTHORIZATION: (preferenceHelper.getAppControlObject()!.payload?.dataEndPoints![0].netEndPoint?.scheme![0].accessToken)!,PARAMS.ACCEPT:"application/json",PARAMS.CONTENTTYPE:"application/json"]
    print(dictHeader)
    afh.getResponseFromURL(url:url, methodName: AlamofireHelper.GET_METHOD, paramData: nil, dictHeader: dictHeader) {  (data,response, error) -> (Void) in
        Utility.hideLoading()
        listOfNICEItemTypes.removeAll()
        listOfNICEItemTypes = response as? [String] ?? []
        
    }
}
func getSceneMark(nodeIds:[String],startTime:String = Utility.dateToString(date: Date.init(timeIntervalSince1970: 0), withFormat: DATE_CONSTANT.DATE_TIME_FORMAT_WEB),endTime:String = Utility.dateToString(date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, withFormat: DATE_CONSTANT.DATE_TIME_FORMAT_WEB),niceItemTypes:[String],pageLength:Int = 10,isReturnPage:Bool = true,isReturnSceneMarkList:Bool = true,isReturnNICEItemTypes:Bool = true,isReturnSceneMarkDates:Bool = true)  {
    
    let afh:AlamofireHelper = AlamofireHelper.init()
    
    var  jsonDict:[String:Any] = [
        PARAMS.NODEIDS:nodeIds,
        PARAMS.STARTTIME:startTime,
        PARAMS.ENDTIME:endTime,
        PARAMS.NICEITEMTYPES:niceItemTypes,
        PARAMS.PAGELENGTH:pageLength,
        PARAMS.RETURNPAGE:isReturnPage,
        PARAMS.RETURNSCENEMARKLIST:isReturnSceneMarkList,
        PARAMS.RETURNNICEITEMTYPES:isReturnNICEItemTypes,
        PARAMS.RETURNSCENEMARKDATES:isReturnSceneMarkDates]
    
    if !continuesToken.isEmpty()
    {
        jsonDict[PARAMS.CONTINUATIONTOKEN] = continuesToken
        
    }else{
        Utility.showLoading()
    }
    let url = HTTP_PROTOCOL + ((preferenceHelper.getAppControlObject()!.payload?.dataEndPoints)![0].netEndPoint?.scheme)![0].authority! + "/" + preferenceHelper.getApiVersion() + "/"   +  preferenceHelper.getAppInstanceId() +  WebServices.GET_SCENE_MARK_MANIFEST
    let dictHeader:[String:String] = [PARAMS.AUTHORIZATION: (preferenceHelper.getAppControlObject()!.payload?.dataEndPoints![0].netEndPoint?.scheme![0].accessToken)!,PARAMS.ACCEPT:"application/json",PARAMS.CONTENTTYPE:"application/json"]
    
    afh.getResponseFromURL(url:url, methodName: AlamofireHelper.POST_METHOD, paramData: jsonDict, dictHeader: dictHeader) {  (data,response, error) -> (Void) in
        
        Utility.hideLoading()
        arrScenesDate.removeAll()
        
        do {
            let decoder = JSONDecoder()
            let objSceneMarkResponse = try decoder.decode(SceneMarkResponse.self, from: data)
            if objSceneMarkResponse.listDates?.count ?? 0 > 0 {
                for date in objSceneMarkResponse.listDates!
                {
                    arrScenesDate.append(Utility.stringToDate(strDate: date, withFormat: DATE_CONSTANT.DATE_FORMAT))
                }
            }
            continuesToken = objSceneMarkResponse.continuationToken ?? ""
            if arrScenes.count == 0 && objSceneMarkResponse.sceneMarkList?.count == 0{
                //                Utility.showToast(message: "MSG_NO_SCENEMARK_AVAILABLE".localized,view: self.parent?.parent?.view)
            }
            else{
                if objSceneMarkResponse.sceneMarkList?.count ?? 0 > 0{
                    arrScenes.append(contentsOf: objSceneMarkResponse.sceneMarkList!)
                    arrScenes = arrScenes.sorted(by: {  $0.dateFromDateTimeStamp!.compare(($1.dateFromDateTimeStamp)!) == .orderedDescending })
                    
                    if preferenceHelper.getSceneEncryptionKey() != nil {
                        
                    }
                    else{
                        // Check if scenemark list co
                        let objSceneMark = arrScenes.first(where: {$0.sceneDataThumbnail?.encryptionOn ?? false})
                        getPrivacyObject(EncryptionkeyId: objSceneMark?.sceneDataThumbnail?.sceneEncryptionKeyID ?? "")
                    }
                }
            }
            
        } catch let error as NSError {
            
            print(error)
        }
        
    }
    
}
func getPrivacyObject(EncryptionkeyId:String)  {
    let body:[String:Any] = [PARAMS.VERSION:preferenceHelper.getApiVersion(),PARAMS.SCENEENCRYPTIONKEYID:EncryptionkeyId]
    let payload:[String:Any] = [PARAMS.BODY:body]
    let dictParam:[String:Any] =
        [PARAMS.VERSION:preferenceHelper.getApiVersion(),
         PARAMS.MESSAGETYPE:"request",
         PARAMS.SOURCEENDPOINTID:preferenceHelper.getAppInstanceId(),
         PARAMS.DESTINATIONENDPOINTID:preferenceHelper.getEndPointId(),
         PARAMS.COMMANDID:11,
         PARAMS.COMMANDTYPE:"/1.0/00000001-5cdd-280b-8003-000100000001/management/GetPrivacyObject",
         PARAMS.DATETIMESTAMP:Utility.dateToString(date: Date(), withFormat: DATE_CONSTANT.DATE_TIME_FORMAT_WEB),
         PARAMS.ENCRYPTIONON:true,
         PARAMS.PAYLOAD:payload
    ]
    let afh:AlamofireHelper = AlamofireHelper.init()
    let dictHeader:[String:String] = [PARAMS.AUTHORIZATION: (preferenceHelper.getAppControlObject()!.payload?.dataEndPoints![0].netEndPoint?.scheme![0].accessToken)!,PARAMS.ACCEPT:"application/json",PARAMS.CONTENTTYPE:"application/json"]
    Utility.showLoading()
    afh.getResponseFromURL(url:HTTP_PROTOCOL + ((preferenceHelper.getAppControlObject()!.payload?.controlEndPoints)![0].netEndPoint?.scheme)![0].authority! + "/" + preferenceHelper.getApiVersion() + "/" + preferenceHelper.getEndPointId() + WebServices.GET_PRIVACY_OBJECT, methodName: AlamofireHelper.POST_METHOD, paramData: dictParam, dictHeader: dictHeader) {  (data,response, error) -> (Void) in
        Utility.hideLoading()
        do {
            
            let decoder = JSONDecoder()
            let privacyObjectResponse = try decoder.decode(PrivacyObjectResponse.self, from: data)
            if privacyObjectResponse.payload?.sceneEncryptionKey != nil {
                    //Storing SceneEncryptionKey
                preferenceHelper.setSceneEncryptionKey(((privacyObjectResponse.payload?.sceneEncryptionKey)!))
            }
            
            
        }catch {
            print(error.localizedDescription)
        }
    }
}
func getSceneData(URI:String)
{
    let afh:AlamofireHelper = AlamofireHelper.init()
    let dictHeader:[String:String] = [PARAMS.AUTHORIZATION: (preferenceHelper.getAppControlObject()!.payload?.dataEndPoints![0].netEndPoint?.scheme![0].accessToken)!,PARAMS.ACCEPT:"application/json",PARAMS.CONTENTTYPE:"application/json"]
    afh.getResponseFromURL(url: URI, methodName: AlamofireHelper.GET_METHOD, paramData: [:], dictHeader: dictHeader) {  (data,response, error) -> (Void) in
        
        do {
            
            let decoder = JSONDecoder()
            let objSceneMarkURIResponse = try decoder.decode(SceneMarkURIResponse.self, from: data)
//            self.selectedScenes = objSceneMarkURIResponse
//            if  self.objUserDetail!.sceneMarkId.firstIndex(where: {$0.compare(self.selectedScenes!.sceneMarkID!) == ComparisonResult.orderedSame}) == nil
//            {
//                self.objUserDetail?.sceneMarkId.append(self.selectedScenes!.sceneMarkID!)
//                preferenceHelper.setUserPreference(self.objUserDetail!)
//            }
//            self.clearDiskCache()
//            for detectedObj in (self.selectedScenes?.detectedObjects)!
//            {
//                for sceneId in detectedObj.relatedSceneData!
//                {
//                    for scene in (self.selectedScenes?.sceneDataList)!
//                    {
//                        if scene.sceneDataID?.compare(sceneId) == ComparisonResult.orderedSame{
//                            if scene.dataType?.compare("RGBVideo") == ComparisonResult.orderedSame
//                            {
//                                self.writeVideoToFile(urlString: scene.sceneDataURI ?? "")
//                                break;
//                            }
//                        }
//                    }
//                }
//            }
            
//                if preferenceHelper.getSceneEncryptionKey() != nil {
                
//                    self.tblVw.reloadData()
//                }
//                else{
                
//                    let objSceneMark = self.arrScenes.first(where: {$0.sceneDataList!.first(where: {($0.encryption?.encryptionOn!)!}) != nil})
//                    if let objSceneDataList:SceneDataList = objSceneMark?.sceneDataList?.first(where: {($0.encryption?.encryptionOn!)!})
//                    {
//                        self.wsGetPrivacyObject(EncryptionkeyId: (objSceneDataList.encryption?.sceneEncryptionKeyID)!)
//                    }
//                    self.tblVw.reloadData()
//                }

        } catch {
            print(error.localizedDescription)
        }
        
    }
}
