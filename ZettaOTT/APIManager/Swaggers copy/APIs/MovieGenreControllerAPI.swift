//
// MovieGenreControllerAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class MovieGenreControllerAPI {
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
    open class func allUsingGET13(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageMovieGenres?,_ error: Error?) -> Void)) {
        allUsingGET13WithRequestBuilder(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     all
     - GET /api/v1/getallmoviegenres
     - examples: [{output=none}]
     
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)

     - returns: RequestBuilder<PageMovieGenres> 
     */
    open class func allUsingGET13WithRequestBuilder(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil) -> RequestBuilder<PageMovieGenres> {
        let path = "/api/v1/getallmoviegenres"
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

        let requestBuilder: RequestBuilder<PageMovieGenres>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     deleteMovieGenre
     
     - parameter movieGenreId: (path) movieGenreId 
     - parameter movieId: (path) movieId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteMovieGenreUsingDELETE(movieGenreId: Int64, movieId: Int64, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        deleteMovieGenreUsingDELETEWithRequestBuilder(movieGenreId: movieGenreId, movieId: movieId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     deleteMovieGenre
     - DELETE /api/v1/movie/{movieId}/moviegenres/{movieGenreId}
     - examples: [{output=none}]
     
     - parameter movieGenreId: (path) movieGenreId 
     - parameter movieId: (path) movieId 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func deleteMovieGenreUsingDELETEWithRequestBuilder(movieGenreId: Int64, movieId: Int64) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/movie/{movieId}/moviegenres/{movieGenreId}"
        let movieGenreIdPreEscape = "\(movieGenreId)"
        let movieGenreIdPostEscape = movieGenreIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieGenreId}", with: movieGenreIdPostEscape, options: .literal, range: nil)
        let movieIdPreEscape = "\(movieId)"
        let movieIdPostEscape = movieIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieId}", with: movieIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     movieGenresByGenre
     
     - parameter genreId: (path) genreId 
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func movieGenresByGenreUsingGET(genreId: Int64, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageMovieGenres?,_ error: Error?) -> Void)) {
        movieGenresByGenreUsingGETWithRequestBuilder(genreId: genreId, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     movieGenresByGenre
     - GET /api/v1/moviegenresbygenre/{genreId}
     - examples: [{output=none}]
     
     - parameter genreId: (path) genreId 
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)

     - returns: RequestBuilder<PageMovieGenres> 
     */
    open class func movieGenresByGenreUsingGETWithRequestBuilder(genreId: Int64, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil) -> RequestBuilder<PageMovieGenres> {
        var path = "/api/v1/moviegenresbygenre/{genreId}"
        let genreIdPreEscape = "\(genreId)"
        let genreIdPostEscape = genreIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{genreId}", with: genreIdPostEscape, options: .literal, range: nil)
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

        let requestBuilder: RequestBuilder<PageMovieGenres>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     movieGenresById
     
     - parameter movieGenreId: (path) movieGenreId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func movieGenresByIdUsingGET(movieGenreId: Int64, completion: @escaping ((_ data: MovieGenres?,_ error: Error?) -> Void)) {
        movieGenresByIdUsingGETWithRequestBuilder(movieGenreId: movieGenreId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     movieGenresById
     - GET /api/v1/moviegenresbyid/{movieGenreId}
     - examples: [{output=none}]
     
     - parameter movieGenreId: (path) movieGenreId 

     - returns: RequestBuilder<MovieGenres> 
     */
    open class func movieGenresByIdUsingGETWithRequestBuilder(movieGenreId: Int64) -> RequestBuilder<MovieGenres> {
        var path = "/api/v1/moviegenresbyid/{movieGenreId}"
        let movieGenreIdPreEscape = "\(movieGenreId)"
        let movieGenreIdPostEscape = movieGenreIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieGenreId}", with: movieGenreIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<MovieGenres>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     movieGenresByMovie
     
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
    open class func movieGenresByMovieUsingGET1(movieId: Int64, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageMovieGenres?,_ error: Error?) -> Void)) {
        movieGenresByMovieUsingGET1WithRequestBuilder(movieId: movieId, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     movieGenresByMovie
     - GET /api/v1/moviegenresbymovie/{movieId}
     - examples: [{output=none}]
     
     - parameter movieId: (path) movieId 
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)

     - returns: RequestBuilder<PageMovieGenres> 
     */
    open class func movieGenresByMovieUsingGET1WithRequestBuilder(movieId: Int64, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil) -> RequestBuilder<PageMovieGenres> {
        var path = "/api/v1/moviegenresbymovie/{movieId}"
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

        let requestBuilder: RequestBuilder<PageMovieGenres>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     movieGenres
     
     - parameter movieId: (path) movieId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func movieGenresUsingGET(movieId: Int64, completion: @escaping ((_ data: [MovieGenres]?,_ error: Error?) -> Void)) {
        movieGenresUsingGETWithRequestBuilder(movieId: movieId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     movieGenres
     - GET /api/v1/moviegenres/{movieId}
     - examples: [{output=none}]
     
     - parameter movieId: (path) movieId 

     - returns: RequestBuilder<[MovieGenres]> 
     */
    open class func movieGenresUsingGETWithRequestBuilder(movieId: Int64) -> RequestBuilder<[MovieGenres]> {
        var path = "/api/v1/moviegenres/{movieId}"
        let movieIdPreEscape = "\(movieId)"
        let movieIdPostEscape = movieIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieId}", with: movieIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<[MovieGenres]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     saveMovieGenre
     
     - parameter movieGenre: (body) movieGenre 
     - parameter movieId: (path) movieId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func saveMovieGenreUsingPOST(movieGenre: MovieGenres, movieId: Int64, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        saveMovieGenreUsingPOSTWithRequestBuilder(movieGenre: movieGenre, movieId: movieId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     saveMovieGenre
     - POST /api/v1/movie/{movieId}/moviegenres
     - examples: [{output=none}]
     
     - parameter movieGenre: (body) movieGenre 
     - parameter movieId: (path) movieId 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func saveMovieGenreUsingPOSTWithRequestBuilder(movieGenre: MovieGenres, movieId: Int64) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/movie/{movieId}/moviegenres"
        let movieIdPreEscape = "\(movieId)"
        let movieIdPostEscape = movieIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieId}", with: movieIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: movieGenre)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     updateMovieGenre
     
     - parameter movieGenreId: (path) movieGenreId 
     - parameter moviegenre: (body) moviegenre 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateMovieGenreUsingPUT(movieGenreId: Int64, moviegenre: MovieGenres, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        updateMovieGenreUsingPUTWithRequestBuilder(movieGenreId: movieGenreId, moviegenre: moviegenre).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     updateMovieGenre
     - PUT /api/v1/moviegenres/{movieGenreId}
     - examples: [{output=none}]
     
     - parameter movieGenreId: (path) movieGenreId 
     - parameter moviegenre: (body) moviegenre 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func updateMovieGenreUsingPUTWithRequestBuilder(movieGenreId: Int64, moviegenre: MovieGenres) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/moviegenres/{movieGenreId}"
        let movieGenreIdPreEscape = "\(movieGenreId)"
        let movieGenreIdPostEscape = movieGenreIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieGenreId}", with: movieGenreIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: moviegenre)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
