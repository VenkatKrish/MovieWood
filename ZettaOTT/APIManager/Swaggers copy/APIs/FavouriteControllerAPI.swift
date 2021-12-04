//
// FavouriteControllerAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class FavouriteControllerAPI {
    /**
     all
     
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func allUsingGET5(completion: @escaping ((_ data: [Favourites]?,_ error: Error?) -> Void)) {
        allUsingGET5WithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     all
     - GET /api/v1/getmoviefavourites
     - examples: [{output=none}]

     - returns: RequestBuilder<[Favourites]> 
     */
    open class func allUsingGET5WithRequestBuilder() -> RequestBuilder<[Favourites]> {
        let path = "/api/v1/getmoviefavourites"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<[Favourites]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     deleteMovieFavourite
     
     - parameter favouriteId: (path) favouriteId 
     - parameter movieId: (path) movieId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteMovieFavouriteUsingDELETE(favouriteId: Int64, movieId: Int64, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        deleteMovieFavouriteUsingDELETEWithRequestBuilder(favouriteId: favouriteId, movieId: movieId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     deleteMovieFavourite
     - DELETE /api/v1/movie/{movieId}/favourites/{favouriteId}
     - examples: [{output=none}]
     
     - parameter favouriteId: (path) favouriteId 
     - parameter movieId: (path) movieId 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func deleteMovieFavouriteUsingDELETEWithRequestBuilder(favouriteId: Int64, movieId: Int64) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/movie/{movieId}/favourites/{favouriteId}"
        let favouriteIdPreEscape = "\(favouriteId)"
        let favouriteIdPostEscape = favouriteIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{favouriteId}", with: favouriteIdPostEscape, options: .literal, range: nil)
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
     movieSongs
     
     - parameter movieId: (path) movieId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func movieSongsUsingGET(movieId: Int64, completion: @escaping ((_ data: [Favourites]?,_ error: Error?) -> Void)) {
        movieSongsUsingGETWithRequestBuilder(movieId: movieId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     movieSongs
     - GET /api/v1/favourites/{movieId}
     - examples: [{output=none}]
     
     - parameter movieId: (path) movieId 

     - returns: RequestBuilder<[Favourites]> 
     */
    open class func movieSongsUsingGETWithRequestBuilder(movieId: Int64) -> RequestBuilder<[Favourites]> {
        var path = "/api/v1/favourites/{movieId}"
        let movieIdPreEscape = "\(movieId)"
        let movieIdPostEscape = movieIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieId}", with: movieIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<[Favourites]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     saveMovieFavourite
     
     - parameter favourite: (body) favourite 
     - parameter movieId: (path) movieId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func saveMovieFavouriteUsingPOST(favourite: Favourites, movieId: Int64, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        saveMovieFavouriteUsingPOSTWithRequestBuilder(favourite: favourite, movieId: movieId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     saveMovieFavourite
     - POST /api/v1/movie/{movieId}/favourites
     - examples: [{output=none}]
     
     - parameter favourite: (body) favourite 
     - parameter movieId: (path) movieId 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func saveMovieFavouriteUsingPOSTWithRequestBuilder(favourite: Favourites, movieId: Int64) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/movie/{movieId}/favourites"
        let movieIdPreEscape = "\(movieId)"
        let movieIdPostEscape = movieIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieId}", with: movieIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: favourite)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     updateFavourite
     
     - parameter favourite: (body) favourite 
     - parameter favouriteId: (path) favouriteId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateFavouriteUsingPUT(favourite: Favourites, favouriteId: Int64, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        updateFavouriteUsingPUTWithRequestBuilder(favourite: favourite, favouriteId: favouriteId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     updateFavourite
     - PUT /api/v1/favourites/{favouriteId}
     - examples: [{output=none}]
     
     - parameter favourite: (body) favourite 
     - parameter favouriteId: (path) favouriteId 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func updateFavouriteUsingPUTWithRequestBuilder(favourite: Favourites, favouriteId: Int64) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/favourites/{favouriteId}"
        let favouriteIdPreEscape = "\(favouriteId)"
        let favouriteIdPostEscape = favouriteIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{favouriteId}", with: favouriteIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: favourite)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
