/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
public struct SceneDataThumbnail : Codable {
    public let sceneModeDetectionType : String?
    public let sceneDataThumbnailURI : String?
    public let encryptionOn : Bool?
    public let sceneEncryptionKeyID : String?

	enum CodingKeys: String, CodingKey {

		case sceneModeDetectionType = "SceneModeDetectionType"
		case sceneDataThumbnailURI = "SceneDataThumbnailURI"
		case encryptionOn = "EncryptionOn"
		case sceneEncryptionKeyID = "SceneEncryptionKeyID"
	}

    public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		sceneModeDetectionType = try values.decodeIfPresent(String.self, forKey: .sceneModeDetectionType) ?? ""
		sceneDataThumbnailURI = try values.decodeIfPresent(String.self, forKey: .sceneDataThumbnailURI) ?? ""
		encryptionOn = try values.decodeIfPresent(Bool.self, forKey: .encryptionOn) ?? false
		sceneEncryptionKeyID = try values.decodeIfPresent(String.self, forKey: .sceneEncryptionKeyID) ?? ""
	}

}
