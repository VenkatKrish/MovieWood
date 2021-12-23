//
// OrderControllerAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class OrderControllerAPI {
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
    open class func allUsingGET23(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageOrders?,_ error: Error?) -> Void)) {
        allUsingGET23WithRequestBuilder(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     all
     - GET /api/v1/getallorders
     - examples: [{output=none}]
     
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)

     - returns: RequestBuilder<PageOrders> 
     */
    open class func allUsingGET23WithRequestBuilder(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil) -> RequestBuilder<PageOrders> {
        let path = "/api/v1/getallorders"
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

        let requestBuilder: RequestBuilder<PageOrders>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     capturePayments
     
     - parameter runKey: (body) runKey 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func capturePaymentsUsingPOST(runKey: JSONValue, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        capturePaymentsUsingPOSTWithRequestBuilder(runKey: runKey).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     capturePayments
     - POST /api/v1/public/orders/capturepayments
     - examples: [{contentType=application/json, example={
  "bytes": [
    123,
    125
  ],
  "empty": false
}}]
     
     - parameter runKey: (body) runKey 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func capturePaymentsUsingPOSTWithRequestBuilder(runKey: JSONValue) -> RequestBuilder<JSONValue> {
        let path = "/api/v1/public/orders/capturepayments"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: runKey)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     createRazorOrder
     
     - parameter order: (body) order 
     - parameter orderId: (path) orderId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func createRazorOrderUsingPUT(order: Orders, orderId: Int64, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        createRazorOrderUsingPUTWithRequestBuilder(order: order, orderId: orderId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     createRazorOrder
     - PUT /api/v1/razororders/{orderId}
     - examples: [{output=none}]
     
     - parameter order: (body) order 
     - parameter orderId: (path) orderId 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func createRazorOrderUsingPUTWithRequestBuilder(order: Orders, orderId: Int64) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/razororders/{orderId}"
        let orderIdPreEscape = "\(orderId)"
        let orderIdPostEscape = orderIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{orderId}", with: orderIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: order)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     deleteMovieOrder
     
     - parameter movieId: (path) movieId 
     - parameter orderId: (path) orderId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteMovieOrderUsingDELETE(movieId: Int64, orderId: Int64, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        deleteMovieOrderUsingDELETEWithRequestBuilder(movieId: movieId, orderId: orderId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     deleteMovieOrder
     - DELETE /api/v1/movie/{movieId}/orders/{orderId}
     - examples: [{output=none}]
     
     - parameter movieId: (path) movieId 
     - parameter orderId: (path) orderId 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func deleteMovieOrderUsingDELETEWithRequestBuilder(movieId: Int64, orderId: Int64) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/movie/{movieId}/orders/{orderId}"
        let movieIdPreEscape = "\(movieId)"
        let movieIdPostEscape = movieIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieId}", with: movieIdPostEscape, options: .literal, range: nil)
        let orderIdPreEscape = "\(orderId)"
        let orderIdPostEscape = orderIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{orderId}", with: orderIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     getOrder
     
     - parameter orderId: (path) orderId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getOrderUsingGET(orderId: Int64, completion: @escaping ((_ data: Orders?,_ error: Error?) -> Void)) {
        getOrderUsingGETWithRequestBuilder(orderId: orderId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     getOrder
     - GET /api/v1/orders/{orderId}
     - examples: [{output=none}]
     
     - parameter orderId: (path) orderId 

     - returns: RequestBuilder<Orders> 
     */
    open class func getOrderUsingGETWithRequestBuilder(orderId: Int64) -> RequestBuilder<Orders> {
        var path = "/api/v1/orders/{orderId}"
        let orderIdPreEscape = "\(orderId)"
        let orderIdPostEscape = orderIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{orderId}", with: orderIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<Orders>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     movieOrders
     
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
    open class func movieOrdersUsingGET(movieId: Int64, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageOrders?,_ error: Error?) -> Void)) {
        movieOrdersUsingGETWithRequestBuilder(movieId: movieId, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     movieOrders
     - GET /api/v1/movieorders/{movieId}
     - examples: [{output=none}]
     
     - parameter movieId: (path) movieId 
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)

     - returns: RequestBuilder<PageOrders> 
     */
    open class func movieOrdersUsingGETWithRequestBuilder(movieId: Int64, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil) -> RequestBuilder<PageOrders> {
        var path = "/api/v1/movieorders/{movieId}"
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

        let requestBuilder: RequestBuilder<PageOrders>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     myMovieOrders
     
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
    open class func myMovieOrdersUsingGET(movieId: Int64, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageOrders?,_ error: Error?) -> Void)) {
        myMovieOrdersUsingGETWithRequestBuilder(movieId: movieId, offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     myMovieOrders
     - GET /api/v1/mymovieorders/{movieId}
     - examples: [{output=none}]
     
     - parameter movieId: (path) movieId 
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)

     - returns: RequestBuilder<PageOrders> 
     */
    open class func myMovieOrdersUsingGETWithRequestBuilder(movieId: Int64, offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil) -> RequestBuilder<PageOrders> {
        var path = "/api/v1/mymovieorders/{movieId}"
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

        let requestBuilder: RequestBuilder<PageOrders>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     saveMovieOrder
     
     - parameter movieId: (path) movieId 
     - parameter order: (body) order 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func saveMovieOrderUsingPOST(movieId: Int64, order: Orders, completion: @escaping ((_ data: OrderConfirmation?,_ error: Error?) -> Void)) {
        saveMovieOrderUsingPOSTWithRequestBuilder(movieId: movieId, order: order).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     saveMovieOrder
     - POST /api/v1/movie/{movieId}/orders
     - examples: [{output=none}]
     
     - parameter movieId: (path) movieId 
     - parameter order: (body) order 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func saveMovieOrderUsingPOSTWithRequestBuilder(movieId: Int64, order: Orders) -> RequestBuilder<OrderConfirmation> {
        var path = "/api/v1/movie/{movieId}/orders"
        let movieIdPreEscape = "\(movieId)"
        let movieIdPostEscape = movieIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{movieId}", with: movieIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: order)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<OrderConfirmation>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     searchPublicMovies
     
     - parameter search: (query) search 
     - parameter page: (query) page (optional, default to 0)
     - parameter size: (query) size (optional, default to 50)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func searchPublicMoviesUsingGET1(search: String, page: Int? = nil, size: Int? = nil, completion: @escaping ((_ data: ResponseEntity?,_ error: Error?) -> Void)) {
        searchPublicMoviesUsingGET1WithRequestBuilder(search: search, page: page, size: size).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     searchPublicMovies
     - GET /api/v1/searchorders
     - examples: [{output=none}]
     
     - parameter search: (query) search 
     - parameter page: (query) page (optional, default to 0)
     - parameter size: (query) size (optional, default to 50)

     - returns: RequestBuilder<ResponseEntity> 
     */
    open class func searchPublicMoviesUsingGET1WithRequestBuilder(search: String, page: Int? = nil, size: Int? = nil) -> RequestBuilder<ResponseEntity> {
        let path = "/api/v1/searchorders"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "page": page?.encodeToJSON(), 
            "search": search, 
            "size": size?.encodeToJSON()
        ])

        let requestBuilder: RequestBuilder<ResponseEntity>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     updateOrderPaymentConfirmation
     
     - parameter paymentConfirmationRequest: (body) paymentConfirmationRequest 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateOrderPaymentConfirmationUsingPOST(paymentConfirmationRequest: JSONValue, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        updateOrderPaymentConfirmationUsingPOSTWithRequestBuilder(paymentConfirmationRequest: paymentConfirmationRequest).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     updateOrderPaymentConfirmation
     - POST /api/v1/public/razororderpaymentconfirmation
     - examples: [{contentType=application/json, example={
  "bytes": [
    123,
    125
  ],
  "empty": false
}}]
     
     - parameter paymentConfirmationRequest: (body) paymentConfirmationRequest 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func updateOrderPaymentConfirmationUsingPOSTWithRequestBuilder(paymentConfirmationRequest: JSONValue) -> RequestBuilder<JSONValue> {
        let path = "/api/v1/public/razororderpaymentconfirmation"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: paymentConfirmationRequest)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     updateOrderPayment
     
     - parameter orderId: (path) orderId 
     - parameter paymentRequest: (body) paymentRequest 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateOrderPaymentUsingPUT(orderId: Int64, paymentRequest: PaymentRequest, completion: @escaping ((_ data: OrderConfirmPayment?,_ error: Error?) -> Void)) {
        updateOrderPaymentUsingPUTWithRequestBuilder(orderId: orderId, paymentRequest: paymentRequest).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     updateOrderPayment
     - PUT /api/v1/orderpayment/{orderId}
     - examples: [{output=none}]
     
     - parameter orderId: (path) orderId 
     - parameter paymentRequest: (body) paymentRequest 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func updateOrderPaymentUsingPUTWithRequestBuilder(orderId: Int64, paymentRequest: PaymentRequest) -> RequestBuilder<OrderConfirmPayment> {
        var path = "/api/v1/orderpayment/{orderId}"
        let orderIdPreEscape = "\(orderId)"
        let orderIdPostEscape = orderIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{orderId}", with: orderIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: paymentRequest)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<OrderConfirmPayment>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     updateOrder
     
     - parameter order: (body) order 
     - parameter orderId: (path) orderId 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateOrderUsingPUT(order: Orders, orderId: Int64, completion: @escaping ((_ data: JSONValue?,_ error: Error?) -> Void)) {
        updateOrderUsingPUTWithRequestBuilder(order: order, orderId: orderId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     updateOrder
     - PUT /api/v1/orders/{orderId}
     - examples: [{output=none}]
     
     - parameter order: (body) order 
     - parameter orderId: (path) orderId 

     - returns: RequestBuilder<JSONValue> 
     */
    open class func updateOrderUsingPUTWithRequestBuilder(order: Orders, orderId: Int64) -> RequestBuilder<JSONValue> {
        var path = "/api/v1/orders/{orderId}"
        let orderIdPreEscape = "\(orderId)"
        let orderIdPostEscape = orderIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{orderId}", with: orderIdPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: order)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<JSONValue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     userOrders
     
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func userOrdersUsingGET(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil, completion: @escaping ((_ data: PageOrders?,_ error: Error?) -> Void)) {
        userOrdersUsingGETWithRequestBuilder(offset: offset, pageNumber: pageNumber, pageSize: pageSize, paged: paged, sortSorted: sortSorted, sortUnsorted: sortUnsorted, unpaged: unpaged).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     userOrders
     - GET /api/v1/getmovieorders
     - examples: [{output=none}]
     
     - parameter offset: (query)  (optional)
     - parameter pageNumber: (query)  (optional)
     - parameter pageSize: (query)  (optional)
     - parameter paged: (query)  (optional)
     - parameter sortSorted: (query)  (optional)
     - parameter sortUnsorted: (query)  (optional)
     - parameter unpaged: (query)  (optional)

     - returns: RequestBuilder<PageOrders> 
     */
    open class func userOrdersUsingGETWithRequestBuilder(offset: Int64? = nil, pageNumber: Int? = nil, pageSize: Int? = nil, paged: Bool? = nil, sortSorted: Bool? = nil, sortUnsorted: Bool? = nil, unpaged: Bool? = nil) -> RequestBuilder<PageOrders> {
        let path = "/api/v1/getmovieorders"
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

        let requestBuilder: RequestBuilder<PageOrders>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
