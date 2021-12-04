//
// MovieSongControllerAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class MovieSongControllerAPI {
    /**
     all
     
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func allUsingGET19(completion: @escaping ((_ data: [MovieSongs]?,_ error: Error?) -> Void)) {
        allUsingGET19WithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     all
     - GET /api/v1/getallmoviesongs
     - examples: [{output=none}]

     - returns: RequestBuilder<[MovieSongs]> 
     */
    open class func allUsingGET19WithRequestBuilder() -> RequestBuilder<[MovieSongs]> {
        let path = "/api/v1/getallmoviesongs"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<[MovieSongs]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     deleteMovieSong
     
     - parameter movieId: (path) movieId 
     - parameter movieSongId: (path) movieSongId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteMovieSongUsingDELETE(movieId: Int64, movieSongId: Int64, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        deleteMovieSongUsingDELETEWithRequestBuilder(movieId: movieId, movieSongId: movieSongId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     deleteMovieSong
     - DELETE /api/v1/movie/{movieId}/moviesongs/{movieSongId}
     - examples: [{output=none}]
     
     - parameter movieId: (path) movieId 
     - parameter movieSongId: (path) movieSongId 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func deleteMovieSongUsingDELETEWithRequestBuilder(movieId: Int64, movieSongId: Int64) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/movie/{movieId}/moviesongs/{movieSongId}"
        let movieIdPreEscape = "\(movieId)"
        let movieIdPostEscape = movieIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieId}", with: movieIdPostEscape, options: .literal, range: nil)
        let movieSongIdPreEscape = "\(movieSongId)"
        let movieSongIdPostEscape = movieSongIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieSongId}", with: movieSongIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     movieSongsById
     
     - parameter movieSongId: (path) movieSongId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func movieSongsByIdUsingGET1(movieSongId: Int64, completion: @escaping ((_ data: MovieSongs?,_ error: Error?) -> Void)) {
        movieSongsByIdUsingGET1WithRequestBuilder(movieSongId: movieSongId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     movieSongsById
     - GET /api/v1/moviesongs/id/{movieSongId}
     - examples: [{output=none}]
     
     - parameter movieSongId: (path) movieSongId 

     - returns: RequestBuilder<MovieSongs> 
     */
    open class func movieSongsByIdUsingGET1WithRequestBuilder(movieSongId: Int64) -> RequestBuilder<MovieSongs> {
        var path = "/api/v1/moviesongs/id/{movieSongId}"
        let movieSongIdPreEscape = "\(movieSongId)"
        let movieSongIdPostEscape = movieSongIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieSongId}", with: movieSongIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<MovieSongs>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     movieSongs
     
     - parameter movieId: (path) movieId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func movieSongsUsingGET1(movieId: Int64, completion: @escaping ((_ data: [MovieSongs]?,_ error: Error?) -> Void)) {
        movieSongsUsingGET1WithRequestBuilder(movieId: movieId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     movieSongs
     - GET /api/v1/moviesongs/{movieId}
     - examples: [{output=none}]
     
     - parameter movieId: (path) movieId 

     - returns: RequestBuilder<[MovieSongs]> 
     */
    open class func movieSongsUsingGET1WithRequestBuilder(movieId: Int64) -> RequestBuilder<[MovieSongs]> {
        var path = "/api/v1/moviesongs/{movieId}"
        let movieIdPreEscape = "\(movieId)"
        let movieIdPostEscape = movieIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieId}", with: movieIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<[MovieSongs]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     saveMovieSong
     
     - parameter movieId: (path) movieId 
     - parameter movieSong: (body) movieSong 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func saveMovieSongUsingPOST(movieId: Int64, movieSong: MovieSongs, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        saveMovieSongUsingPOSTWithRequestBuilder(movieId: movieId, movieSong: movieSong).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     saveMovieSong
     - POST /api/v1/movie/{movieId}/moviesongs
     - examples: [{output=none}]
     
     - parameter movieId: (path) movieId 
     - parameter movieSong: (body) movieSong 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func saveMovieSongUsingPOSTWithRequestBuilder(movieId: Int64, movieSong: MovieSongs) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/movie/{movieId}/moviesongs"
        let movieIdPreEscape = "\(movieId)"
        let movieIdPostEscape = movieIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieId}", with: movieIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: movieSong)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     updateMovieSong
     
     - parameter movieSongId: (path) movieSongId 
     - parameter moviesong: (body) moviesong 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateMovieSongUsingPUT(movieSongId: Int64, moviesong: MovieSongs, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        updateMovieSongUsingPUTWithRequestBuilder(movieSongId: movieSongId, moviesong: moviesong).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     updateMovieSong
     - PUT /api/v1/moviesongs/{movieSongId}
     - examples: [{output=none}]
     
     - parameter movieSongId: (path) movieSongId 
     - parameter moviesong: (body) moviesong 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func updateMovieSongUsingPUTWithRequestBuilder(movieSongId: Int64, moviesong: MovieSongs) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/moviesongs/{movieSongId}"
        let movieSongIdPreEscape = "\(movieSongId)"
        let movieSongIdPostEscape = movieSongIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieSongId}", with: movieSongIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: moviesong)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     uploadMovieSong
     
     - parameter file: (form) file 
     - parameter movieId: (path) movieId 
     - parameter movieSongId: (path) movieSongId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func uploadMovieSongUsingPOST(file: URL, movieId: Int64, movieSongId: Int64, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        uploadMovieSongUsingPOSTWithRequestBuilder(file: file, movieId: movieId, movieSongId: movieSongId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     uploadMovieSong
     - POST /api/v1/movie/{movieId}/uploadmoviesongs/{movieSongId}
     - examples: [{output=none}]
     
     - parameter file: (form) file 
     - parameter movieId: (path) movieId 
     - parameter movieSongId: (path) movieSongId 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func uploadMovieSongUsingPOSTWithRequestBuilder(file: URL, movieId: Int64, movieSongId: Int64) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/movie/{movieId}/uploadmoviesongs/{movieSongId}"
        let movieIdPreEscape = "\(movieId)"
        let movieIdPostEscape = movieIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieId}", with: movieIdPostEscape, options: .literal, range: nil)
        let movieSongIdPreEscape = "\(movieSongId)"
        let movieSongIdPostEscape = movieSongIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieSongId}", with: movieSongIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let formParams: [String:Any?] = [
            "file": file
        ]

        let nonNullParameters = APIHelper.rejectNil(formParams)
        let parameters = APIHelper.convertBoolToString(nonNullParameters)
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
