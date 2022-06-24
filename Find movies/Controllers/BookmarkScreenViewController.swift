//
//  BookmarkScreenViewController.swift
//  Find movies
//
//  Created by admin on 08.06.2022.
//

import Foundation
import UIKit
import SnapKit
import RealmSwift

class BookmarkScreenViewController: UIViewController {

    private let realm = try? Realm()
    private var tvShows: [TvShowRealm] = []
    private var movies: [MovieRealm] = []


    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        return tableView
    }()

    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControll = UISegmentedControl(items: ["Movies", "TVShows"])
        segmentedControll.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
        segmentedControll.selectedSegmentIndex = 0
        segmentedControll.backgroundColor = .customGray
        return segmentedControll
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        setupTableView()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tvShows = getTvShow()
        movies = getMovie()
        tableView.reloadData()

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
        
    }

    @objc private func segmentedControlChanged() {
        tableView.reloadData()
    }

    private func setupTableView() {
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: Constants.UI.movieTableViewCell)
        tableView.register(TvTableViewCell.self, forCellReuseIdentifier: Constants.UI.tvTableViewCell)
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func getTvShow() -> [TvShowRealm] {
        var tvShow = [TvShowRealm]()
        guard let tvShowResult = realm?.objects(TvShowRealm.self) else { return [] }
        for tvshow in tvShowResult {
            tvShow.append(tvshow)
        }
        return tvShow
    }

    private func getMovie() -> [MovieRealm] {
        var movies = [MovieRealm]()
        guard let movieResult = realm?.objects(MovieRealm.self) else { return [] }
        for movie in movieResult {
            movies.append(movie)
        }
        return movies
    }

    private func setupConstraints() {
        view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.left.right.equalToSuperview().inset(100)
            make.height.equalTo(30)
        }

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp_bottomMargin).inset(-20)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

extension BookmarkScreenViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let selectedIndex = segmentedControl.selectedSegmentIndex
        switch selectedIndex {
        case 0:
            return movies.count
        case 1:
            return tvShows.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedIndex = segmentedControl.selectedSegmentIndex
        switch selectedIndex {
        case 0:
            let movieCell = tableView.dequeueReusableCell(withIdentifier: Constants.UI.movieTableViewCell, for: indexPath) as? MoviesTableViewCell
            let movieMedia = movies[indexPath.row]
            let movieImagePathString = Constants.network.defaultImagePath + movieMedia.posterPath
            movieCell?.movieConfigureWith(imageURL: URL(string: movieImagePathString),
                                          movieName: movieMedia.title)
            return movieCell ?? UITableViewCell()
        case 1:
            let tvShowCell = tableView.dequeueReusableCell(withIdentifier: Constants.UI.tvTableViewCell, for: indexPath) as? TvTableViewCell

            let tvShowMedia = tvShows[indexPath.row]
            let tvShowImagePathString = Constants.network.defaultImagePath + tvShowMedia.posterPath
            tvShowCell?.tvShowConfigureWith(imageURL: URL(string: tvShowImagePathString),
                                            tvShowName: tvShowMedia.name)
            return tvShowCell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}
