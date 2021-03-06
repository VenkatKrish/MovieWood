//
// GenresAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire


open class GenresAPI {
    /**
     Create Genres

     - parameter body: (body)  
     - parameter contentType: (header)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func createGenres(body: String, contentType: String, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        createGenresWithRequestBuilder(body: body, contentType: contentType).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Create Genres
     - POST /cholaottservice/api/v1/genres
     - 

     - parameter body: (body)  
     - parameter contentType: (header)  

     - returns: RequestBuilder<Void> 
     */
    open class func createGenresWithRequestBuilder(body: String, contentType: String) -> RequestBuilder<Void> {
        let path = "/cholaottservice/api/v1/genres"
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
     Delete Genre

     - parameter contentType: (header)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteGenre(contentType: String, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        deleteGenreWithRequestBuilder(contentType: contentType).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Delete Genre
     - DELETE /api/v1/genres/1
     - 

     - parameter contentType: (header)  

     - returns: RequestBuilder<Void> 
     */
    open class func deleteGenreWithRequestBuilder(contentType: String) -> RequestBuilder<Void> {
        let path = "/api/v1/genres/1"
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
     Get Genres

     - parameter contentType: (header)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getGenres(contentType: String, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        getGenresWithRequestBuilder(contentType: contentType).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Get Genres
     - GET /cholaottservice/api/v1/getallgenres
     - 

     - parameter contentType: (header)  

     - returns: RequestBuilder<Void> 
     */
    open class func getGenresWithRequestBuilder(contentType: String) -> RequestBuilder<Void> {
        let path = "/cholaottservice/api/v1/getallgenres"
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
     Get Genres Public

     - parameter contentType: (header)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getGenresPublic(contentType: String, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        getGenresPublicWithRequestBuilder(contentType: contentType).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Get Genres Public
     - GET /cholaottservice/api/v1/public/getallgenres
     - 

     - parameter contentType: (header)  

     - returns: RequestBuilder<Void> 
     */
    open class func getGenresPublicWithRequestBuilder(contentType: String) -> RequestBuilder<Void> {
        let path = "/cholaottservice/api/v1/public/getallgenres"
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
     Update Genres

     - parameter body: (body)  
     - parameter contentType: (header)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateGenres(body: String, contentType: String, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        updateGenresWithRequestBuilder(body: body, contentType: contentType).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Update Genres
     - PUT /api/v1/genres/1
     - 

     - parameter body: (body)  
     - parameter contentType: (header)  

     - returns: RequestBuilder<Void> 
     */
    open class func updateGenresWithRequestBuilder(body: String, contentType: String) -> RequestBuilder<Void> {
        let path = "/api/v1/genres/1"
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
