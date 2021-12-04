//
// MovieGenres.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct MovieGenres: Codable {

    public var active: String?
    public var createdBy: String?
    public var createdOn: Date?
    public var genre: Genres?
    public var genreId: Int64?
    public var lastUpdateLogin: String?
    public var modifiedBy: String?
    public var modifiedOn: Date?
    public var movieGenreId: Int64?
    public var movieId: Int64?
    public var ordering: Int64?
    public var versionNumber: Int64?

    public init(active: String?, createdBy: String?, createdOn: Date?, genre: Genres?, genreId: Int64?, lastUpdateLogin: String?, modifiedBy: String?, modifiedOn: Date?, movieGenreId: Int64?, movieId: Int64?, ordering: Int64?, versionNumber: Int64?) {
        self.active = active
        self.createdBy = createdBy
        self.createdOn = createdOn
        self.genre = genre
        self.genreId = genreId
        self.lastUpdateLogin = lastUpdateLogin
        self.modifiedBy = modifiedBy
        self.modifiedOn = modifiedOn
        self.movieGenreId = movieGenreId
        self.movieId = movieId
        self.ordering = ordering
        self.versionNumber = versionNumber
    }


}

