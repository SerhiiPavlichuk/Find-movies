//
//  MediaViewController.swift
//  Find movies
//
//  Created by admin on 15.06.2022.
//

import Foundation
import UIKit
import SDWebImage
import SnapKit
import Cosmos

enum MediaType {
    case movie(movie: Movie)
    case tvShow(tvShow: TvShow)
}

class MediaViewController: UIViewController {

    private var movie: Movie?
    private var tvShow: TvShow?
    private var movieActorsArray: [Cast] = []
    private var tvShowActorsArray: [Cast] = []

    private lazy var posterImage: UIImageView = {
        let posterImage = UIImageView()
        posterImage.contentMode = .scaleAspectFill
        posterImage.clipsToBounds = true
        posterImage.alpha = 0.8
        return posterImage
    }()

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 30, weight: .black)
        titleLabel.textColor = .customWhite
        titleLabel.numberOfLines = 0
        return titleLabel
    }()

    private lazy var releaseDate: UILabel = {
        let releaseDate = UILabel()
        releaseDate.textColor = .customGray
        return releaseDate
    }()

    private lazy var ratingStar: CosmosView = {
        let ratingStar = CosmosView()
        var settings = CosmosSettings()
        settings.fillMode = .half
        settings.totalStars = 5
        settings.textColor = .customWhite
        settings.starSize = 30
        settings.textFont = .systemFont(ofSize: 25)
        settings.textColor = .systemOrange
        ratingStar.settings = settings
        return ratingStar
    }()

    private lazy var overviewLabel: UILabel = {
        let overviewLabel = UILabel()
        overviewLabel.font = .systemFont(ofSize: 20, weight: .regular)
        overviewLabel.textColor = .customGray
        overviewLabel.numberOfLines = 3
        return overviewLabel
    }()

    private lazy var castLabel: UILabel = {
        let castLabel = UILabel()
        castLabel.font = .systemFont(ofSize: 20, weight: .bold)
        castLabel.textColor = .customWhite
        castLabel.text = "Cast"
        return castLabel
    }()

    private lazy var actorsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 64, height: 24)
        layout.itemSize = CGSize(width: 64, height: 24)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        let actorsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        actorsCollectionView.delegate = self
        actorsCollectionView.dataSource = self
        actorsCollectionView.backgroundColor = .clear
        actorsCollectionView.showsHorizontalScrollIndicator = false
        actorsCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return actorsCollectionView
    }()

    private lazy var webVersionButton: UIButton = {
        let webVersionButton = UIButton()
        webVersionButton.backgroundColor = .customRed
        webVersionButton.layer.cornerRadius = 8
        webVersionButton.frame.size.height = 30
        webVersionButton.setTitle("Watch WebVersion", for: .normal)
        return webVersionButton
    }()

    init(media: MediaType) {
        switch media {
        case .movie(let movie):
            self.movie = movie
        case .tvShow(let tvShow):
            self.tvShow = tvShow
        }
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        actorsCollectionView.register(ActorsMovieCollectionViewCell.self, forCellWithReuseIdentifier: Constants.UI.actorsCellIdentifier)
        self.tabBarController?.tabBar.isHidden = true
        createNavBarButtons()
        createUI()
        view.backgroundColor = .customBlack

    }

    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }

    private func createNavBarButtons() {
        let leftButton = UIBarButtonItem(image: UIImage.backIcon, style: .plain, target: self, action: #selector(backButtonPressed))
        let rightButton = UIBarButtonItem(image: UIImage.bookmarkIcon, style: .plain, target: self, action: #selector(addToBookmark))
        self.navigationItem.leftBarButtonItem  = leftButton
        self.navigationItem.rightBarButtonItem  = rightButton

    }

    private func createUI() {
        if let movieChoosen = movie {
            configure(with: .movie(movie: movieChoosen))
        } else if let tvShowChoosen = tvShow {
            configure(with: .tvShow(tvShow: tvShowChoosen))
        }
    }

    @objc func backButtonPressed() {
        self.navigationController?.popToRootViewController(animated: true)
    }

    @objc func addToBookmark() {
        // create save method
    }

    private func configure(with viewModel: MediaType) {
        switch viewModel {
        case .movie(let movie):
            let imagePath = movie.posterPath ?? ""
            let movieImageUrl = Constants.network.defaultImagePath + imagePath
            let url = URL(string: movieImageUrl)
            posterImage.sd_setImage(with: url)
            titleLabel.text = movie.title
            releaseDate.text = "Release date \(movie.releaseDate ?? "No date")"
            ratingStar.rating = (movie.voteAverage ?? 0.0) / 2
            ratingStar.text = "\(movie.voteAverage ?? 0.0)"
            overviewLabel.text = movie.overview
            loadActors {
                self.actorsCollectionView.reloadData()
            }
        case .tvShow(let tvShow):
            let imagePath = tvShow.posterPath ?? ""
            let tvShowImageUrl = Constants.network.defaultImagePath + imagePath
            let url = URL(string: tvShowImageUrl)
            posterImage.sd_setImage(with: url)
            titleLabel.text = tvShow.name
            releaseDate.text = "Release date \(tvShow.firstAirDate ?? "No date")"
            ratingStar.rating = (tvShow.voteAverage ?? 0.0) / 2
            ratingStar.text = "\(tvShow.voteAverage ?? 0.0)"
            overviewLabel.text = tvShow.overview
            loadActors {
                self.actorsCollectionView.reloadData()
            }
        }
    }

    private func loadActors(completion: @escaping(() -> ())) {
        NetworkManager.shared.requestMovieActors(movieId: movie, completion: { actors in
            self.movieActorsArray = actors ?? []
            completion()
        })
    }
}
//    @objc func loadSiteInSafaryButtonPressed(_ sender: Any) {
//        if let optionalStringURL = movie.strSource {
//            let stringUrl = String(describing: optionalStringURL)
//            let url = URL(string: stringUrl)!
//            let config = SFSafariViewController.Configuration()
//            config.entersReaderIfAvailable = true
//            let vc = SFSafariViewController(url: url, configuration: config)
//            present(vc, animated: true)
//        }
//    }

extension MediaViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieActorsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.UI.actorsCellIdentifier, for: indexPath) as? ActorsMovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        let currentActor = movieActorsArray[indexPath.row]
        cell.configure(with: currentActor)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }

    func setupConstraints() {

        view.addSubview(posterImage)
        posterImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(400)
        }

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(posterImage)
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview()
        }

        view.addSubview(releaseDate)
        releaseDate.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp_bottomMargin).inset(-15)
            make.left.equalToSuperview().inset(10)
        }

        view.addSubview(ratingStar)
        ratingStar.snp.makeConstraints { make in
            make.top.equalTo(releaseDate.snp_bottomMargin).inset(-15)
            make.left.equalToSuperview().inset(10)

        }

        view.addSubview(overviewLabel)
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingStar.snp_bottomMargin).inset(-15)
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview()
        }

        view.addSubview(castLabel)
        castLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp_bottomMargin).inset(-15)
            make.left.equalToSuperview().inset(10)
        }

        view.addSubview(actorsCollectionView)
        actorsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(castLabel.snp_bottomMargin).inset(-15)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(150)
        }
        view.addSubview(webVersionButton)
        webVersionButton.snp.makeConstraints { make in
            make.top.equalTo(actorsCollectionView.snp_bottomMargin).inset(-40)
            make.left.right.equalToSuperview().inset(100)
            make.height.equalTo(40)

        }
    }
}
