/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct AppControlObjectResponse : Codable {
	let version : String?
	let messageType : String?
	let sourceEndPointID : String?
	let destinationEndPointID : String?
	let dateTimeStamp : String?
	let replyID : Int?
	let replyStatusCode : Int?
	let replyStatusMessage : String?
	let payload : Payload?

	enum CodingKeys: String, CodingKey {

		case version = "Version"
		case messageType = "MessageType"
		case sourceEndPointID = "SourceEndPointID"
		case destinationEndPointID = "DestinationEndPointID"
		case dateTimeStamp = "DateTimeStamp"
		case replyID = "ReplyID"
		case replyStatusCode = "ReplyStatusCode"
		case replyStatusMessage = "ReplyStatusMessage"
		case payload = "Payload"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		version = try values.decodeIfPresent(String.self, forKey: .version)
		messageType = try values.decodeIfPresent(String.self, forKey: .messageType)
		sourceEndPointID = try values.decodeIfPresent(String.self, forKey: .sourceEndPointID)
		destinationEndPointID = try values.decodeIfPresent(String.self, forKey: .destinationEndPointID)
		dateTimeStamp = try values.decodeIfPresent(String.self, forKey: .dateTimeStamp)
		replyID = try values.decodeIfPresent(Int.self, forKey: .replyID)
		replyStatusCode = try values.decodeIfPresent(Int.self, forKey: .replyStatusCode)
		replyStatusMessage = try values.decodeIfPresent(String.self, forKey: .replyStatusMessage)
		payload = try values.decodeIfPresent(Payload.self, forKey: .payload)
	}

}
