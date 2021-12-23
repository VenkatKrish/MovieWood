import Foundation
public struct AppUserModel : Codable {
	let active : String?
	let address1 : String?
	let address2 : String?
	let age : Int?
	let city : String?
	let confirmPassword : String?
	let country : Int?
	let countryCode : String?
	let createdBy : String?
	let createdOn : String?
	let deviceToken : String?
	let district : Int?
	let emailId : String?
	let firstLogin : String?
	let firstName : String?
	let gender : String?
	let jwtToken : String?
	let landmark : String?
	let lastName : String?
	let lastUpdateLogin : String?
	let latitude : String?
	let longitude : String?
	let mobile : Int?
	let modifiedBy : String?
	let modifiedOn : String?
	let otpVerified : String?
	let password : String?
	let pincode : Int?
	let primeUser : String?
	let roles : [Roles]?
	let securityAnswer : String?
	let securityQuestion : String?
	let userId : Int64?
	let userImage : UserImage?
	let userImageName : String?
	let userImagePath : String?
	let userImageType : String?
	let userIp : String?
	let userLocation : String?
	let userState : Int?
	let userTimezone : String?
	let userType : String?
	let username : String?
	let versionNumber : Int?

	enum CodingKeys: String, CodingKey {

		case active = "active"
		case address1 = "address1"
		case address2 = "address2"
		case age = "age"
		case city = "city"
		case confirmPassword = "confirmPassword"
		case country = "country"
		case countryCode = "countryCode"
		case createdBy = "createdBy"
		case createdOn = "createdOn"
		case deviceToken = "deviceToken"
		case district = "district"
		case emailId = "emailId"
		case firstLogin = "firstLogin"
		case firstName = "firstName"
		case gender = "gender"
		case jwtToken = "jwtToken"
		case landmark = "landmark"
		case lastName = "lastName"
		case lastUpdateLogin = "lastUpdateLogin"
		case latitude = "latitude"
		case longitude = "longitude"
		case mobile = "mobile"
		case modifiedBy = "modifiedBy"
		case modifiedOn = "modifiedOn"
		case otpVerified = "otpVerified"
		case password = "password"
		case pincode = "pincode"
		case primeUser = "primeUser"
		case roles = "roles"
		case securityAnswer = "securityAnswer"
		case securityQuestion = "securityQuestion"
		case userId = "userId"
		case userImage = "userImage"
		case userImageName = "userImageName"
		case userImagePath = "userImagePath"
		case userImageType = "userImageType"
		case userIp = "userIp"
		case userLocation = "userLocation"
		case userState = "userState"
		case userTimezone = "userTimezone"
		case userType = "userType"
		case username = "username"
		case versionNumber = "versionNumber"
	}

    public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		active = try values.decodeIfPresent(String.self, forKey: .active)
		address1 = try values.decodeIfPresent(String.self, forKey: .address1)
		address2 = try values.decodeIfPresent(String.self, forKey: .address2)
		age = try values.decodeIfPresent(Int.self, forKey: .age)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		confirmPassword = try values.decodeIfPresent(String.self, forKey: .confirmPassword)
		country = try values.decodeIfPresent(Int.self, forKey: .country)
		countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
		createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
		createdOn = try values.decodeIfPresent(String.self, forKey: .createdOn)
		deviceToken = try values.decodeIfPresent(String.self, forKey: .deviceToken)
		district = try values.decodeIfPresent(Int.self, forKey: .district)
		emailId = try values.decodeIfPresent(String.self, forKey: .emailId)
		firstLogin = try values.decodeIfPresent(String.self, forKey: .firstLogin)
		firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
		gender = try values.decodeIfPresent(String.self, forKey: .gender)
		jwtToken = try values.decodeIfPresent(String.self, forKey: .jwtToken)
		landmark = try values.decodeIfPresent(String.self, forKey: .landmark)
		lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
		lastUpdateLogin = try values.decodeIfPresent(String.self, forKey: .lastUpdateLogin)
		latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
		mobile = try values.decodeIfPresent(Int.self, forKey: .mobile)
		modifiedBy = try values.decodeIfPresent(String.self, forKey: .modifiedBy)
		modifiedOn = try values.decodeIfPresent(String.self, forKey: .modifiedOn)
		otpVerified = try values.decodeIfPresent(String.self, forKey: .otpVerified)
		password = try values.decodeIfPresent(String.self, forKey: .password)
		pincode = try values.decodeIfPresent(Int.self, forKey: .pincode)
		primeUser = try values.decodeIfPresent(String.self, forKey: .primeUser)
		roles = try values.decodeIfPresent([Roles].self, forKey: .roles)
		securityAnswer = try values.decodeIfPresent(String.self, forKey: .securityAnswer)
		securityQuestion = try values.decodeIfPresent(String.self, forKey: .securityQuestion)
		userId = try values.decodeIfPresent(Int64.self, forKey: .userId)
		userImage = try values.decodeIfPresent(UserImage.self, forKey: .userImage)
		userImageName = try values.decodeIfPresent(String.self, forKey: .userImageName)
		userImagePath = try values.decodeIfPresent(String.self, forKey: .userImagePath)
		userImageType = try values.decodeIfPresent(String.self, forKey: .userImageType)
		userIp = try values.decodeIfPresent(String.self, forKey: .userIp)
		userLocation = try values.decodeIfPresent(String.self, forKey: .userLocation)
		userState = try values.decodeIfPresent(Int.self, forKey: .userState)
		userTimezone = try values.decodeIfPresent(String.self, forKey: .userTimezone)
		userType = try values.decodeIfPresent(String.self, forKey: .userType)
		username = try values.decodeIfPresent(String.self, forKey: .username)
		versionNumber = try values.decodeIfPresent(Int.self, forKey: .versionNumber)
	}

}
