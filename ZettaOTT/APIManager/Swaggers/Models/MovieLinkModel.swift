import Foundation
public struct MovieLinkModel : Codable {
	let movieName : String?
	let movieUrl : String?
	let orderNo : String?
	let contentType : String?
    let initialSeekTime : Int64?
    let moviePlayId : Int64?
    let seasonId : Int64?
    let episodeId : Int64?
    let stoken : String?

    public enum CodingKeys: String, CodingKey {

		case movieName = "movieName"
		case movieUrl = "movieUrl"
		case orderNo = "orderNo"
		case contentType = "contentType"
        case initialSeekTime = "initialSeekTime"
        case moviePlayId = "moviePlayId"
        case seasonId = "seasonId"
        case episodeId = "episodeId"
		case stoken = "stoken"
	}

    public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		movieName = try values.decodeIfPresent(String.self, forKey: .movieName)
		movieUrl = try values.decodeIfPresent(String.self, forKey: .movieUrl)
		orderNo = try values.decodeIfPresent(String.self, forKey: .orderNo)
		contentType = try values.decodeIfPresent(String.self, forKey: .contentType)
        initialSeekTime = try values.decodeIfPresent(Int64.self, forKey: .initialSeekTime)
        moviePlayId = try values.decodeIfPresent(Int64.self, forKey: .moviePlayId)
        seasonId = try values.decodeIfPresent(Int64.self, forKey: .seasonId)
        episodeId = try values.decodeIfPresent(Int64.self, forKey: .episodeId)
		stoken = try values.decodeIfPresent(String.self, forKey: .stoken)
	}

}
