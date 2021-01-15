/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
public struct SceneMarkURIResponse : Codable {
	let analysisList : [AnalysisList]?
	let destinationID : String?
	let detectedObjects : [DetectedObjects]?
	let nodeID : String?
	let portID : String?
	let sceneDataList : [SceneDataList]?
	let sceneMarkID : String?
	let sceneMarkStatus : String?
	let thumbnailList : [ThumbnailList]?
	let timeStamp : String?
	let version : String?
    var cameraDesc: String?
    
	enum CodingKeys: String, CodingKey {

		case analysisList = "AnalysisList"
		case destinationID = "DestinationID"
		case detectedObjects = "DetectedObjects"
		case nodeID = "NodeID"
		case portID = "PortID"
		case sceneDataList = "SceneDataList"
		case sceneMarkID = "SceneMarkID"
		case sceneMarkStatus = "SceneMarkStatus"
		case thumbnailList = "ThumbnailList"
		case timeStamp = "TimeStamp"
		case version = "Version"
	}

    public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		analysisList = try values.decodeIfPresent([AnalysisList].self, forKey: .analysisList)
		destinationID = try values.decodeIfPresent(String.self, forKey: .destinationID)
		detectedObjects = try values.decodeIfPresent([DetectedObjects].self, forKey: .detectedObjects)
		nodeID = try values.decodeIfPresent(String.self, forKey: .nodeID)
		portID = try values.decodeIfPresent(String.self, forKey: .portID)
		sceneDataList = try values.decodeIfPresent([SceneDataList].self, forKey: .sceneDataList) ?? []
		sceneMarkID = try values.decodeIfPresent(String.self, forKey: .sceneMarkID)
		sceneMarkStatus = try values.decodeIfPresent(String.self, forKey: .sceneMarkStatus)
		thumbnailList = try values.decodeIfPresent([ThumbnailList].self, forKey: .thumbnailList)
		timeStamp = try values.decodeIfPresent(String.self, forKey: .timeStamp) ?? ""
		version = try values.decodeIfPresent(String.self, forKey: .version)
	}

}
