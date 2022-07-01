//
//  HomeScreenViewModel.swift
//  Find movies
//
//  Created by admin on 30.06.2022.
//

import Foundation

enum SectionType: Hashable {
    case movies([Movie])
    case tvShows([TvShow])
}

class HomeScreenViewModel {

    var sections = [SectionType]()

    func loadMovies(completion: @escaping(() -> ())) {
        NetworkManager.shared.requestTrendingMovies(completion: { movies in
            self.sections.append(.movies(movies))
            completion()
        })
    }

    func loadTVShows(completion: @escaping(() -> ())) {
        NetworkManager.shared.requestTrendingTVShows(completion: { tvShows in
            self.sections.append(.tvShows(tvShows))
            completion()
        })
    }
}
