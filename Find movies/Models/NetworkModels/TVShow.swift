//
//  TVShow.swift
//  Find movies
//
//  Created by admin on 09.06.2022.
//

import Foundation

struct TvShow : Codable, Hashable {
    var firstAirDate : String?
    var backdropPath : String?
    var genreIds : [Int]?
    var voteCount : Int?
    var originalLanguage : String?
    var voteAverage : Double?
    let posterPath : String?
    var originalName : String?
    var originCountry : [String]?
    let id : Int?
    let name : String?
    let overview : String?
    let popularity : Double?
    var mediaType : String?
    var ratingString: String {
        return String(format: "%.1f", voteAverage!)
    }

    enum CodingKeys: String, CodingKey {

        case firstAirDate = "first_air_date"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case voteCount = "vote_count"
        case originalLanguage = "original_language"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case originalName = "original_name"
        case originCountry = "origin_country"
        case id = "id"
        case name = "name"
        case overview = "overview"
        case popularity = "popularity"
        case mediaType = "media_type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        firstAirDate = try values.decodeIfPresent(String.self, forKey: .firstAirDate)
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath)
        genreIds = try values.decodeIfPresent([Int].self, forKey: .genreIds)
        voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount)
        originalLanguage = try values.decodeIfPresent(String.self, forKey: .originalLanguage)
        voteAverage = try values.decodeIfPresent(Double.self, forKey: .voteAverage)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
        originalName = try values.decodeIfPresent(String.self, forKey: .originalName)
        originCountry = try values.decodeIfPresent([String].self, forKey: .originCountry)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
        mediaType = try values.decodeIfPresent(String.self, forKey: .mediaType)
    }

    init(from tvShowRealm: TvShowRealm) {
          self.name = tvShowRealm.name
          self.popularity = tvShowRealm.popularity
          self.overview = tvShowRealm.overview
          self.id = tvShowRealm.id
          self.posterPath = tvShowRealm.posterPath
      }
}
