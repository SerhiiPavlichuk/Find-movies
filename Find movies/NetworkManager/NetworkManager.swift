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

    func requestTVShowActors(tvShowId: TvShow?, completion: @escaping(([Cast]?) -> ())) {
        if let tvShowIdForUrl = tvShowId?.id{
            let url = Constants.network.tvShowPath + "/\(tvShowIdForUrl)" + Constants.network.tvShowActorsPath

            AF.request(url).responseJSON { responce in
                let decoder = JSONDecoder()
                if let data = try? decoder.decode(CastAndCrewResult.self, from: responce.data!) {
                    let actors = data.cast ?? []
                    completion(actors)
                }
            }
        }
    }

    func requestMovieURL(movieId: Movie?, completion: @escaping((String?) -> ())) {
        if let movieIdForUrl = movieId?.id{
            let url = Constants.network.moviePath + "/\(movieIdForUrl)" + Constants.network.mediaWeb

            AF.request(url).responseJSON { responce in
                let decoder = JSONDecoder()
                if let data = try? decoder.decode(ForWeb.self, from: responce.data!) {
                    let url = data.results?.gB
                    completion(url?.link)
                }
            }
        }
    }

    func requestTVShowURL(tvShowId: TvShow?, completion: @escaping((String?) -> ())) {
        if let tvShowIdForUrl = tvShowId?.id{
            let url = Constants.network.tvShowPath + "/\(tvShowIdForUrl)" + Constants.network.mediaWeb

            AF.request(url).responseJSON { responce in
                let decoder = JSONDecoder()
                if let data = try? decoder.decode(ForWeb.self, from: responce.data!) {
                    let url = data.results?.gB
                    completion(url?.link)
                }
            }
        }
    }
}
