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

    private lazy var posterImage: UIImageView = {
        let posterImage = UIImageView()
        posterImage.contentMode = .scaleAspectFill
        posterImage.clipsToBounds = true
        return posterImage
    }()

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 20, weight: .black)
        titleLabel.textColor = .customWhite
        return titleLabel
    }()

    private lazy var releaseDate: UILabel = {
        let releaseDate = UILabel()
        releaseDate.font = .systemFont(ofSize: 20, weight: .black)
        releaseDate.textColor = .customWhite
        return releaseDate
    }()

    private lazy var ratingStar: CosmosView = {
        let ratingStar = CosmosView()
        var settings = CosmosSettings()
        settings.fillMode = .half
        settings.totalStars = 5
        ratingStar.settings = settings
        return ratingStar
    }()


    init(media: MediaType) {
        switch media {
        case .movie(let movie):
            self.movie = movie
        case .tvShow(tvShow: let tvShow):
            self.tvShow = tvShow
        }
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        self.tabBarController?.tabBar.isHidden = true
        createNavBarButtons()
        createUI()
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
            releaseDate.text = movie.releaseDate
            ratingStar.rating = (movie.voteAverage ?? 0.0) / 2
        case .tvShow(let tvShow):
            break
        }
    }
}

extension MediaViewController {
    func setupConstraints() {
        view.addSubview(posterImage)
        posterImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(450)
        }

        posterImage.addSubview(ratingStar)
        ratingStar.snp.makeConstraints { make in
            make.bottom.equalTo(posterImage)
            make.left.right.equalToSuperview().inset(130)

        }





//        view.addSubview(locationButton)
//        locationButton.snp.makeConstraints { make in
//            make.left.equalTo(background).inset(15)
//            make.top.equalTo(background).inset(40)
//            make.width.height.equalTo(40)
//        }
//
//        view.addSubview(searchButton)
//        searchButton.snp.makeConstraints { make in
//            make.right.equalTo(background).inset(15)
//            make.top.equalTo(background).inset(40)
//            make.width.height.equalTo(40)
//        }
//
//        view.addSubview(searchTextField)
//        searchTextField.snp.makeConstraints { make in
//            make.top.equalTo(background).inset(40)
//            make.left.equalTo(locationButton).inset(40)
//            make.right.equalTo(searchButton).inset(40)
//            make.height.equalTo(40)
//
//        }
//
//        view.addSubview(conditionImageView)
//        conditionImageView.snp.makeConstraints { make in
//            make.top.equalTo(searchTextField).inset(50)
//            make.right.equalTo(background).inset(15)
//            make.width.height.equalTo(120)
//        }
//
//        view.addSubview(temperatureSign)
//        temperatureSign.snp.makeConstraints { make in
//            make.top.equalTo(conditionImageView.snp_bottomMargin)
//            make.right.equalTo(background).offset(-15)
//        }
//
//        view.addSubview(temperatureLabel)
//        temperatureLabel.snp.makeConstraints { make in
//            make.right.equalTo(temperatureSign.snp_leftMargin).offset(-15)
//            make.top.equalTo(conditionImageView.snp_bottomMargin)
//        }
//
//        view.addSubview(cityLabel)
//        cityLabel.snp.makeConstraints { make in
//            make.top.equalTo(temperatureSign.snp_bottomMargin).offset(15)
//            make.right.equalTo(background).offset(-15)
//        }
    }
}
