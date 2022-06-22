//
//  Movie.swift
//  Find movies
//
//  Created by admin on 09.06.2022.
//

import Foundation

struct Movie: Codable {

    var adult: Bool?
    let id: Int?
    var genreIds: [Int]?
    var originalLanguage: String?
    var originalTitle: String?
    let posterPath: String?
    var video: Bool?
    var voteAverage: Double?
    let overview: String?
    var releaseDate: String?
    var voteCount: Int?
    let title: String?
    let popularity: Double?
    var mediaType: String?

    enum CodingKeys: String, CodingKey {

        case adult = "adult"
        case id = "id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case video = "video"
        case voteAverage = "vote_average"
        case overview = "overview"
        case releaseDate = "release_date"
        case voteCount = "vote_count"
        case title = "title"
        case popularity = "popularity"
        case mediaType = "media_type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        originalLanguage = try values.decodeIfPresent(String.self, forKey: .originalLanguage)
        originalTitle = try values.decodeIfPresent(String.self, forKey: .originalTitle)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
        video = try values.decodeIfPresent(Bool.self, forKey: .video)
        voteAverage = try values.decodeIfPresent(Double.self, forKey: .voteAverage)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
        voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
        mediaType = try values.decodeIfPresent(String.self, forKey: .mediaType)
    }
}