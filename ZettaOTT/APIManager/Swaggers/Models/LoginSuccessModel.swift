import Foundation
public struct LoginSuccessModel : Codable {
	let success : Bool?
	let token : String?
	let refreshtoken : String?
	let userId : Int?
	let username : String?
	let firstName : String?
	let lastName : String?
	let gender : String?
	let email : String?
	let userImagePath : String?
	let mobile : Int64?
	let mobileOtp : Int64?
	let emailOtp : Int64?
	let firstLogin : String?

	enum CodingKeys: String, CodingKey {

		case success = "success"
		case token = "token"
		case refreshtoken = "refreshtoken"
		case userId = "userId"
		case username = "username"
		case firstName = "firstName"
		case lastName = "lastName"
		case gender = "gender"
		case email = "email"
		case userImagePath = "userImagePath"
		case mobile = "mobile"
		case mobileOtp = "mobileOtp"
		case emailOtp = "emailOtp"
		case firstLogin = "firstLogin"
	}

    public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		success = try values.decodeIfPresent(Bool.self, forKey: .success)
		token = try values.decodeIfPresent(String.self, forKey: .token)
		refreshtoken = try values.decodeIfPresent(String.self, forKey: .refreshtoken)
		userId = try values.decodeIfPresent(Int.self, forKey: .userId)
		username = try values.decodeIfPresent(String.self, forKey: .username)
		firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
		lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
		gender = try values.decodeIfPresent(String.self, forKey: .gender)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		userImagePath = try values.decodeIfPresent(String.self, forKey: .userImagePath)
		mobile = try values.decodeIfPresent(Int64.self, forKey: .mobile)
		mobileOtp = try values.decodeIfPresent(Int64.self, forKey: .mobileOtp)
		emailOtp = try values.decodeIfPresent(Int64.self, forKey: .emailOtp)
		firstLogin = try values.decodeIfPresent(String.self, forKey: .firstLogin)
	}

}
