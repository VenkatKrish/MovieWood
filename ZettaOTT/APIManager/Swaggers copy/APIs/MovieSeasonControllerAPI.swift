//
// MovieSeasonControllerAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class MovieSeasonControllerAPI {
    /**
     all
     
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func allUsingGET18(completion: @escaping ((_ data: [MovieSeasons]?,_ error: Error?) -> Void)) {
        allUsingGET18WithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     all
     - GET /api/v1/getallmovieseasons
     - examples: [{output=none}]

     - returns: RequestBuilder<[MovieSeasons]> 
     */
    open class func allUsingGET18WithRequestBuilder() -> RequestBuilder<[MovieSeasons]> {
        let path = "/api/v1/getallmovieseasons"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<[MovieSeasons]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     deleteMovieSeason
     
     - parameter movieId: (path) movieId 
     - parameter movieSeasonId: (path) movieSeasonId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteMovieSeasonUsingDELETE(movieId: Int64, movieSeasonId: Int64, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        deleteMovieSeasonUsingDELETEWithRequestBuilder(movieId: movieId, movieSeasonId: movieSeasonId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     deleteMovieSeason
     - DELETE /api/v1/movie/{movieId}/movieSeasons/{movieSeasonId}
     - examples: [{output=none}]
     
     - parameter movieId: (path) movieId 
     - parameter movieSeasonId: (path) movieSeasonId 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func deleteMovieSeasonUsingDELETEWithRequestBuilder(movieId: Int64, movieSeasonId: Int64) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/movie/{movieId}/movieSeasons/{movieSeasonId}"
        let movieIdPreEscape = "\(movieId)"
        let movieIdPostEscape = movieIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieId}", with: movieIdPostEscape, options: .literal, range: nil)
        let movieSeasonIdPreEscape = "\(movieSeasonId)"
        let movieSeasonIdPostEscape = movieSeasonIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieSeasonId}", with: movieSeasonIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     movieSeasonsById
     
     - parameter movieSeasonId: (path) movieSeasonId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func movieSeasonsByIdUsingGET(movieSeasonId: Int64, completion: @escaping ((_ data: MovieSeasons?,_ error: Error?) -> Void)) {
        movieSeasonsByIdUsingGETWithRequestBuilder(movieSeasonId: movieSeasonId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     movieSeasonsById
     - GET /api/v1/movieseasons/id/{movieSeasonId}
     - examples: [{output=none}]
     
     - parameter movieSeasonId: (path) movieSeasonId 

     - returns: RequestBuilder<MovieSeasons> 
     */
    open class func movieSeasonsByIdUsingGETWithRequestBuilder(movieSeasonId: Int64) -> RequestBuilder<MovieSeasons> {
        var path = "/api/v1/movieseasons/id/{movieSeasonId}"
        let movieSeasonIdPreEscape = "\(movieSeasonId)"
        let movieSeasonIdPostEscape = movieSeasonIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieSeasonId}", with: movieSeasonIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<MovieSeasons>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     movieSeasonsByMoviePublic
     
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
    open class func movieSeasonsByMoviePublicUsingGET(movieId: Int64, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageMovieSeasons?,_ error: Error?) -> Void)) {
        movieSeasonsByMoviePublicUsingGETWithRequestBuilder(movieId: movieId, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     movieSeasonsByMoviePublic
     - GET /api/v1/public/movieseasonsbymovie/{movieId}
     - examples: [{output=none}]
     
     - parameter movieId: (path) movieId 
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)

     - returns: RequestBuilder<PageMovieSeasons> 
     */
    open class func movieSeasonsByMoviePublicUsingGETWithRequestBuilder(movieId: Int64, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil) -> RequestBuilder<PageMovieSeasons> {
        var path = "/api/v1/public/movieseasonsbymovie/{movieId}"
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

        let requestBuilder: RequestBuilder<PageMovieSeasons>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     movieSeasonsByMovie
     
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
    open class func movieSeasonsByMovieUsingGET(movieId: Int64, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageMovieSeasons?,_ error: Error?) -> Void)) {
        movieSeasonsByMovieUsingGETWithRequestBuilder(movieId: movieId, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     movieSeasonsByMovie
     - GET /api/v1/movieseasonsbymovie/{movieId}
     - examples: [{output=none}]
     
     - parameter movieId: (path) movieId 
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)

     - returns: RequestBuilder<PageMovieSeasons> 
     */
    open class func movieSeasonsByMovieUsingGETWithRequestBuilder(movieId: Int64, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil) -> RequestBuilder<PageMovieSeasons> {
        var path = "/api/v1/movieseasonsbymovie/{movieId}"
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

        let requestBuilder: RequestBuilder<PageMovieSeasons>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     saveMovieSeason
     
     - parameter movieId: (path) movieId 
     - parameter movieSeason: (body) movieSeason 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func saveMovieSeasonUsingPOST(movieId: Int64, movieSeason: MovieSeasons, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        saveMovieSeasonUsingPOSTWithRequestBuilder(movieId: movieId, movieSeason: movieSeason).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     saveMovieSeason
     - POST /api/v1/movie/{movieId}/movieSeasons
     - examples: [{output=none}]
     
     - parameter movieId: (path) movieId 
     - parameter movieSeason: (body) movieSeason 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func saveMovieSeasonUsingPOSTWithRequestBuilder(movieId: Int64, movieSeason: MovieSeasons) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/movie/{movieId}/movieSeasons"
        let movieIdPreEscape = "\(movieId)"
        let movieIdPostEscape = movieIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieId}", with: movieIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: movieSeason)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     updateMovieSeason
     
     - parameter movieSeason: (body) movieSeason 
     - parameter movieSeasonId: (path) movieSeasonId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateMovieSeasonUsingPUT(movieSeason: MovieSeasons, movieSeasonId: Int64, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        updateMovieSeasonUsingPUTWithRequestBuilder(movieSeason: movieSeason, movieSeasonId: movieSeasonId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     updateMovieSeason
     - PUT /api/v1/movieSeasons/{movieSeasonId}
     - examples: [{output=none}]
     
     - parameter movieSeason: (body) movieSeason 
     - parameter movieSeasonId: (path) movieSeasonId 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func updateMovieSeasonUsingPUTWithRequestBuilder(movieSeason: MovieSeasons, movieSeasonId: Int64) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/movieSeasons/{movieSeasonId}"
        let movieSeasonIdPreEscape = "\(movieSeasonId)"
        let movieSeasonIdPostEscape = movieSeasonIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieSeasonId}", with: movieSeasonIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: movieSeason)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
