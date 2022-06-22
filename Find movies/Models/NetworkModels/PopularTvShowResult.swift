//
//  PopularTvShowResult.swift
//  Find movies
//
//  Created by admin on 09.06.2022.
//

import Foundation

struct PopularTvShowResult : Codable {
    let page : Int?
    let tvShows : [TvShow]?
    let totalPages : Int?
    let totalResults : Int?

    enum CodingKeys: String, CodingKey {

        case page = "page"
        case tvShows = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        tvShows = try values.decodeIfPresent([TvShow].self, forKey: .tvShows)
        totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
        totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
    }
}
