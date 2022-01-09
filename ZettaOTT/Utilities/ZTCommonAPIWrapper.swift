//
//  ZTCommonAPIWrapper.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 11/11/21.
//

import Foundation
import UIKit
import Foundation
import Alamofire

open class ZTCommonAPIWrapper {
    /**
     authenticateToken
     
     - parameter tokenRequest: (body) tokenRequest
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func authenticateTokenUsingPOST(tokenRequest: TokenRequest, completion: @escaping ((_ data: LoginSuccessModel?,_ error: Error?) -> Void)) {
        UserControllerAPI.authenticateTokenUsingPOST(tokenRequest: tokenRequest) { response, error in
            completion(response, error)
        }
    }
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
    open class func streamNow(language: String? = nil, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, showinios: String? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, contenttype:String? = nil, completion: @escaping ((_ data: PageMoviePaymentStatus?,_ error: Error?) -> Void)) {
        if ZTAppSession.sharedInstance.getIsUserLoggedIn() {
            ZTPrivateAPIWrapper.streamingnowUsingGET(language: language, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, showinios: showinios, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged, contenttype:contenttype) { (response, error) in
                completion(response, error)
            }
        }else{
            ZTPublicAPIWrapper.streamingnowPublicUsingGET(language: language, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, showinios: showinios, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged, contenttype:contenttype) { (response, error) in
                completion(response, error)
            }
        }
    }
    
    /**
     search
     - parameter search: (query) search
     - parameter page: (query) page (optional, default to 0)
     - parameter size: (query) size (optional, default to 50)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func searchMoviesGET(search: String, page: Int? = nil, size: Int? = nil, completion: @escaping ((_ data: PageMovies?,_ error: Error?) -> Void)) {
        if ZTAppSession.sharedInstance.getIsUserLoggedIn() {
            ZTPrivateAPIWrapper.searchUsingGET(search: search, page: page, size: size) { (response, error) in
                completion(response, error)
            }
        }else{
            ZTPublicAPIWrapper.searchPublicMoviesUsingGET(search: search, page: page, size: size) { (response, error) in
                completion(response, error)
            }
        }
    }
    /**
     genresUsingGET
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func genresUsingGET(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageGenres?,_ error: Error?) -> Void)) {
        if ZTAppSession.sharedInstance.getIsUserLoggedIn() {
            ZTPrivateAPIWrapper.allGenrePrivateUsingGET6(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { (response, error) in
                completion(response, error)
            }
        }else{
            ZTPublicAPIWrapper.allGenrePublicUsingGET(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { (response, error) in
                completion(response, error)
            }
        }
    }
    /**
     upcomingMovies
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
    open class func upcomingMovies(language: String? = nil, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, showinios: String? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageMoviePaymentStatus?,_ error: Error?) -> Void)) {
        if ZTAppSession.sharedInstance.getIsUserLoggedIn() {
            ZTPrivateAPIWrapper.upcomingMoviesPrivateUsingGET(language: language, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, showinios: showinios, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { (response, error) in
                completion(response,error)
            }
        }else{
            ZTPublicAPIWrapper.upcomingMoviesPublicUsingGET(language: language, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, showinios: showinios, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { (response, error) in
                completion(response,error)
            }
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
        if ZTAppSession.sharedInstance.getIsUserLoggedIn() {
            ZTPrivateAPIWrapper.getWatchListUsingGET(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { (response, error) in
                completion(response, error)
            }
        }
    }
    /**
     getUser
     
     - parameter userId: (path) userId
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getUserUsingGET(userId: Int64, completion: @escaping ((_ data: Users?,_ error: Error?) -> Void)) {
        ZTPrivateAPIWrapper.getUserUsingGET(userId: userId) { (response, error) in
            completion(response, error)
        }
    }

    /**
     getMyProfile
     
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getMyProfileUsingGET(completion: @escaping ((_ data: AppUserModel?,_ error: Error?) -> Void)) {
        ZTPrivateAPIWrapper.getMyProfileUsingGET { (response, error) in
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
    open class func getbyMovieNameSearchUsingGET(movieName: String, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, showinios: String? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageMovies?,_ error: Error?) -> Void)) {
        if ZTAppSession.sharedInstance.getIsUserLoggedIn() {
            ZTPrivateAPIWrapper.getbyMovieNameUsingGET(movieName: movieName, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, showinios: showinios, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { (response, error) in
                completion(response, error)
            }
        }else{
            ZTPublicAPIWrapper.getbyMovieNamePublicUsingGET(movieName: movieName, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, showinios: showinios, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { (response, error) in
                completion(response, error)
            }
        }
    }
    
    /**
     allCollectionsUsingGET2
     
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func allCollectionsUsingGET2(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageMCollections?,_ error: Error?) -> Void)) {
        if ZTAppSession.sharedInstance.getIsUserLoggedIn() {
            ZTPrivateAPIWrapper.allCollectionPrivateUsingGET2(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { response, error in
                completion(response, error)
            }
        }else{
            ZTPublicAPIWrapper.allCollectionPublicUsingGET2(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { response, error in
                completion(response, error)
            }
        }
    }
    /**
     movieCollectionsById
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
    open class func movieCollectionsById(_id: Int64, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageMovieCollections?,_ error: Error?) -> Void)) {
        if ZTAppSession.sharedInstance.getIsUserLoggedIn() {
            ZTPrivateAPIWrapper.movieCollectionsByCollectionUsingGET(_id: _id, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { response, error in
                completion(response, error)
            }
        }else{
            ZTPublicAPIWrapper.movieCollectionsByCollectionPublicUsingGET(_id: _id, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { response, error in
                completion(response, error)
            }
        }
    }
    /**
     getAllLanguages
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getLanguages(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageLanguages?,_ error: Error?) -> Void)) {
        if ZTAppSession.sharedInstance.getIsUserLoggedIn() {
            ZTPrivateAPIWrapper.allPrivateLanguageUsingGET7(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { response, error in
                completion(response,error)
            }
        }else{
            ZTPublicAPIWrapper.allPublicUsingLanguageGET1(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { response, error in
                completion(response,error)
            }
        }
    }
    
    /**
     movieReviewsByMovie
     
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
    open class func movieReviewsByMovie(movieId: Int64, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageMovieReviews?,_ error: Error?) -> Void)) {
        if ZTAppSession.sharedInstance.getIsUserLoggedIn() {
            ZTPrivateAPIWrapper.movieReviewsByMoviePrivate(movieId: movieId, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { response, error in
                completion(response, error)
            }
        }else{
            ZTPublicAPIWrapper.movieReviewsByMoviePublic(movieId: movieId, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { response, error in
                completion(response, error)
            }
        }
    }
    /**
     allSubscription
     
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func allSubscription(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageSubscriptions?,_ error: Error?) -> Void)) {
        if ZTAppSession.sharedInstance.getIsUserLoggedIn() {
            ZTPrivateAPIWrapper.allSubscriptionPrivate(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { response, error in
                completion(response, error)
            }
        }else{
            ZTPublicAPIWrapper.allSubscriptionPublic(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { response, error in
                completion(response, error)
            }
        }
    }
    /**
     get
     
     - parameter _id: (path) id
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getUsingGET3(_id: Int64, completion: @escaping ((_ data: Subscriptions?,_ error: Error?) -> Void)) {
        SubscriptionControllerAPI.getUsingGET3(_id: _id) { response, error in
            completion(response, error)
        }
    }
    /**
     getMovieVideo
     
     - parameter movieId: (query) movieId
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getMovieVideoUsingGET(movieId: Int64, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        MovieControllerAPI.getMovieVideoUsingGET(movieId: movieId) { response, error in
            completion(response,error)
        }
    }
    /**
     getMovieVideoW
     
     - parameter playMovieRequest: (body) playMovieRequest
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getMovieVideoWUsingPOST(playMovieRequest: PlayMovieRequest, completion: @escaping ((_ data: MovieLinkModel?,_ error: Error?) -> Void)) {
        MovieControllerAPI.getMovieVideoWUsingPOST(playMovieRequest: playMovieRequest) { response, error in
            completion(response, error)
        }
    }
    /**
     saveMovieReview
     
     - parameter movieId: (path) movieId
     - parameter movieReview: (body) movieReview
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func saveMovieReviewUsingPOST(movieId: Int64, movieReview: MovieReviews, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        MovieReviewControllerAPI.saveMovieReviewUsingPOST(movieId: movieId, movieReview: movieReview) { response, error in
            completion(response, error)
        }
    }
    /**
     allOrders
     
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func allOrders(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageOrders?,_ error: Error?) -> Void)) {
        OrderControllerAPI.userOrdersUsingGET(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { response, error in
            completion(response,error)
        }
    }
    /**
     saveMovieOrder
     
     - parameter movieId: (path) movieId
     - parameter order: (body) order
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func saveMovieOrderUsingPOST(movieId: Int64, order: Orders, completion: @escaping ((_ data: OrderConfirmation?,_ error: Error?) -> Void)) {
        
        OrderControllerAPI.saveMovieOrderUsingPOST(movieId: movieId, order: order) { response, error in
            completion(response, error)
        }
    }
    /**
     updateOrderPayment
     
     - parameter orderId: (path) orderId
     - parameter paymentRequest: (body) paymentRequest
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateOrderPayment(orderId: Int64, paymentRequest: PaymentRequest, completion: @escaping ((_ data: OrderConfirmPayment?,_ error: Error?) -> Void)) {
        OrderControllerAPI.updateOrderPaymentUsingPUT(orderId: orderId, paymentRequest: paymentRequest) { response, error in
            completion(response, error)
        }
    }
    /**
     getMovie
     
     - parameter movieId: (path) movieId
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getMovieUsingGET(movieId: Int64, completion: @escaping ((_ data: Movies?,_ error: Error?) -> Void)) {
        MovieControllerAPI.getMovieUsingGET(movieId: movieId) { response, error in
            completion(response, error)
        }
    }
    /**
     getFAQs
     
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getFAQs(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageFaqs?,_ error: Error?) -> Void)) {
        FaqControllerAPI.allPublicUsingGET(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { response, error in
            completion(response,error)
        }
    }
    /**
     movieSeasonsByMovieCommon
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
    open class func movieSeasonsByMovieCommon(movieId: Int64, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageMovieSeasons?,_ error: Error?) -> Void)) {
        if ZTAppSession.sharedInstance.getIsUserLoggedIn() {
            ZTPrivateAPIWrapper.movieSeasonsByMoviePrivate(movieId: movieId, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { response, error in
                completion(response, error)
            }
        }else{
            ZTPublicAPIWrapper.movieSeasonsByMoviePublicUsingGET(movieId: movieId, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged) { response, error in
                completion(response, error)
            }
        }
    }
    /**
     updateMovieGenre
     
     - parameter moviePlay: (body) moviePlay
     - parameter moviePlayId: (path) moviePlayId
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateMoviePlayTime(moviePlay: MoviePlays, moviePlayId: Int64, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        MoviePlayControllerAPI.updateMovieGenreUsingPUT1(moviePlay: moviePlay, moviePlayId: moviePlayId) { response, error in
            completion(response, error)
        }
    }
}
