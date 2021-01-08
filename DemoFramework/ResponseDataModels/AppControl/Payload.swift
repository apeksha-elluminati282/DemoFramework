/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Payload : Codable {
	let version : String?
	let appID : String?
	let appInstanceID : String?
	let controlEndPoints : [ControlEndPoints]?
	let dataEndPoints : [DataEndPoints]?
    let notificationEndPoints : [DataEndPoints]?
	enum CodingKeys: String, CodingKey {

		case version = "Version"
		case appID = "AppID"
		case appInstanceID = "AppInstanceID"
		case controlEndPoints = "ControlEndPoints"
		case dataEndPoints = "DataEndPoints"
        case notificationEndPoints = "NotificationEndPoints"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		version = try values.decodeIfPresent(String.self, forKey: .version)
		appID = try values.decodeIfPresent(String.self, forKey: .appID)
		appInstanceID = try values.decodeIfPresent(String.self, forKey: .appInstanceID)
		controlEndPoints = try values.decodeIfPresent([ControlEndPoints].self, forKey: .controlEndPoints)
		dataEndPoints = try values.decodeIfPresent([DataEndPoints].self, forKey: .dataEndPoints)
        notificationEndPoints = try values.decodeIfPresent([DataEndPoints].self, forKey: .notificationEndPoints)
	}

}
