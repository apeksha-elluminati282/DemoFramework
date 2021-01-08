/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Scheme : Codable {
	let scheme_protocol : String?
    var accessToken : String?
    var arrAccessToken : [String]?
	let authority : String?
	let role : String?

	enum CodingKeys: String, CodingKey {

		case scheme_protocol = "Protocol"
		case accessToken = "AccessToken"
		case authority = "Authority"
		case role = "Role"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		scheme_protocol = try values.decodeIfPresent(String.self, forKey: .scheme_protocol)
        if let array = try? values.decodeIfPresent([String].self, forKey: .accessToken)
        {
            arrAccessToken = array
        }else{
            accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken) ?? ""
        }
		
		authority = try values.decodeIfPresent(String.self, forKey: .authority)
		role = try values.decodeIfPresent(String.self, forKey: .role)
	}

}
