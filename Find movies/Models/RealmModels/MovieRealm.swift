//
//  MovieRealm.swift
//  Find movies
//
//  Created by admin on 23.06.2022.
//

import Foundation
import RealmSwift

class MovieRealm: Object {
    @objc dynamic var title = ""
    @objc dynamic var voteAverage: Double = 0.0
    @objc dynamic var overview = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var posterPath = ""
    @objc dynamic var releaseDate = ""

}
