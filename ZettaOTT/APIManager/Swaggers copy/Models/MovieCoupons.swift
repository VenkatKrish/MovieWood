//
// MovieCoupons.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct MovieCoupons: Codable {

    public var active: String?
    public var coupon: Coupons?
    public var couponId: Int64?
    public var createdBy: String?
    public var createdOn: Date?
    public var lastUpdateLogin: String?
    public var modifiedBy: String?
    public var modifiedOn: Date?
    public var movieCouponId: Int64?
    public var movieId: Int64?
    public var versionNumber: Int64?

    public init(active: String?, coupon: Coupons?, couponId: Int64?, createdBy: String?, createdOn: Date?, lastUpdateLogin: String?, modifiedBy: String?, modifiedOn: Date?, movieCouponId: Int64?, movieId: Int64?, versionNumber: Int64?) {
        self.active = active
        self.coupon = coupon
        self.couponId = couponId
        self.createdBy = createdBy
        self.createdOn = createdOn
        self.lastUpdateLogin = lastUpdateLogin
        self.modifiedBy = modifiedBy
        self.modifiedOn = modifiedOn
        self.movieCouponId = movieCouponId
        self.movieId = movieId
        self.versionNumber = versionNumber
    }


}

