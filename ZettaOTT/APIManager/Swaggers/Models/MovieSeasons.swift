//
// MovieSeasons.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct MovieSeasons: Codable {

    public var active: String?
    public var createdBy: String?
    public var createdOn: Date?
    public var _description: String?
    public var lastUpdateLogin: String?
    public var modifiedBy: String?
    public var modifiedOn: Date?
    public var movieEpisodes: [MovieEpisodes]?
    public var movieId: Int64?
    public var name: String?
    public var noOfEpisodes: Int64?
    public var ordering: Int64?
    public var seasonId: Int64?
    public var versionNumber: Int64?

    public init(active: String?, createdBy: String?, createdOn: Date?, _description: String?, lastUpdateLogin: String?, modifiedBy: String?, modifiedOn: Date?, movieEpisodes: [MovieEpisodes]?, movieId: Int64?, name: String?, noOfEpisodes: Int64?, ordering: Int64?, seasonId: Int64?, versionNumber: Int64?) {
        self.active = active
        self.createdBy = createdBy
        self.createdOn = createdOn
        self._description = _description
        self.lastUpdateLogin = lastUpdateLogin
        self.modifiedBy = modifiedBy
        self.modifiedOn = modifiedOn
        self.movieEpisodes = movieEpisodes
        self.movieId = movieId
        self.name = name
        self.noOfEpisodes = noOfEpisodes
        self.ordering = ordering
        self.seasonId = seasonId
        self.versionNumber = versionNumber
    }

    public enum CodingKeys: String, CodingKey { 
        case active
        case createdBy
        case createdOn
        case _description = "description"
        case lastUpdateLogin
        case modifiedBy
        case modifiedOn
        case movieEpisodes
        case movieId
        case name
        case noOfEpisodes
        case ordering
        case seasonId
        case versionNumber
    }


}

