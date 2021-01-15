/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
public struct SceneMarkList : Codable {
    public let sceneMarkID : String?
    public let sceneMarkURI : String?
    public let timeStamp : String?
    public let sceneDataThumbnail:SceneDataThumbnail?
    public let nodeID : String?
    public let dateFromDateTimeStamp: Date?

	enum CodingKeys: String, CodingKey {

		case sceneMarkID = "SceneMarkID"
		case sceneMarkURI = "SceneMarkURI"
		case timeStamp = "TimeStamp"
        case nodeID = "NodeID"
        case sceneDataThumbnail = "SceneDataThumbnail"
        
	}

    public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		sceneMarkID = try values.decodeIfPresent(String.self, forKey: .sceneMarkID) ?? ""
		sceneMarkURI = try values.decodeIfPresent(String.self, forKey: .sceneMarkURI) ?? ""
		timeStamp = try values.decodeIfPresent(String.self, forKey: .timeStamp) ?? ""
        nodeID = try values.decodeIfPresent(String.self, forKey: .nodeID) ?? ""
        sceneDataThumbnail = try values.decodeIfPresent(SceneDataThumbnail.self, forKey: .sceneDataThumbnail)
        dateFromDateTimeStamp = Utility.stringToDate(strDate: timeStamp!, withFormat: DATE_CONSTANT.DATE_TIME_FORMAT_WEB) 
	}

}
