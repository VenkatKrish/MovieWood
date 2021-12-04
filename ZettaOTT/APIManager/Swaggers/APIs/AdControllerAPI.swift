//
// AdControllerAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class AdControllerAPI {
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
    open class func allUsingGET1(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageAds?,_ error: Error?) -> Void)) {
        allUsingGET1WithRequestBuilder(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     all
     - GET /api/v1/getallads
     - examples: [{output=none}]
     
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)

     - returns: RequestBuilder<PageAds> 
     */
    open class func allUsingGET1WithRequestBuilder(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil) -> RequestBuilder<PageAds> {
        let path = "/api/v1/getallads"
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

        let requestBuilder: RequestBuilder<PageAds>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     deleteAd
     
     - parameter adId: (path) adId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteAdUsingDELETE(adId: Int64, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        deleteAdUsingDELETEWithRequestBuilder(adId: adId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     deleteAd
     - DELETE /api/v1/ads/{adId}
     - examples: [{output=none}]
     
     - parameter adId: (path) adId 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func deleteAdUsingDELETEWithRequestBuilder(adId: Int64) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/ads/{adId}"
        let adIdPreEscape = "\(adId)"
        let adIdPostEscape = adIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{adId}", with: adIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     getAd
     
     - parameter adId: (path) adId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getAdUsingGET(adId: Int64, completion: @escaping ((_ data: Ads?,_ error: Error?) -> Void)) {
        getAdUsingGETWithRequestBuilder(adId: adId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     getAd
     - GET /api/v1/ads/{adId}
     - examples: [{output=none}]
     
     - parameter adId: (path) adId 

     - returns: RequestBuilder<Ads> 
     */
    open class func getAdUsingGETWithRequestBuilder(adId: Int64) -> RequestBuilder<Ads> {
        var path = "/api/v1/ads/{adId}"
        let adIdPreEscape = "\(adId)"
        let adIdPostEscape = adIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{adId}", with: adIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<Ads>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     getbyAdName
     
     - parameter adName: (query) adName 
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getbyAdNameUsingGET(adName: String, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageAds?,_ error: Error?) -> Void)) {
        getbyAdNameUsingGETWithRequestBuilder(adName: adName, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     getbyAdName
     - GET /api/v1/ads
     - examples: [{output=none}]
     
     - parameter adName: (query) adName 
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)

     - returns: RequestBuilder<PageAds> 
     */
    open class func getbyAdNameUsingGETWithRequestBuilder(adName: String, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil) -> RequestBuilder<PageAds> {
        let path = "/api/v1/ads"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "adName": adName, 
            "offset": offset?.encodeToJSON(), 
            "pageNumber": pageNumber?.encodeToJSON(), 
            "pageSize": pageSize?.encodeToJSON(), 
            "paged": paged, 
            "sort.sorted": sortSorted, 
            "sort.unsorted": sortUnsorted, 
            "unpaged": unpaged
        ])

        let requestBuilder: RequestBuilder<PageAds>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     saveAd
     
     - parameter ad: (body) ad 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func saveAdUsingPOST(ad: Ads, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        saveAdUsingPOSTWithRequestBuilder(ad: ad).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     saveAd
     - POST /api/v1/ads
     - examples: [{output=none}]
     
     - parameter ad: (body) ad 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func saveAdUsingPOSTWithRequestBuilder(ad: Ads) -> RequestBuilder<JSONValue> {
        let path = "/api/v1/ads"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: ad)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     updateAd
     
     - parameter ad: (body) ad 
     - parameter adId: (path) adId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateAdUsingPUT(ad: Ads, adId: Int64, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        updateAdUsingPUTWithRequestBuilder(ad: ad, adId: adId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     updateAd
     - PUT /api/v1/ads/{adId}
     - examples: [{output=none}]
     
     - parameter ad: (body) ad 
     - parameter adId: (path) adId 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func updateAdUsingPUTWithRequestBuilder(ad: Ads, adId: Int64) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/ads/{adId}"
        let adIdPreEscape = "\(adId)"
        let adIdPostEscape = adIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{adId}", with: adIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: ad)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
