//
// NotifyTemplateControllerAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class NotifyTemplateControllerAPI {
    /**
     all
     
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func allUsingGET22(completion: @escaping ((_ data: [NotificationTemplate]?,_ error: Error?) -> Void)) {
        allUsingGET22WithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     all
     - GET /api/v1/getallnotifytemplates
     - examples: [{output=none}]

     - returns: RequestBuilder<[NotificationTemplate]> 
     */
    open class func allUsingGET22WithRequestBuilder() -> RequestBuilder<[NotificationTemplate]> {
        let path = "/api/v1/getallnotifytemplates"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<[NotificationTemplate]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     deleteNotificationTemplate
     
     - parameter notificationTemplateId: (path) notificationTemplateId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteNotificationTemplateUsingDELETE(notificationTemplateId: Int64, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        deleteNotificationTemplateUsingDELETEWithRequestBuilder(notificationTemplateId: notificationTemplateId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     deleteNotificationTemplate
     - DELETE /api/v1/notifytemplates/{notificationTemplateId}
     - examples: [{output=none}]
     
     - parameter notificationTemplateId: (path) notificationTemplateId 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func deleteNotificationTemplateUsingDELETEWithRequestBuilder(notificationTemplateId: Int64) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/notifytemplates/{notificationTemplateId}"
        let notificationTemplateIdPreEscape = "\(notificationTemplateId)"
        let notificationTemplateIdPostEscape = notificationTemplateIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{notificationTemplateId}", with: notificationTemplateIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     saveNotificationTemplate
     
     - parameter notificationTemplate: (body) notificationTemplate 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func saveNotificationTemplateUsingPOST(notificationTemplate: NotificationTemplate, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        saveNotificationTemplateUsingPOSTWithRequestBuilder(notificationTemplate: notificationTemplate).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     saveNotificationTemplate
     - POST /api/v1/notifytemplates
     - examples: [{output=none}]
     
     - parameter notificationTemplate: (body) notificationTemplate 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func saveNotificationTemplateUsingPOSTWithRequestBuilder(notificationTemplate: NotificationTemplate) -> RequestBuilder<JSONValue> {
        let path = "/api/v1/notifytemplates"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: notificationTemplate)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     updateNotificationGroup
     
     - parameter notificationTemplateId: (path) notificationTemplateId 
     - parameter notificationTemplates: (body) notificationTemplates 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateNotificationGroupUsingPUT1(notificationTemplateId: Int64, notificationTemplates: NotificationTemplate, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        updateNotificationGroupUsingPUT1WithRequestBuilder(notificationTemplateId: notificationTemplateId, notificationTemplates: notificationTemplates).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     updateNotificationGroup
     - PUT /api/v1/notifytemplates/{notificationTemplateId}
     - examples: [{output=none}]
     
     - parameter notificationTemplateId: (path) notificationTemplateId 
     - parameter notificationTemplates: (body) notificationTemplates 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func updateNotificationGroupUsingPUT1WithRequestBuilder(notificationTemplateId: Int64, notificationTemplates: NotificationTemplate) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/notifytemplates/{notificationTemplateId}"
        let notificationTemplateIdPreEscape = "\(notificationTemplateId)"
        let notificationTemplateIdPostEscape = notificationTemplateIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{notificationTemplateId}", with: notificationTemplateIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: notificationTemplates)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
