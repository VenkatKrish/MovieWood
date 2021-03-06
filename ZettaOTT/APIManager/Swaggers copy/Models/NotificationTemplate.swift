//
// NotificationTemplate.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct NotificationTemplate: Codable {

    public var active: String?
    public var createdBy: String?
    public var createdOn: Date?
    public var endDate: Date?
    public var lastUpdateLogin: String?
    public var modifiedBy: String?
    public var modifiedOn: Date?
    public var notificationTemplateId: Int64?
    public var startDate: Date?
    public var templateContent: String?
    public var templateName: String?
    public var versionNumber: Int64?

    public init(active: String?, createdBy: String?, createdOn: Date?, endDate: Date?, lastUpdateLogin: String?, modifiedBy: String?, modifiedOn: Date?, notificationTemplateId: Int64?, startDate: Date?, templateContent: String?, templateName: String?, versionNumber: Int64?) {
        self.active = active
        self.createdBy = createdBy
        self.createdOn = createdOn
        self.endDate = endDate
        self.lastUpdateLogin = lastUpdateLogin
        self.modifiedBy = modifiedBy
        self.modifiedOn = modifiedOn
        self.notificationTemplateId = notificationTemplateId
        self.startDate = startDate
        self.templateContent = templateContent
        self.templateName = templateName
        self.versionNumber = versionNumber
    }


}

