//
// RoleControllerAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class RoleControllerAPI {
    /**
     all
     
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func allUsingGET(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageRoles?,_ error: Error?) -> Void)) {
        allUsingGETWithRequestBuilder(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     all
     - GET /api/v1/getallroles
     - examples: [{output=none}]
     
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)

     - returns: RequestBuilder<PageRoles> 
     */
    open class func allUsingGETWithRequestBuilder(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil) -> RequestBuilder<PageRoles> {
        let path = "/api/v1/getallroles"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "offset": offset?.encodeToJSON(), 
            "pageNumber": pageNumber?.encodeToJSON(), 
            "pageSize": pageSize?.encodeToJSON(), 
            "paged": paged, 
            "sort.sorted": sortSorted, 
            "sort.unsorted": sortUnsorted, 
            "unpaged": unpaged
        ])

        let requestBuilder: RequestBuilder<PageRoles>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     deleteRole
     
     - parameter roleId: (path) roleId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteRoleUsingDELETE(roleId: Int64, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        deleteRoleUsingDELETEWithRequestBuilder(roleId: roleId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     deleteRole
     - DELETE /api/v1/user/{userId}/roles/{roleId}
     - examples: [{output=none}]
     
     - parameter roleId: (path) roleId 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func deleteRoleUsingDELETEWithRequestBuilder(roleId: Int64) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/user/{userId}/roles/{roleId}"
        let roleIdPreEscape = "\(roleId)"
        let roleIdPostEscape = roleIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{roleId}", with: roleIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     deleteUserRole
     
     - parameter roleId: (path) roleId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteUserRoleUsingDELETE(roleId: Int64, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        deleteUserRoleUsingDELETEWithRequestBuilder(roleId: roleId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     deleteUserRole
     - DELETE /api/v1/role/{roleId}
     - examples: [{output=none}]
     
     - parameter roleId: (path) roleId 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func deleteUserRoleUsingDELETEWithRequestBuilder(roleId: Int64) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/role/{roleId}"
        let roleIdPreEscape = "\(roleId)"
        let roleIdPostEscape = roleIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{roleId}", with: roleIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     getRole
     
     - parameter roleId: (path) roleId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getRoleUsingGET(roleId: Int64, completion: @escaping ((_ data: Roles?,_ error: Error?) -> Void)) {
        getRoleUsingGETWithRequestBuilder(roleId: roleId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     getRole
     - GET /api/v1/roles/{roleId}
     - examples: [{output=none}]
     
     - parameter roleId: (path) roleId 

     - returns: RequestBuilder<Roles> 
     */
    open class func getRoleUsingGETWithRequestBuilder(roleId: Int64) -> RequestBuilder<Roles> {
        var path = "/api/v1/roles/{roleId}"
        let roleIdPreEscape = "\(roleId)"
        let roleIdPostEscape = roleIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{roleId}", with: roleIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<Roles>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     saveRole
     
     - parameter roles: (body) roles 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func saveRoleUsingPOST(roles: Roles, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        saveRoleUsingPOSTWithRequestBuilder(roles: roles).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     saveRole
     - POST /api/v1/roles
     - examples: [{output=none}]
     
     - parameter roles: (body) roles 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func saveRoleUsingPOSTWithRequestBuilder(roles: Roles) -> RequestBuilder<JSONValue> {
        let path = "/api/v1/roles"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: roles)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     saveUserRole
     
     - parameter roles: (body) roles 
     - parameter userId: (path) userId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func saveUserRoleUsingPOST(roles: UserRoles, userId: Int64, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        saveUserRoleUsingPOSTWithRequestBuilder(roles: roles, userId: userId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     saveUserRole
     - POST /api/v1/user/{userId}/roles
     - examples: [{output=none}]
     
     - parameter roles: (body) roles 
     - parameter userId: (path) userId 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func saveUserRoleUsingPOSTWithRequestBuilder(roles: UserRoles, userId: Int64) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/user/{userId}/roles"
        let userIdPreEscape = "\(userId)"
        let userIdPostEscape = userIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{userId}", with: userIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: roles)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
