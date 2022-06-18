//
//  NetworkManager.swift
//  Find movies
//
//  Created by admin on 09.06.2022.
//

import Foundation
import Alamofire

struct NetworkManager {

    static let shared = NetworkManager()

    func requestTrendingMovies(completion: @escaping(([Movie]) -> ())) {
        let url = Constants.network.trendingMoviePath + "=\(Constants.network.apiKey)"
        AF.request(url).responseJSON { responce in
            let decoder = JSONDecoder()

            if let data = try? decoder.decode(PopularMovieResult.self, from: responce.data!) {
                let movies = data.movies ?? []
                completion(movies)
            }
        }
    }

    func requestTrendingTVShows(completion: @escaping(([TvShow]) -> ())) {
        let url = Constants.network.trendingTVShowPath + "=\(Constants.network.apiKey)"
        AF.request(url).responseJSON { responce in
            let decoder = JSONDecoder()

            if let data = try? decoder.decode(PopularTvShowResult.self, from: responce.data!) {
                let movies = data.tvShows ?? []
                completion(movies)
            }
        }
    }

    func requestMovieActors(movieId: Movie?, completion: @escaping(([Cast]?) -> ())) {
        if let movieIdForUrl = movieId?.id{
            let url = Constants.network.moviePath + "/\(movieIdForUrl)" + Constants.network.movieActorsPath

            AF.request(url).responseJSON { responce in
                let decoder = JSONDecoder()
                if let data = try? decoder.decode(CastAndCrewResult.self, from: responce.data!) {
                    let actors = data.cast ?? []
                    completion(actors)
                }
            }
        }
    }
}
