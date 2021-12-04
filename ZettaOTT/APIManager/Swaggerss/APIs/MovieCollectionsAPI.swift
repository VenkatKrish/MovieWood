//
// MovieCollectionsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class MovieCollectionsAPI {
    /**
     Collections by Movie

     - parameter contentType: (header)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func collectionsbyMovie(contentType: String, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        collectionsbyMovieWithRequestBuilder(contentType: contentType).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Collections by Movie
     - GET /cholaottservice/api/v1/moviecollections/movie/26
     - 

     - parameter contentType: (header)  

     - returns: RequestBuilder<Void> 
     */
    open class func collectionsbyMovieWithRequestBuilder(contentType: String) -> RequestBuilder<Void> {
        let path = "/cholaottservice/api/v1/moviecollections/movie/26"
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
     Create Movie Collection

     - parameter body: (body)  
     - parameter contentType: (header)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func createMovieCollection(body: String, contentType: String, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        createMovieCollectionWithRequestBuilder(body: body, contentType: contentType).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Create Movie Collection
     - POST /cholaottservice/api/v1/movie/131/moviecollections
     - 

     - parameter body: (body)  
     - parameter contentType: (header)  

     - returns: RequestBuilder<Void> 
     */
    open class func createMovieCollectionWithRequestBuilder(body: String, contentType: String) -> RequestBuilder<Void> {
        let path = "/cholaottservice/api/v1/movie/131/moviecollections"
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
     Get All Movie Collections

     - parameter contentType: (header)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getAllMovieCollections(contentType: String, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        getAllMovieCollectionsWithRequestBuilder(contentType: contentType).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Get All Movie Collections
     - GET /cholaottservice/api/v1/moviecollections/getall
     - 

     - parameter contentType: (header)  

     - returns: RequestBuilder<Void> 
     */
    open class func getAllMovieCollectionsWithRequestBuilder(contentType: String) -> RequestBuilder<Void> {
        let path = "/cholaottservice/api/v1/moviecollections/getall"
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
     Movies Collections by ID

     - parameter contentType: (header)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func moviesCollectionsbyID(contentType: String, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        moviesCollectionsbyIDWithRequestBuilder(contentType: contentType).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Movies Collections by ID
     - GET /cholaottservice/api/v1/moviecollections/26
     - 

     - parameter contentType: (header)  

     - returns: RequestBuilder<Void> 
     */
    open class func moviesCollectionsbyIDWithRequestBuilder(contentType: String) -> RequestBuilder<Void> {
        let path = "/cholaottservice/api/v1/moviecollections/26"
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
     Movies Collections by ID Public

     - parameter contentType: (header)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func moviesCollectionsbyIDPublic(contentType: String, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        moviesCollectionsbyIDPublicWithRequestBuilder(contentType: contentType).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Movies Collections by ID Public
     - GET /cholaottservice/api/v1/public/moviecollections/bycollection/14
     - 

     - parameter contentType: (header)  

     - returns: RequestBuilder<Void> 
     */
    open class func moviesCollectionsbyIDPublicWithRequestBuilder(contentType: String) -> RequestBuilder<Void> {
        let path = "/cholaottservice/api/v1/public/moviecollections/bycollection/14"
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
}
