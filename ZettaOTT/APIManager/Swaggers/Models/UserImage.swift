import Foundation
struct UserImage : Codable {
	let binaryStream : String?

	enum CodingKeys: String, CodingKey {

		case binaryStream = "binaryStream"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		binaryStream = try values.decodeIfPresent(String.self, forKey: .binaryStream)
	}

}
