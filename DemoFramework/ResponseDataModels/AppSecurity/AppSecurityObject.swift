/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct AppSecurityObject : Codable {
	let version : String?
	let nICELARootCertificate : String?
	let accountID : String?
	let appID : String?
	let appInstanceCertificate : String?
	let appDeveloperID : String?
	let appInstanceID : String?
	let securityLevel : String?
	let nICEASEndPoint : NICEASEndPoint?

	enum CodingKeys: String, CodingKey {

		case version = "Version"
		case nICELARootCertificate = "NICELARootCertificate"
		case accountID = "AccountID"
		case appID = "AppID"
		case appInstanceCertificate = "AppInstanceCertificate"
		case appDeveloperID = "AppDeveloperID"
		case appInstanceID = "AppInstanceID"
		case securityLevel = "SecurityLevel"
		case nICEASEndPoint = "NICEASEndPoint"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		version = try values.decodeIfPresent(String.self, forKey: .version)
		nICELARootCertificate = try values.decodeIfPresent(String.self, forKey: .nICELARootCertificate)
		accountID = try values.decodeIfPresent(String.self, forKey: .accountID)
		appID = try values.decodeIfPresent(String.self, forKey: .appID)
		appInstanceCertificate = try values.decodeIfPresent(String.self, forKey: .appInstanceCertificate)
		appDeveloperID = try values.decodeIfPresent(String.self, forKey: .appDeveloperID)
		appInstanceID = try values.decodeIfPresent(String.self, forKey: .appInstanceID)
		securityLevel = try values.decodeIfPresent(String.self, forKey: .securityLevel)
		nICEASEndPoint = try values.decodeIfPresent(NICEASEndPoint.self, forKey: .nICEASEndPoint)
	}

}
