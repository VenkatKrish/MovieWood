//
// RegisterByPhone.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct RegisterByPhone: Codable {

    public var countryCode: String?
    public var mobileno: Int64?

    public init(countryCode: String?, mobileno: Int64?) {
        self.countryCode = countryCode
        self.mobileno = mobileno
    }


}

