//
// UserManagementAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class UserManagementAPI {
    /**
     Adv Search Users

     - parameter search: (query)  
     - parameter page: (query)  
     - parameter size: (query)  
     - parameter contentType: (header)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func advSearchUsers(search: String, page: Decimal, size: Decimal, contentType: String, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        advSearchUsersWithRequestBuilder(search: search, page: page, size: size, contentType: contentType).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Adv Search Users
     - GET /authentication/api/v1/searchusers
     - 

     - parameter search: (query)  
     - parameter page: (query)  
     - parameter size: (query)  
     - parameter contentType: (header)  

     - returns: RequestBuilder<Void> 
     */
    open class func advSearchUsersWithRequestBuilder(search: String, page: Decimal, size: Decimal, contentType: String) -> RequestBuilder<Void> {
        let path = "/authentication/api/v1/searchusers"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
                        "search": search, 
                        "page": page, 
                        "size": size
        ])
        let nillableHeaders: [String: Any?] = [
                        "Content-Type": contentType
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }
    /**
     Delete Role

     - parameter contentType: (header)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteRole(contentType: String, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        deleteRoleWithRequestBuilder(contentType: contentType).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Delete Role
     - DELETE /authentication/api/v1/role/1
     - 

     - parameter contentType: (header)  

     - returns: RequestBuilder<Void> 
     */
    open class func deleteRoleWithRequestBuilder(contentType: String) -> RequestBuilder<Void> {
        let path = "/authentication/api/v1/role/1"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
                        "Content-Type": contentType
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }
    /**
     Delete User Role

     - parameter contentType: (header)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteUserRole(contentType: String, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        deleteUserRoleWithRequestBuilder(contentType: contentType).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Delete User Role
     - DELETE /authentication/api/v1/user/1/roles/1
     - 

     - parameter contentType: (header)  

     - returns: RequestBuilder<Void> 
     */
    open class func deleteUserRoleWithRequestBuilder(contentType: String) -> RequestBuilder<Void> {
        let path = "/authentication/api/v1/user/1/roles/1"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
                        "Content-Type": contentType
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }
    /**
     Get All Roles

     - parameter contentType: (header)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getAllRoles(contentType: String, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        getAllRolesWithRequestBuilder(contentType: contentType).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Get All Roles
     - GET /authentication/api/v1/getallroles
     - 

     - parameter contentType: (header)  

     - returns: RequestBuilder<Void> 
     */
    open class func getAllRolesWithRequestBuilder(contentType: String) -> RequestBuilder<Void> {
        let path = "/authentication/api/v1/getallroles"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
                        "Content-Type": contentType
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }
    /**
     Get All Users

     - parameter contentType: (header)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getAllUsers(contentType: String, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        getAllUsersWithRequestBuilder(contentType: contentType).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Get All Users
     - GET /authentication/api/v1/getallusers
     - 

     - parameter contentType: (header)  

     - returns: RequestBuilder<Void> 
     */
    open class func getAllUsersWithRequestBuilder(contentType: String) -> RequestBuilder<Void> {
        let path = "/authentication/api/v1/getallusers"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
                        "Content-Type": contentType
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }
    /**
     Get One Role

     - parameter contentType: (header)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getOneRole(contentType: String, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        getOneRoleWithRequestBuilder(contentType: contentType).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Get One Role
     - GET /authentication/api/v1/roles/1
     - 

     - parameter contentType: (header)  

     - returns: RequestBuilder<Void> 
     */
    open class func getOneRoleWithRequestBuilder(contentType: String) -> RequestBuilder<Void> {
        let path = "/authentication/api/v1/roles/1"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
                        "Content-Type": contentType
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }
    /**
     My Profile

     - parameter contentType: (header)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func myProfile(contentType: String, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        myProfileWithRequestBuilder(contentType: contentType).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     My Profile
     - GET /authentication/api/v1/myprofile
     - 

     - parameter contentType: (header)  

     - returns: RequestBuilder<Void> 
     */
    open class func myProfileWithRequestBuilder(contentType: String) -> RequestBuilder<Void> {
        let path = "/authentication/api/v1/myprofile"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
                        "Content-Type": contentType
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }
    /**
     Update Role

     - parameter body: (body)  
     - parameter contentType: (header)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateRole(body: String, contentType: String, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        updateRoleWithRequestBuilder(body: body, contentType: contentType).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Update Role
     - PUT /authentication/api/v1/roles
     - 

     - parameter body: (body)  
     - parameter contentType: (header)  

     - returns: RequestBuilder<Void> 
     */
    open class func updateRoleWithRequestBuilder(body: String, contentType: String) -> RequestBuilder<Void> {
        let path = "/authentication/api/v1/roles"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
                        "Content-Type": contentType
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true, headers: headerParameters)
    }
}
