//
//  Constants.swift
//  Find movies
//
//  Created by admin on 09.06.2022.
//

import Foundation

struct Constants {

    struct network {

        static let apiKey = "32ea20e318793cf10469df41ffe5990d"
        static let defaultPath = "https://api.themoviedb.org/3/"
        static let keyForVideos = "/videos?api_key=\(apiKey)&language=en-US"
        static let defaultYoutubePath = "https://www.youtube.com/watch?v="

        static let tvShowPath = defaultPath + "tv/"
        static let trendingTVShowPath = "https://api.themoviedb.org/3/trending/tv/week?api_key"

        static let moviePath = defaultPath + "movie"
        static let movieActorsPath = "/credits?api_key=\(apiKey)&language=en-US"
        static let tvShowActorsPath = "/aggregate_credits?api_key=\(apiKey)&language=en-US"
        static let trendingMoviePath = "https://api.themoviedb.org/3/trending/movie/week?api_key"
        static let defaultImagePath = "https://image.tmdb.org/t/p/original"
        static let mediaWeb = "/watch/providers?api_key=\(apiKey)"

    }

    struct UI {
        static let movieCellIdentifier = "MoviesCollectionViewCell"
        static let tvShowCellIdentifier = "TVShowsCollectionViewCell"
        static let actorsCellIdentifier = "ActorsCollectionViewCell"
        static let headerIdentifier = "SectionHeaderReusableView"
        static let movieTableViewCell = "MoviesTableViewCell"
        static let tvTableViewCell = "TvTableViewCell"
        static let defaultImage = "defaultImage"
        static let mediaSavedAlert = "Saved"
        static let okMessage = "Ok"
    }
}
