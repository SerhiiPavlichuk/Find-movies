//
//  TVShowRealmManager.swift
//  Find movies
//
//  Created by admin on 23.06.2022.
//

import Foundation
import RealmSwift

struct TVShowRealmManager {

    let realm = try? Realm()

       static let shared = TVShowRealmManager()

       private init() { }

       func saveTvShow(_ tvShow: TvShow, completion: @escaping(() -> ())) {

           let tvShowRealm = TvShowRealm()

        tvShowRealm.name = tvShow.name ?? ""
        tvShowRealm.popularity = tvShow.popularity ?? 0.0
        tvShowRealm.overview = tvShow.overview ?? ""
        tvShowRealm.id = tvShow.id ?? 0
        tvShowRealm.posterPath = tvShow.posterPath ?? ""

           try? realm?.write {
               realm?.add(tvShowRealm)
           }
           completion()
       }

       func getAllMovies(completion: ([TvShow])->()) {

           var tvShowRealm = [TvShowRealm]()
           guard let tvShowResults = realm?.objects(TvShowRealm.self) else { return }
           for tvShow in tvShowResults {
            tvShowRealm.append(tvShow)
           }

           completion(convertToMoviesList(tvShowsRealm: tvShowRealm))
       }

       private func convertToMoviesList(tvShowsRealm: [TvShowRealm]) -> [TvShow] {

           var tvShows = [TvShow]()
           for tvShowRealm in tvShowsRealm {
               let tvShow = TvShow(from: tvShowRealm)
            tvShows.append(tvShow)
           }
           return tvShows
       }
   }

