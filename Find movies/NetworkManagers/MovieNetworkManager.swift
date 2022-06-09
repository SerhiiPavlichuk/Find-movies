//
//  MovieNetworkManager.swift
//  Find movies
//
//  Created by admin on 09.06.2022.
//

import Foundation
import Alamofire

struct MovieNetworkManager {

    static let shared = MovieNetworkManager()

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
}
