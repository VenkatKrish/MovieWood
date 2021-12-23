
import Foundation
public struct OrderConfirmPayment : Codable {
	let paymentTransactionNo : String?
	let paidAmount : Double?
	let paymentDate : String?
	let paymentStatus : String?
	let orderNo : String?
	let paymentMode : String?

    enum CodingKeys: String, CodingKey {

		case paymentTransactionNo = "paymentTransactionNo"
		case paidAmount = "paidAmount"
		case paymentDate = "paymentDate"
		case paymentStatus = "paymentStatus"
		case orderNo = "orderNo"
		case paymentMode = "paymentMode"
	}

	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		paymentTransactionNo = try values.decodeIfPresent(String.self, forKey: .paymentTransactionNo)
		paidAmount = try values.decodeIfPresent(Double.self, forKey: .paidAmount)
		paymentDate = try values.decodeIfPresent(String.self, forKey: .paymentDate)
		paymentStatus = try values.decodeIfPresent(String.self, forKey: .paymentStatus)
		orderNo = try values.decodeIfPresent(String.self, forKey: .orderNo)
		paymentMode = try values.decodeIfPresent(String.self, forKey: .paymentMode)
	}

}
