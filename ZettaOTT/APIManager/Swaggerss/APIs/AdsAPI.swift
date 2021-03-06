//
// AdsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class AdsAPI {
    /**
     Create Ads

     - parameter body: (body)  
     - parameter contentType: (header)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func createAds(body: String, contentType: String, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        createAdsWithRequestBuilder(body: body, contentType: contentType).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Create Ads
     - POST /cholaottservice/api/v1/ads
     - 

     - parameter body: (body)  
     - parameter contentType: (header)  

     - returns: RequestBuilder<Void> 
     */
    open class func createAdsWithRequestBuilder(body: String, contentType: String) -> RequestBuilder<Void> {
        let path = "/cholaottservice/api/v1/ads"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
                        "Content-Type": contentType
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true, headers: headerParameters)
    }
    /**
     Get Ads

     - parameter contentType: (header)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getAds(contentType: String, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        getAdsWithRequestBuilder(contentType: contentType).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Get Ads
     - GET /cholaottservice/api/v1/ads/3
     - 

     - parameter contentType: (header)  

     - returns: RequestBuilder<Void> 
     */
    open class func getAdsWithRequestBuilder(contentType: String) -> RequestBuilder<Void> {
        let path = "/cholaottservice/api/v1/ads/3"
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
     Get All Ads

     - parameter contentType: (header)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getAllAds(contentType: String, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        getAllAdsWithRequestBuilder(contentType: contentType).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Get All Ads
     - GET /cholaottservice/api/v1/getallads
     - 

     - parameter contentType: (header)  

     - returns: RequestBuilder<Void> 
     */
    open class func getAllAdsWithRequestBuilder(contentType: String) -> RequestBuilder<Void> {
        let path = "/cholaottservice/api/v1/getallads"
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
     Update Ads

     - parameter body: (body)  
     - parameter contentType: (header)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateAds(body: String, contentType: String, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        updateAdsWithRequestBuilder(body: body, contentType: contentType).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Update Ads
     - PUT /cholaottservice/api/v1/ads/3
     - 

     - parameter body: (body)  
     - parameter contentType: (header)  

     - returns: RequestBuilder<Void> 
     */
    open class func updateAdsWithRequestBuilder(body: String, contentType: String) -> RequestBuilder<Void> {
        let path = "/cholaottservice/api/v1/ads/3"
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
