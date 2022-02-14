//
//  ZTPrivateAPIWrapper.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 11/11/21.
//

import UIKit
import Foundation
import Alamofire

open class ZTPrivateAPIWrapper {
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
    open class func streamingnowUsingGET(language: String? = nil, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, showinios: String? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, contenttype:String? = nil, sort:String? = nil, completion: @escaping ((_ data: PageMoviePaymentStatus?,_ error: Error?) -> Void)) {
        MovieControllerAPI.streamingnowUsingGET(language: language, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, showinios: showinios, sortSorted: true, sortUnsorted: sortUnsorted, unpaged: unpaged, contenttype:contenttype, sort:sort) { (response, error) in
            completion(response, error)
        }

    }
    /**
     search
     
     - parameter search: (query) search
     - parameter page: (query) page (optional, default to 0)
     - parameter size: (query) size (optional, default to 50)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func searchUsingGET(search: String, page: Int? = nil, size: Int? = nil, completion: @escaping ((_ data: PageMovies?,_ error: Error?) -> Void)) {
        MovieControllerAPI.searchUsingGET(search: search, page: page, size: size) { (response, error) in
            completion(response, error)
        }
    }
    /**
     allGenrePrivateUsingGET6
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func allGenrePrivateUsingGET6(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageGenres?,_ error: Error?) -> Void)) {
        GenreControllerAPI.allUsingGET6(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { (response, error) in
            completion(response, error)
        }
    }
    /**
     upcomingMoviesPrivateUsingGET
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
    open class func upcomingMoviesPrivateUsingGET(language: String? = nil, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, showinios: String? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, sort:String? = nil, completion: @escaping ((_ data: PageMoviePaymentStatus?,_ error: Error?) -> Void)) {
        MovieControllerAPI.upcomingMoviesUsingGET(language: language, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, showinios: showinios, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged, sort: sort) { response, error in
            completion(response,error)
        }
    }
    /**
     getWatchList
     
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getWatchListUsingGET(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageMovies?,_ error: Error?) -> Void)) {
        MovieControllerAPI.getWatchListUsingGET(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { (response, error) in
            completion(response, error)
        }
    }
    /**
     getUser
     
     - parameter userId: (path) userId
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getUserUsingGET(userId: Int64, completion: @escaping ((_ data: Users?,_ error: Error?) -> Void)) {
        UserControllerAPI.getUserUsingGET(userId: userId) { (response, error) in
            completion(response, error)
        }
    }

    /**
     getMyProfile
     
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getMyProfileUsingGET(completion: @escaping ((_ data: AppUserModel?,_ error: Error?) -> Void)) {
        UserControllerAPI.getMyProfileUsingGET { (response, error) in
            completion(response, error)
        }
    }
    /**
     getbyMovieName
     
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
    open class func getbyMovieNameUsingGET(movieName: String, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, showinios: String? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageMovies?,_ error: Error?) -> Void)) {
        MovieControllerAPI.getbyMovieNameUsingGET(movieName: movieName, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, showinios: showinios, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { (response, error) in
            completion(response, error)
        }
    }
    /**
     allCollectionPrivateUsingGET2
     
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func allCollectionPrivateUsingGET2(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageMCollections?,_ error: Error?) -> Void)) {
        
        MCollectionControllerAPI.allUsingGET8(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { response, error in
            completion(response, error)
        }
    }
    /**
     movieCollectionsByCollectionUsingGET
     
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
    open class func movieCollectionsByCollectionUsingGET(_id: Int64, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageMovieCollections?,_ error: Error?) -> Void)) {
        MovieCollectionControllerAPI.movieCollectionsByCollectionUsingGET(_id: _id, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { response, error in
            completion(response, error)

        }
    }
    /**
     allLanguagesPrivate
     
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func allPrivateLanguageUsingGET7(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageLanguages?,_ error: Error?) -> Void)) {
        LanguageControllerAPI.allUsingGET7(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { response, error in
            completion(response,error)
        }
    }
    /**
     movieReviewsByMoviePrivate
     
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
    open class func movieReviewsByMoviePrivate(movieId: Int64, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, sort:String? = nil, completion: @escaping ((_ data: PageMovieReviews?,_ error: Error?) -> Void)) {
        MovieReviewControllerAPI.movieReviewsByMovieUsingGET(movieId: movieId, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged, sort:sort) { response, error in
            completion(response, error)
        }
    }
    /**
     allSubscriptionPrivate
     
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func allSubscriptionPrivate(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageSubscriptions?,_ error: Error?) -> Void)) {
        SubscriptionControllerAPI.allUsingGET28(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { response, error in
            completion(response, error)
        }
    }
    /**
     movieSeasonsByMoviePrivate
     
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
    open class func movieSeasonsByMoviePrivate(movieId: Int64, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageMovieSeasons?,_ error: Error?) -> Void)) {
        MovieSeasonControllerAPI.movieSeasonsByMovieUsingGET(movieId: movieId, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { response, error in
            completion(response, error)
        }
    }
}
