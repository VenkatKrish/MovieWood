//
// LanguageControllerAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class LanguageControllerAPI {
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
    open class func allPublicUsingGET1(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageLanguages?,_ error: Error?) -> Void)) {
        allPublicUsingGET1WithRequestBuilder(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     allPublic
     - GET /api/v1/public/getalllanguages
     - examples: [{output=none}]
     
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)

     - returns: RequestBuilder<PageLanguages> 
     */
    open class func allPublicUsingGET1WithRequestBuilder(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil) -> RequestBuilder<PageLanguages> {
        let path = "/api/v1/public/getalllanguages"
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

        let requestBuilder: RequestBuilder<PageLanguages>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

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
    open class func allUsingGET7(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageLanguages?,_ error: Error?) -> Void)) {
        allUsingGET7WithRequestBuilder(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     all
     - GET /api/v1/getalllanguages
     - examples: [{output=none}]
     
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)

     - returns: RequestBuilder<PageLanguages> 
     */
    open class func allUsingGET7WithRequestBuilder(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil) -> RequestBuilder<PageLanguages> {
        let path = "/api/v1/getalllanguages"
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

        let requestBuilder: RequestBuilder<PageLanguages>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     deleteLanguage
     
     - parameter languageId: (path) languageId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteLanguageUsingDELETE(languageId: Int64, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        deleteLanguageUsingDELETEWithRequestBuilder(languageId: languageId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     deleteLanguage
     - DELETE /api/v1/languages/{languageId}
     - examples: [{output=none}]
     
     - parameter languageId: (path) languageId 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func deleteLanguageUsingDELETEWithRequestBuilder(languageId: Int64) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/languages/{languageId}"
        let languageIdPreEscape = "\(languageId)"
        let languageIdPostEscape = languageIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{languageId}", with: languageIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     getLanguage
     
     - parameter languageId: (path) languageId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getLanguageUsingGET(languageId: Int64, completion: @escaping ((_ data: Languages?,_ error: Error?) -> Void)) {
        getLanguageUsingGETWithRequestBuilder(languageId: languageId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     getLanguage
     - GET /api/v1/languages/{languageId}
     - examples: [{output=none}]
     
     - parameter languageId: (path) languageId 

     - returns: RequestBuilder<Languages> 
     */
    open class func getLanguageUsingGETWithRequestBuilder(languageId: Int64) -> RequestBuilder<Languages> {
        var path = "/api/v1/languages/{languageId}"
        let languageIdPreEscape = "\(languageId)"
        let languageIdPostEscape = languageIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{languageId}", with: languageIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<Languages>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     saveLanguage
     
     - parameter language: (body) language 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func saveLanguageUsingPOST(language: Languages, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        saveLanguageUsingPOSTWithRequestBuilder(language: language).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     saveLanguage
     - POST /api/v1/languages
     - examples: [{output=none}]
     
     - parameter language: (body) language 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func saveLanguageUsingPOSTWithRequestBuilder(language: Languages) -> RequestBuilder<JSONValue> {
        let path = "/api/v1/languages"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: language)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     updateGenre
     
     - parameter language: (body) language 
     - parameter languageId: (path) languageId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateGenreUsingPUT1(language: Languages, languageId: Int64, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        updateGenreUsingPUT1WithRequestBuilder(language: language, languageId: languageId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     updateGenre
     - PUT /api/v1/languages/{languageId}
     - examples: [{output=none}]
     
     - parameter language: (body) language 
     - parameter languageId: (path) languageId 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func updateGenreUsingPUT1WithRequestBuilder(language: Languages, languageId: Int64) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/languages/{languageId}"
        let languageIdPreEscape = "\(languageId)"
        let languageIdPostEscape = languageIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{languageId}", with: languageIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: language)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
