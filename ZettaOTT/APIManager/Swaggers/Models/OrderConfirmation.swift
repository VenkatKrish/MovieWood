import Foundation
public struct OrderConfirmation : Codable {
	let movieOrderId : Int64?
	let orderNo : String?
	let orderType : String?
	let subscriptionId : Int64?
	let movieId : Int64?
	let userId : Int64?
	let bookingStartTime : String?
	let bookingEndTime : String?
	let unitPrice : Double?
	let orderQuantity : Int?
	let uom : String?
	let discountPercentage : String?
	let discountType : String?
	let couponCode : String?
	let discountValue : String?
	let totalOrderValue : Double?
	let taxPercentage : Double?
	let totalTaxValue : Double?
	let totalRoundedValue : Double?
	let orderDate : String?
	let orderRemarks : String?
	let paymentStatus : String?
	let paidAmount : Double?
	let paymentDate : String?
	let paymentTransactionNo : String?
	let paymentMode : String?
	let orderSource : String?
	let orderCountry : String?
	let functionalCurrencyCode : String?
	let transactionCurrencyCode : String?
	let conversionType : String?
	let latitude : String?
	let longitude : String?
	let createdBy : String?
	let createdOn : String?
	let modifiedBy : String?
	let modifiedOn : String?
	let lastUpdateLogin : String?
	let versionNumber : String?
	let capturedStatus : String?
	let orderMovie : String?

	enum CodingKeys: String, CodingKey {

		case movieOrderId = "movieOrderId"
		case orderNo = "orderNo"
		case orderType = "orderType"
		case subscriptionId = "subscriptionId"
		case movieId = "movieId"
		case userId = "userId"
		case bookingStartTime = "bookingStartTime"
		case bookingEndTime = "bookingEndTime"
		case unitPrice = "unitPrice"
		case orderQuantity = "orderQuantity"
		case uom = "uom"
		case discountPercentage = "discountPercentage"
		case discountType = "discountType"
		case couponCode = "couponCode"
		case discountValue = "discountValue"
		case totalOrderValue = "totalOrderValue"
		case taxPercentage = "taxPercentage"
		case totalTaxValue = "totalTaxValue"
		case totalRoundedValue = "totalRoundedValue"
		case orderDate = "orderDate"
		case orderRemarks = "orderRemarks"
		case paymentStatus = "paymentStatus"
		case paidAmount = "paidAmount"
		case paymentDate = "paymentDate"
		case paymentTransactionNo = "paymentTransactionNo"
		case paymentMode = "paymentMode"
		case orderSource = "orderSource"
		case orderCountry = "orderCountry"
		case functionalCurrencyCode = "functionalCurrencyCode"
		case transactionCurrencyCode = "transactionCurrencyCode"
		case conversionType = "conversionType"
		case latitude = "latitude"
		case longitude = "longitude"
		case createdBy = "createdBy"
		case createdOn = "createdOn"
		case modifiedBy = "modifiedBy"
		case modifiedOn = "modifiedOn"
		case lastUpdateLogin = "lastUpdateLogin"
		case versionNumber = "versionNumber"
		case capturedStatus = "capturedStatus"
		case orderMovie = "orderMovie"
	}

    public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		movieOrderId = try values.decodeIfPresent(Int64.self, forKey: .movieOrderId)
		orderNo = try values.decodeIfPresent(String.self, forKey: .orderNo)
		orderType = try values.decodeIfPresent(String.self, forKey: .orderType)
		subscriptionId = try values.decodeIfPresent(Int64.self, forKey: .subscriptionId)
		movieId = try values.decodeIfPresent(Int64.self, forKey: .movieId)
		userId = try values.decodeIfPresent(Int64.self, forKey: .userId)
		bookingStartTime = try values.decodeIfPresent(String.self, forKey: .bookingStartTime)
		bookingEndTime = try values.decodeIfPresent(String.self, forKey: .bookingEndTime)
		unitPrice = try values.decodeIfPresent(Double.self, forKey: .unitPrice)
		orderQuantity = try values.decodeIfPresent(Int.self, forKey: .orderQuantity)
		uom = try values.decodeIfPresent(String.self, forKey: .uom)
		discountPercentage = try values.decodeIfPresent(String.self, forKey: .discountPercentage)
		discountType = try values.decodeIfPresent(String.self, forKey: .discountType)
		couponCode = try values.decodeIfPresent(String.self, forKey: .couponCode)
		discountValue = try values.decodeIfPresent(String.self, forKey: .discountValue)
		totalOrderValue = try values.decodeIfPresent(Double.self, forKey: .totalOrderValue)
		taxPercentage = try values.decodeIfPresent(Double.self, forKey: .taxPercentage)
		totalTaxValue = try values.decodeIfPresent(Double.self, forKey: .totalTaxValue)
		totalRoundedValue = try values.decodeIfPresent(Double.self, forKey: .totalRoundedValue)
		orderDate = try values.decodeIfPresent(String.self, forKey: .orderDate)
		orderRemarks = try values.decodeIfPresent(String.self, forKey: .orderRemarks)
		paymentStatus = try values.decodeIfPresent(String.self, forKey: .paymentStatus)
		paidAmount = try values.decodeIfPresent(Double.self, forKey: .paidAmount)
		paymentDate = try values.decodeIfPresent(String.self, forKey: .paymentDate)
		paymentTransactionNo = try values.decodeIfPresent(String.self, forKey: .paymentTransactionNo)
		paymentMode = try values.decodeIfPresent(String.self, forKey: .paymentMode)
		orderSource = try values.decodeIfPresent(String.self, forKey: .orderSource)
		orderCountry = try values.decodeIfPresent(String.self, forKey: .orderCountry)
		functionalCurrencyCode = try values.decodeIfPresent(String.self, forKey: .functionalCurrencyCode)
		transactionCurrencyCode = try values.decodeIfPresent(String.self, forKey: .transactionCurrencyCode)
		conversionType = try values.decodeIfPresent(String.self, forKey: .conversionType)
		latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
		createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
		createdOn = try values.decodeIfPresent(String.self, forKey: .createdOn)
		modifiedBy = try values.decodeIfPresent(String.self, forKey: .modifiedBy)
		modifiedOn = try values.decodeIfPresent(String.self, forKey: .modifiedOn)
		lastUpdateLogin = try values.decodeIfPresent(String.self, forKey: .lastUpdateLogin)
		versionNumber = try values.decodeIfPresent(String.self, forKey: .versionNumber)
		capturedStatus = try values.decodeIfPresent(String.self, forKey: .capturedStatus)
		orderMovie = try values.decodeIfPresent(String.self, forKey: .orderMovie)
	}

}
