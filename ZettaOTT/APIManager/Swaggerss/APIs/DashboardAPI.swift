//
// DashboardAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class DashboardAPI {
    /**
     Chart Paid order by movie

     - parameter contentType: (header)  
     - parameter authorization: (header)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func chartPaidorderbymovie(contentType: String, authorization: String, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        chartPaidorderbymovieWithRequestBuilder(contentType: contentType, authorization: authorization).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Chart Paid order by movie
     - GET /cholaottservice/api/v1/charts/paidordersbymovie
     - 

     - parameter contentType: (header)  
     - parameter authorization: (header)  

     - returns: RequestBuilder<Void> 
     */
    open class func chartPaidorderbymovieWithRequestBuilder(contentType: String, authorization: String) -> RequestBuilder<Void> {
        let path = "/cholaottservice/api/v1/charts/paidordersbymovie"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
                        "Content-Type": contentType,
                        "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }
    /**
     Quick Dashboard

     - parameter contentType: (header)  
     - parameter authorization: (header)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func quickDashboard(contentType: String, authorization: String, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        quickDashboardWithRequestBuilder(contentType: contentType, authorization: authorization).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Quick Dashboard
     - GET /cholaottservice/api/v1/dashboard/1
     - 

     - parameter contentType: (header)  
     - parameter authorization: (header)  

     - returns: RequestBuilder<Void> 
     */
    open class func quickDashboardWithRequestBuilder(contentType: String, authorization: String) -> RequestBuilder<Void> {
        let path = "/cholaottservice/api/v1/dashboard/1"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)
        let nillableHeaders: [String: Any?] = [
                        "Content-Type": contentType,
                        "Authorization": authorization
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false, headers: headerParameters)
    }
}
