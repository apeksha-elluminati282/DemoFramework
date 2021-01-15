/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
public struct SceneDataList : Codable {
    public let dataType : String?
    public let encryption : Encryption?
    public let mediaFormat : String?
    public let sceneDataID : String?
    public let sceneDataURI : String?
    public let sourceNodeDescription : String?
    public let sourceNodeID : String?
    public let status : String?
    public let timeStamp : String?
    public let dateFromDateTimeStamp: Date?

	enum CodingKeys: String, CodingKey {

		case dataType = "DataType"
		case encryption = "Encryption"
		case mediaFormat = "MediaFormat"
		case sceneDataID = "SceneDataID"
		case sceneDataURI = "SceneDataURI"
		case sourceNodeDescription = "SourceNodeDescription"
		case sourceNodeID = "SourceNodeID"
		case status = "Status"
		case timeStamp = "TimeStamp"
	}

    public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		dataType = try values.decodeIfPresent(String.self, forKey: .dataType)
		encryption = try values.decodeIfPresent(Encryption.self, forKey: .encryption)
        if let mFormat = try? values.decode(Int.self, forKey: .mediaFormat)
        {
            mediaFormat = String(mFormat)
        }
        else{
            mediaFormat = try values.decodeIfPresent(String.self, forKey: .mediaFormat) ?? ""
        }
		sceneDataID = try values.decodeIfPresent(String.self, forKey: .sceneDataID)
		sceneDataURI = try values.decodeIfPresent(String.self, forKey: .sceneDataURI)
		sourceNodeDescription = try values.decodeIfPresent(String.self, forKey: .sourceNodeDescription)
		sourceNodeID = try values.decodeIfPresent(String.self, forKey: .sourceNodeID)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		timeStamp = try values.decodeIfPresent(String.self, forKey: .timeStamp) ?? ""
        dateFromDateTimeStamp = Utility.stringToDate(strDate: timeStamp!, withFormat: DATE_CONSTANT.DATE_TIME_FORMAT_WEB)

	}

}
