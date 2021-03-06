//
// FaqGroupsControllerAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class FaqGroupsControllerAPI {
    /**
     allPublic
     
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func allPublicUsingGET1(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageFaqGroups?,_ error: Error?) -> Void)) {
        allPublicUsingGET1WithRequestBuilder(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     allPublic
     - GET /api/v1/public/faqgroups/getall
     - examples: [{output=none}]
     
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)

     - returns: RequestBuilder<PageFaqGroups> 
     */
    open class func allPublicUsingGET1WithRequestBuilder(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil) -> RequestBuilder<PageFaqGroups> {
        let path = "/api/v1/public/faqgroups/getall"
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

        let requestBuilder: RequestBuilder<PageFaqGroups>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

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
    open class func allUsingGET6(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageFaqGroups?,_ error: Error?) -> Void)) {
        allUsingGET6WithRequestBuilder(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     all
     - GET /api/v1/faqgroups/getall
     - examples: [{output=none}]
     
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)

     - returns: RequestBuilder<PageFaqGroups> 
     */
    open class func allUsingGET6WithRequestBuilder(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil) -> RequestBuilder<PageFaqGroups> {
        let path = "/api/v1/faqgroups/getall"
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

        let requestBuilder: RequestBuilder<PageFaqGroups>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     delete
     
     - parameter _id: (path) id 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteUsingDELETE1(_id: Int64, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        deleteUsingDELETE1WithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     delete
     - DELETE /api/v1/faqgroups/{id}
     - examples: [{output=none}]
     
     - parameter _id: (path) id 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func deleteUsingDELETE1WithRequestBuilder(_id: Int64) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/faqgroups/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     getPublicPageBySeoUrl
     
     - parameter groupName: (path) groupName 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getPublicPageBySeoUrlUsingGET(groupName: String, completion: @escaping ((_ data: FaqGroups?,_ error: Error?) -> Void)) {
        getPublicPageBySeoUrlUsingGETWithRequestBuilder(groupName: groupName).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     getPublicPageBySeoUrl
     - GET /api/v1/public/faqgroups/{groupName}
     - examples: [{output=none}]
     
     - parameter groupName: (path) groupName 

     - returns: RequestBuilder<FaqGroups> 
     */
    open class func getPublicPageBySeoUrlUsingGETWithRequestBuilder(groupName: String) -> RequestBuilder<FaqGroups> {
        var path = "/api/v1/public/faqgroups/{groupName}"
        let groupNamePreEscape = "\(groupName)"
        let groupNamePostEscape = groupNamePreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{groupName}", with: groupNamePostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<FaqGroups>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     get
     
     - parameter _id: (path) id 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getUsingGET1(_id: Int64, completion: @escaping ((_ data: FaqGroups?,_ error: Error?) -> Void)) {
        getUsingGET1WithRequestBuilder(_id: _id).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     get
     - GET /api/v1/faqgroups/{id}
     - examples: [{output=none}]
     
     - parameter _id: (path) id 

     - returns: RequestBuilder<FaqGroups> 
     */
    open class func getUsingGET1WithRequestBuilder(_id: Int64) -> RequestBuilder<FaqGroups> {
        var path = "/api/v1/faqgroups/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<FaqGroups>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     save
     
     - parameter rec: (body) rec 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func saveUsingPOST1(rec: FaqGroups, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        saveUsingPOST1WithRequestBuilder(rec: rec).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     save
     - POST /api/v1/faqgroups
     - examples: [{output=none}]
     
     - parameter rec: (body) rec 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func saveUsingPOST1WithRequestBuilder(rec: FaqGroups) -> RequestBuilder<JSONValue> {
        let path = "/api/v1/faqgroups"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: rec)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     update
     
     - parameter _id: (path) id 
     - parameter rec: (body) rec 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateUsingPUT1(_id: Int64, rec: FaqGroups, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        updateUsingPUT1WithRequestBuilder(_id: _id, rec: rec).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     update
     - PUT /api/v1/faqgroups/{id}
     - examples: [{output=none}]
     
     - parameter _id: (path) id 
     - parameter rec: (body) rec 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func updateUsingPUT1WithRequestBuilder(_id: Int64, rec: FaqGroups) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/faqgroups/{id}"
        let _idPreEscape = "\(_id)"
        let _idPostEscape = _idPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{id}", with: _idPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: rec)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
