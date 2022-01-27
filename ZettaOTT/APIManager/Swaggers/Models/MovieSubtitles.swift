import Foundation
public struct MovieSubtitles : Codable {
	let subtitleId : Int?
	let movieId : Int?
	let name : String?
	let description : String?
	let language : String?
	let subType : String?
	let subUrl : String?
	let ordering : Int?
	let active : String?
	let createdBy : String?
	let createdOn : String?
	let modifiedBy : String?
	let modifiedOn : String?
	let lastUpdateLogin : String?
	let versionNumber : Int?

	enum CodingKeys: String, CodingKey {

		case subtitleId = "subtitleId"
		case movieId = "movieId"
		case name = "name"
		case description = "description"
		case language = "language"
		case subType = "subType"
		case subUrl = "subUrl"
		case ordering = "ordering"
		case active = "active"
		case createdBy = "createdBy"
		case createdOn = "createdOn"
		case modifiedBy = "modifiedBy"
		case modifiedOn = "modifiedOn"
		case lastUpdateLogin = "lastUpdateLogin"
		case versionNumber = "versionNumber"
	}

	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		subtitleId = try values.decodeIfPresent(Int.self, forKey: .subtitleId)
		movieId = try values.decodeIfPresent(Int.self, forKey: .movieId)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		language = try values.decodeIfPresent(String.self, forKey: .language)
		subType = try values.decodeIfPresent(String.self, forKey: .subType)
		subUrl = try values.decodeIfPresent(String.self, forKey: .subUrl)
		ordering = try values.decodeIfPresent(Int.self, forKey: .ordering)
		active = try values.decodeIfPresent(String.self, forKey: .active)
		createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
		createdOn = try values.decodeIfPresent(String.self, forKey: .createdOn)
		modifiedBy = try values.decodeIfPresent(String.self, forKey: .modifiedBy)
		modifiedOn = try values.decodeIfPresent(String.self, forKey: .modifiedOn)
		lastUpdateLogin = try values.decodeIfPresent(String.self, forKey: .lastUpdateLogin)
		versionNumber = try values.decodeIfPresent(Int.self, forKey: .versionNumber)
	}

}
