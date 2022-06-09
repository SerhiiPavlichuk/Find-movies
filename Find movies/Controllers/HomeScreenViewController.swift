//
//  HomeScreenViewController.swift
//  Find movies
//
//  Created by admin on 08.06.2022.
//

import Foundation
import UIKit
import SnapKit

enum SectionType {
    case movies(viewModels: [MoviesCellViewModel])
    case tvShows(viewModels: [TVShowCellViewModel])
}

class HomeScreenViewController: UIViewController {

    private lazy var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return Self.createLayout(section: sectionIndex)
        })

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTitleImage()
        setupCollectionView()
        loadMovies(completion: {
            self.collectionView.reloadData()
        })
        loadTVShows(completion: {
            self.collectionView.reloadData()
        })
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }

    private var sections = [SectionType]()

    private func setupCollectionView() {

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.UI.defaultCellIdentifier)
        collectionView.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: Constants.UI.movieCellIdentifier)
        collectionView.register(TVShowsCollectionViewCell.self, forCellWithReuseIdentifier: Constants.UI.tvShowCellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
    }

    private func setupTitleImage() {
        view.backgroundColor = .customBlack
        let logo = UIImage.logoTitle
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 182, height: 95))
        container.backgroundColor = UIColor.clear

        let imageView = UIImageView(frame:  CGRect(x: -80, y: 2, width: 182, height: 95))
        imageView.contentMode = .scaleAspectFit
        imageView.image = logo

        container.addSubview(imageView)

        self.navigationItem.titleView = container
    }

    private func loadMovies(completion: @escaping(() -> ())) {
        NetworkManager.shared.requestTrendingMovies(completion: { movies in
            self.configureMovieModels(movie: movies)
            completion()
        })

    }
    //configure MovieModel
    private func configureMovieModels(movie: [Movie]) {
        sections.append(.movies(viewModels: movie.compactMap({_ in
            return MoviesCellViewModel(
                posterImage: movie.first?.posterPath ?? "",
                releaseDate: movie.first?.releaseDate ?? "",
                title: movie.first?.title ?? "")
        })))
    }

    private func loadTVShows(completion: @escaping(() -> ())) {
        NetworkManager.shared.requestTrendingTVShows(completion: { tvShows in
            self.configureTVShowModels(tvShows: tvShows)
            completion()
        })

    }
    //configure TVShowModel
    private func configureTVShowModels(tvShows: [TvShow]) {
        sections.append(.tvShows(viewModels: tvShows.compactMap({_ in
            return TVShowCellViewModel(
                posterImage: tvShows.first?.posterPath ?? "",
                releaseDate: tvShows.first?.firstAirDate ?? "",
                title: tvShows.first?.name ?? "")
        })))
    }
}

extension HomeScreenViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let collectionType = sections[section]
        switch collectionType {
        case .movies(let viewModels):
            return viewModels.count
        case .tvShows(let viewModels):
            return viewModels.count
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.UI.defaultCellIdentifier, for: indexPath)
        if indexPath.section == 0 {
            cell.backgroundColor = .systemRed
        } else if indexPath.section == 1 {
            cell.backgroundColor = .systemBlue
        }
        return cell
    }

    func setupConstraints() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(140)
            make.bottom.equalTo(-90)
        }
    }

    static func createLayout(section: Int) -> NSCollectionLayoutSection {
        switch section {
        case 0:
            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
            // Group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
                                                   heightDimension: .absolute(200))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .flexible(0),
                                                              top: nil,
                                                              trailing: nil,
                                                              bottom: nil)
            // Footer&Header
            let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                          heightDimension: .estimated(50.0))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerHeaderSize,
                                                                     elementKind: UICollectionView.elementKindSectionHeader,
                                                                     alignment: .top)
            let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerHeaderSize,
                                                                     elementKind: UICollectionView.elementKindSectionFooter,
                                                                     alignment: .bottom)
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [header, footer]
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary

            return section

        case 1:
            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
            // Group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
                                                   heightDimension: .absolute(200))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .flexible(0),
                                                              top: nil,
                                                              trailing: nil,
                                                              bottom: nil)
            // Footer&Header
            let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                          heightDimension: .estimated(50.0))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerHeaderSize,
                                                                     elementKind: UICollectionView.elementKindSectionHeader,
                                                                     alignment: .top)
            let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerHeaderSize,
                                                                     elementKind: UICollectionView.elementKindSectionFooter,
                                                                     alignment: .bottom)
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [header, footer]
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary

            return section

        default:
            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
            // Group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                   heightDimension: .absolute(200))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .flexible(0),
                                                              top: nil,
                                                              trailing: nil,
                                                              bottom: nil)
            // Footer&Header
            let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                          heightDimension: .estimated(50.0))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerHeaderSize,
                                                                     elementKind: UICollectionView.elementKindSectionHeader,
                                                                     alignment: .top)
            let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerHeaderSize,
                                                                     elementKind: UICollectionView.elementKindSectionFooter,
                                                                     alignment: .bottom)
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [header, footer]
            section.orthogonalScrollingBehavior = .groupPaging

            return section
        }
    }
}
