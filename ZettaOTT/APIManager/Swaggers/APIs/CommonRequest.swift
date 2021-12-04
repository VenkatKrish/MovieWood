//
//  CommonRequest.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 11/11/21.
//

import Foundation

public struct ValidateOTPRequest: Codable {
    public var otp: Int64?
    public var username: String?

    public init(otp: Int64?, username: String?) {
        self.otp = otp
        self.username = username
    }
}
