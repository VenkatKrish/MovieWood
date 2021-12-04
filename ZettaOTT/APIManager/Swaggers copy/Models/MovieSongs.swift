//
// MovieSongs.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct MovieSongs: Codable {

    public var active: String?
    public var createdBy: String?
    public var createdOn: Date?
    public var lastUpdateLogin: String?
    public var modifiedBy: String?
    public var modifiedOn: Date?
    public var movieId: Int64?
    public var movieSongId: Int64?
    public var ordering: Int64?
    public var plays: Int64?
    public var songThumbnailImage: String?
    public var songTitle: String?
    public var songUrl: String?
    public var versionNumber: Int64?

    public init(active: String?, createdBy: String?, createdOn: Date?, lastUpdateLogin: String?, modifiedBy: String?, modifiedOn: Date?, movieId: Int64?, movieSongId: Int64?, ordering: Int64?, plays: Int64?, songThumbnailImage: String?, songTitle: String?, songUrl: String?, versionNumber: Int64?) {
        self.active = active
        self.createdBy = createdBy
        self.createdOn = createdOn
        self.lastUpdateLogin = lastUpdateLogin
        self.modifiedBy = modifiedBy
        self.modifiedOn = modifiedOn
        self.movieId = movieId
        self.movieSongId = movieSongId
        self.ordering = ordering
        self.plays = plays
        self.songThumbnailImage = songThumbnailImage
        self.songTitle = songTitle
        self.songUrl = songUrl
        self.versionNumber = versionNumber
    }


}

