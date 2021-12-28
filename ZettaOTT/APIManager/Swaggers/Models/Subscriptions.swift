//
// Subscriptions.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct Subscriptions: Codable {

    public var active: String?
    public var createdBy: String?
    public var createdOn: Date?
    public var _description: String?
    public var _id: Int64?
    public var lastUpdateLogin: String?
    public var modifiedBy: String?
    public var modifiedOn: Date?
    public var name: String?
    public var ordering: Int64?
    public var promoColor: String?
    public var promoLabel: String?
    public var subDuration: Int?
    public var subGroupId: Int64?
    public var subValue: Double?
    public var uom: String?
    public var versionNumber: Int64?
    public var subsKey: String?
    public var subsBackgroundColor: String?
    
    public init(active: String?, createdBy: String?, createdOn: Date?, _description: String?, _id: Int64?, lastUpdateLogin: String?, modifiedBy: String?, modifiedOn: Date?, name: String?, ordering: Int64?, promoColor: String?, promoLabel: String?, subDuration: Int?, subGroupId: Int64?, subValue: Double?, uom: String?, versionNumber: Int64?, subsKey: String?, subsBackgroundColor: String?) {
        self.active = active
        self.createdBy = createdBy
        self.createdOn = createdOn
        self._description = _description
        self._id = _id
        self.lastUpdateLogin = lastUpdateLogin
        self.modifiedBy = modifiedBy
        self.modifiedOn = modifiedOn
        self.name = name
        self.ordering = ordering
        self.promoColor = promoColor
        self.promoLabel = promoLabel
        self.subDuration = subDuration
        self.subGroupId = subGroupId
        self.subValue = subValue
        self.uom = uom
        self.versionNumber = versionNumber
        self.subsKey = subsKey
        self.subsBackgroundColor = subsBackgroundColor
    }

    public enum CodingKeys: String, CodingKey { 
        case active
        case createdBy
        case createdOn
        case _description = "description"
        case _id = "id"
        case lastUpdateLogin
        case modifiedBy
        case modifiedOn
        case name
        case ordering
        case promoColor
        case promoLabel
        case subDuration
        case subGroupId
        case subValue
        case uom
        case versionNumber
        case subsKey
        case subsBackgroundColor
    }
}

