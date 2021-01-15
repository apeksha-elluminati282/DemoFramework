/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
public struct SceneMarkResponse : Codable {
    public let version : String?
    public let startDateTime : String?
    public let endDateTime : String?
    public let pageLength : Int?
    public let nICEItemTypesPresent : [String:Int]?
    public let listDates : [String]?
    public let sceneMarkList : [SceneMarkList]?
    public let continuationToken : String?

	enum CodingKeys: String, CodingKey {

		case version = "Version"
		case startDateTime = "StartDateTime"
		case endDateTime = "EndDateTime"
		case pageLength = "PageLength"
		case nICEItemTypesPresent = "NICEItemTypesPresent"
		case listDates = "ListDates"
		case sceneMarkList = "SceneMarkList"
		case continuationToken = "ContinuationToken"
	}

    public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		version = try values.decodeIfPresent(String.self, forKey: .version)
		startDateTime = try values.decodeIfPresent(String.self, forKey: .startDateTime)
		endDateTime = try values.decodeIfPresent(String.self, forKey: .endDateTime)
		pageLength = try values.decodeIfPresent(Int.self, forKey: .pageLength)
        nICEItemTypesPresent = try values.decodeIfPresent([String:Int].self, forKey: .nICEItemTypesPresent)
		listDates = try values.decodeIfPresent([String].self, forKey: .listDates)
		sceneMarkList = try values.decodeIfPresent([SceneMarkList].self, forKey: .sceneMarkList)
		continuationToken = try values.decodeIfPresent(String.self, forKey: .continuationToken)
	}

}
