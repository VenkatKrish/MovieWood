//
// Pageable.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct Pageable: Codable {

    public var offset: Int64?
    public var pageNumber: Int?
    public var pageSize: Int?
    public var paged: Bool?
    public var sort: Sort?
    public var unpaged: Bool?

    public init(offset: Int64?, pageNumber: Int?, pageSize: Int?, paged: Bool?, sort: Sort?, unpaged: Bool?) {
        self.offset = offset
        self.pageNumber = pageNumber
        self.pageSize = pageSize
        self.paged = paged
        self.sort = sort
        self.unpaged = unpaged
    }


}

