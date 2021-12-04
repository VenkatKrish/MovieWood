//
// MovieRegionControllerAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class MovieRegionControllerAPI {
    /**
     all
     
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func allUsingGET16(completion: @escaping ((_ data: [MovieRegions]?,_ error: Error?) -> Void)) {
        allUsingGET16WithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     all
     - GET /api/v1/getallmovieregions
     - examples: [{output=none}]

     - returns: RequestBuilder<[MovieRegions]> 
     */
    open class func allUsingGET16WithRequestBuilder() -> RequestBuilder<[MovieRegions]> {
        let path = "/api/v1/getallmovieregions"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<[MovieRegions]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     deleteMovieReview
     
     - parameter movieId: (path) movieId 
     - parameter movieRegionId: (path) movieRegionId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteMovieReviewUsingDELETE(movieId: Int64, movieRegionId: Int64, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        deleteMovieReviewUsingDELETEWithRequestBuilder(movieId: movieId, movieRegionId: movieRegionId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     deleteMovieReview
     - DELETE /api/v1/movie/{movieId}/movieregions/{movieRegionId}
     - examples: [{output=none}]
     
     - parameter movieId: (path) movieId 
     - parameter movieRegionId: (path) movieRegionId 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func deleteMovieReviewUsingDELETEWithRequestBuilder(movieId: Int64, movieRegionId: Int64) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/movie/{movieId}/movieregions/{movieRegionId}"
        let movieIdPreEscape = "\(movieId)"
        let movieIdPostEscape = movieIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieId}", with: movieIdPostEscape, options: .literal, range: nil)
        let movieRegionIdPreEscape = "\(movieRegionId)"
        let movieRegionIdPostEscape = movieRegionIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieRegionId}", with: movieRegionIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     movieRegionsById
     
     - parameter movieRegionId: (path) movieRegionId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func movieRegionsByIdUsingGET(movieRegionId: Int64, completion: @escaping ((_ data: MovieRegions?,_ error: Error?) -> Void)) {
        movieRegionsByIdUsingGETWithRequestBuilder(movieRegionId: movieRegionId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     movieRegionsById
     - GET /api/v1/movieregions/id/{movieRegionId}
     - examples: [{output=none}]
     
     - parameter movieRegionId: (path) movieRegionId 

     - returns: RequestBuilder<MovieRegions> 
     */
    open class func movieRegionsByIdUsingGETWithRequestBuilder(movieRegionId: Int64) -> RequestBuilder<MovieRegions> {
        var path = "/api/v1/movieregions/id/{movieRegionId}"
        let movieRegionIdPreEscape = "\(movieRegionId)"
        let movieRegionIdPostEscape = movieRegionIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieRegionId}", with: movieRegionIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<MovieRegions>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     movieRegionsByMoviePublic
     
     - parameter movieId: (path) movieId 
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func movieRegionsByMoviePublicUsingGET(movieId: Int64, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageMovieRegions?,_ error: Error?) -> Void)) {
        movieRegionsByMoviePublicUsingGETWithRequestBuilder(movieId: movieId, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     movieRegionsByMoviePublic
     - GET /api/v1/public/movieregionsbymovie/{movieId}
     - examples: [{output=none}]
     
     - parameter movieId: (path) movieId 
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)

     - returns: RequestBuilder<PageMovieRegions> 
     */
    open class func movieRegionsByMoviePublicUsingGETWithRequestBuilder(movieId: Int64, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil) -> RequestBuilder<PageMovieRegions> {
        var path = "/api/v1/public/movieregionsbymovie/{movieId}"
        let movieIdPreEscape = "\(movieId)"
        let movieIdPostEscape = movieIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieId}", with: movieIdPostEscape, options: .literal, range: nil)
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

        let requestBuilder: RequestBuilder<PageMovieRegions>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     movieRegionsByMovie
     
     - parameter movieId: (path) movieId 
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func movieRegionsByMovieUsingGET(movieId: Int64, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageMovieRegions?,_ error: Error?) -> Void)) {
        movieRegionsByMovieUsingGETWithRequestBuilder(movieId: movieId, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     movieRegionsByMovie
     - GET /api/v1/movieregionsbymovie/{movieId}
     - examples: [{output=none}]
     
     - parameter movieId: (path) movieId 
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)

     - returns: RequestBuilder<PageMovieRegions> 
     */
    open class func movieRegionsByMovieUsingGETWithRequestBuilder(movieId: Int64, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil) -> RequestBuilder<PageMovieRegions> {
        var path = "/api/v1/movieregionsbymovie/{movieId}"
        let movieIdPreEscape = "\(movieId)"
        let movieIdPostEscape = movieIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieId}", with: movieIdPostEscape, options: .literal, range: nil)
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

        let requestBuilder: RequestBuilder<PageMovieRegions>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     saveMovieRegion
     
     - parameter movieId: (path) movieId 
     - parameter movieRegion: (body) movieRegion 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func saveMovieRegionUsingPOST(movieId: Int64, movieRegion: MovieRegions, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        saveMovieRegionUsingPOSTWithRequestBuilder(movieId: movieId, movieRegion: movieRegion).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     saveMovieRegion
     - POST /api/v1/movie/{movieId}/movieregions
     - examples: [{output=none}]
     
     - parameter movieId: (path) movieId 
     - parameter movieRegion: (body) movieRegion 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func saveMovieRegionUsingPOSTWithRequestBuilder(movieId: Int64, movieRegion: MovieRegions) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/movie/{movieId}/movieregions"
        let movieIdPreEscape = "\(movieId)"
        let movieIdPostEscape = movieIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieId}", with: movieIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: movieRegion)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     updateMovieRegion
     
     - parameter movieRegion: (body) movieRegion 
     - parameter movieRegionId: (path) movieRegionId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateMovieRegionUsingPUT(movieRegion: MovieRegions, movieRegionId: Int64, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        updateMovieRegionUsingPUTWithRequestBuilder(movieRegion: movieRegion, movieRegionId: movieRegionId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     updateMovieRegion
     - PUT /api/v1/movieregions/{movieRegionId}
     - examples: [{output=none}]
     
     - parameter movieRegion: (body) movieRegion 
     - parameter movieRegionId: (path) movieRegionId 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func updateMovieRegionUsingPUTWithRequestBuilder(movieRegion: MovieRegions, movieRegionId: Int64) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/movieregions/{movieRegionId}"
        let movieRegionIdPreEscape = "\(movieRegionId)"
        let movieRegionIdPostEscape = movieRegionIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieRegionId}", with: movieRegionIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: movieRegion)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
