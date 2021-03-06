//
// Channels.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct Channels: Codable {

    public var active: String?
    public var channelDescription: String?
    public var channelId: Int64?
    public var channelImage: String?
    public var channelKey: String?
    public var channelName: String?
    public var createdBy: String?
    public var createdOn: Date?
    public var lastUpdateLogin: String?
    public var modifiedBy: String?
    public var modifiedOn: Date?
    public var user: Users?
    public var userId: Int64?
    public var versionNumber: Int64?

    public init(active: String?, channelDescription: String?, channelId: Int64?, channelImage: String?, channelKey: String?, channelName: String?, createdBy: String?, createdOn: Date?, lastUpdateLogin: String?, modifiedBy: String?, modifiedOn: Date?, user: Users?, userId: Int64?, versionNumber: Int64?) {
        self.active = active
        self.channelDescription = channelDescription
        self.channelId = channelId
        self.channelImage = channelImage
        self.channelKey = channelKey
        self.channelName = channelName
        self.createdBy = createdBy
        self.createdOn = createdOn
        self.lastUpdateLogin = lastUpdateLogin
        self.modifiedBy = modifiedBy
        self.modifiedOn = modifiedOn
        self.user = user
        self.userId = userId
        self.versionNumber = versionNumber
    }


}

