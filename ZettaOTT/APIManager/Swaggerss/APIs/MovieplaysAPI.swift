//
// MovieplaysAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class MovieplaysAPI {
    /**
     Movie Plays

     - parameter body: (body)  
     - parameter contentType: (header)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func moviePlays(body: String, contentType: String, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        moviePlaysWithRequestBuilder(body: body, contentType: contentType).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Movie Plays
     - POST /cholaottservice/api/v1/playmoview
     - 

     - parameter body: (body)  
     - parameter contentType: (header)  

     - returns: RequestBuilder<Void> 
     */
    open class func moviePlaysWithRequestBuilder(body: String, contentType: String) -> RequestBuilder<Void> {
        let path = "/cholaottservice/api/v1/playmoview"
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
     Movie Plays Copy

     - parameter movieId: (query)  
     - parameter contentType: (header)  
     - parameter authorization: (header)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func moviePlaysCopy(movieId: Decimal, contentType: String, authorization: String, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        moviePlaysCopyWithRequestBuilder(movieId: movieId, contentType: contentType, authorization: authorization).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Movie Plays Copy
     - GET /cholaottservice/api/v1/playmoview
     - 

     - parameter movieId: (query)  
     - parameter contentType: (header)  
     - parameter authorization: (header)  

     - returns: RequestBuilder<Void> 
     */
    open class func moviePlaysCopyWithRequestBuilder(movieId: Decimal, contentType: String, authorization: String) -> RequestBuilder<Void> {
        let path = "/cholaottservice/api/v1/playmoview"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
                        "movieId": movieId
        ])
        let nillableHeaders: [String: Any?] = [
                        "Content-Type": contentType,
                        "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }
    /**
     Movie Plays Web

     - parameter body: (body)  
     - parameter contentType: (header)  
     - parameter authorization: (header)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func moviePlaysWeb(body: String, contentType: String, authorization: String, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        moviePlaysWebWithRequestBuilder(body: body, contentType: contentType, authorization: authorization).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Movie Plays Web
     - POST /cholaottservice/api/v1/playmovieweb
     - 

     - parameter body: (body)  
     - parameter contentType: (header)  
     - parameter authorization: (header)  

     - returns: RequestBuilder<Void> 
     */
    open class func moviePlaysWebWithRequestBuilder(body: String, contentType: String, authorization: String) -> RequestBuilder<Void> {
        let path = "/cholaottservice/api/v1/playmovieweb"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
                        "Content-Type": contentType,
                        "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true, headers: headerParameters)
    }
}
