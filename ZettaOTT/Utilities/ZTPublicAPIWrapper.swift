//
//  ZTPublicAPIWrapper.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 11/11/21.
//

import UIKit
import Foundation
import Alamofire

open class ZTPublicAPIWrapper {
    /**
     streamingnow
     
     - parameter language: (query) language (optional)
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter showinios: (query) showinios (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func streamingnowPublicUsingGET(language: String? = nil, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, showinios: String? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, contenttype:String? = nil, sort:String? = nil, completion: @escaping ((_ data: PageMoviePaymentStatus?,_ error: Error?) -> Void)) {
        MovieControllerAPI.streamingnowPublicUsingGET(pageNumber: pageNumber, pageSize: pageSize, sortSorted: true, contenttype:contenttype, sort:sort) { (response, error) in
            completion(response, error)
        }

    }
    
    /**
     searchPublicMovies
     
     - parameter search: (query) search
     - parameter page: (query) page (optional, default to 0)
     - parameter size: (query) size (optional, default to 50)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func searchPublicMoviesUsingGET(search: String, page: Int? = nil, size: Int? = nil, completion: @escaping ((_ data: PageMovies?,_ error: Error?) -> Void)) {
        MovieControllerAPI.searchPublicMoviesUsingGET(search: search, page: page, size: size) { (response, error) in
            completion(response, error)
        }
    }
    /**
     allGenrePublicUsingGET
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func allGenrePublicUsingGET(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageGenres?,_ error: Error?) -> Void)) {
        GenreControllerAPI.allPublicUsingGET(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { (response, error) in
            completion(response, error)
        }
    }
    /**
     upcomingMoviesPublic
     - parameter language: (query) language (optional)
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter showinios: (query) showinios (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func upcomingMoviesPublicUsingGET(language: String? = nil, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, showinios: String? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, sort:String? = nil, completion: @escaping ((_ data: PageMoviePaymentStatus?,_ error: Error?) -> Void)) {
        MovieControllerAPI.upcomingMoviesPublicUsingGET(language: language, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, showinios: showinios, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged, sort: sort) { response, error in
            completion(response, error)
        }
    }
    /**
     getbyMovieNamePublic
     
     - parameter movieName: (query) movieName
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter showinios: (query) showinios (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getbyMovieNamePublicUsingGET(movieName: String, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, showinios: String? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageMovies?,_ error: Error?) -> Void)) {
        MovieControllerAPI.getbyMovieNamePublicUsingGET(movieName: movieName, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, showinios: showinios, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { (response, error) in
            completion(response, error)
        }
    }
    
    /**
     allCollectionPublicUsingGET2
     
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func allCollectionPublicUsingGET2(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageMCollections?,_ error: Error?) -> Void)) {
        
        MCollectionControllerAPI.allPublicUsingGET2(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { response, error in
            completion(response, error)
        }
    }
    
    /**
     movieCollectionsByCollectionPublic
     
     - parameter _id: (path) id
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func movieCollectionsByCollectionPublicUsingGET(_id: Int64, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageMovieCollections?,_ error: Error?) -> Void)) {
        MovieCollectionControllerAPI.movieCollectionsByCollectionPublicUsingGET(_id: _id, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { response, error in
            completion(response, error)

        }
    }
    /**
     allPublicLanguage
     
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func allPublicUsingLanguageGET1(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageLanguages?,_ error: Error?) -> Void)) {
        LanguageControllerAPI.allPublicUsingGET1(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { response, error in
            completion(response,error)
        }
    }
    /**
     movieReviewsByMoviePublic
     
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
    open class func movieReviewsByMoviePublic(movieId: Int64, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageMovieReviews?,_ error: Error?) -> Void)) {
        MovieReviewControllerAPI.movieReviewsByMoviePublicUsingGET(movieId: movieId, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { response, error in
            completion(response, error)
        }
    }
    /**
     allSubscriptionPublic
     
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func allSubscriptionPublic(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageSubscriptions?,_ error: Error?) -> Void)) {
        SubscriptionControllerAPI.allPublicUsingGET6(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { response, error in
            completion(response, error)
        }
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
        MovieSeasonControllerAPI.movieSeasonsByMoviePublicUsingGET(movieId: movieId, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { response, error in
            completion(response, error)
        }
    }
}
