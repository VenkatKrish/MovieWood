//
// MoviePlays.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct MoviePlays: Codable {

    public var country: String?
    public var createdBy: String?
    public var createdOn: Date?
    public var deviceInfo: String?
    public var ipAddress: String?
    public var lastUpdateLogin: String?
    public var modifiedBy: String?
    public var modifiedOn: Date?
    public var movieId: Int64?
    public var moviePlayId: Int64?
    public var operatingSystem: String?
    public var playEndTime: Date?
    public var playSeekTime: Int64?
    public var playStartTime: Date?
    public var timezone: String?
    public var userId: Int64?
    public var versionNumber: Int64?

    public init(country: String?, createdBy: String?, createdOn: Date?, deviceInfo: String?, ipAddress: String?, lastUpdateLogin: String?, modifiedBy: String?, modifiedOn: Date?, movieId: Int64?, moviePlayId: Int64?, operatingSystem: String?, playEndTime: Date?, playSeekTime: Int64?, playStartTime: Date?, timezone: String?, userId: Int64?, versionNumber: Int64?) {
        self.country = country
        self.createdBy = createdBy
        self.createdOn = createdOn
        self.deviceInfo = deviceInfo
        self.ipAddress = ipAddress
        self.lastUpdateLogin = lastUpdateLogin
        self.modifiedBy = modifiedBy
        self.modifiedOn = modifiedOn
        self.movieId = movieId
        self.moviePlayId = moviePlayId
        self.operatingSystem = operatingSystem
        self.playEndTime = playEndTime
        self.playSeekTime = playSeekTime
        self.playStartTime = playStartTime
        self.timezone = timezone
        self.userId = userId
        self.versionNumber = versionNumber
    }


}

