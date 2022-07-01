//
//  HomeScreenViewController.swift
//  Find movies
//
//  Created by admin on 08.06.2022.
//

import Foundation
import UIKit
import SnapKit

class HomeScreenViewController: UIViewController {

    //MARK: - Properties
    
    private let viewModel = HomeScreenViewModel()
    private var dataSource: UICollectionViewDiffableDataSource<SectionType, SectionType>?

    private lazy var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return Self.createLayout(section: sectionIndex)
        })

    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .clear
        tabBarController?.tabBar.barTintColor = .clear
        
        setupCollectionView()
//        createDataSource()
//        reloadData()
        viewModel.loadMovies(completion: {
            self.collectionView.reloadData()
        })
        viewModel.loadTVShows(completion: {
            self.collectionView.reloadData()
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTitleImage()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }

    //MARK: - SetupCollectionView

    private func setupCollectionView() {
        collectionView.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: Constants.UI.movieCellIdentifier)
        collectionView.register(TVShowsCollectionViewCell.self, forCellWithReuseIdentifier: Constants.UI.tvShowCellIdentifier)
        collectionView.register(SectionHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.UI.headerIdentifier)
                collectionView.dataSource = self
                collectionView.delegate = self
        collectionView.backgroundColor = .clear
    }
    
    //MARK: - Setup UI

    private func setupTitleImage() {
        let logo = UIImage.logoTitle
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 182, height: 95))
        container.backgroundColor = UIColor.clear

        let imageView = UIImageView(frame:  CGRect(x: -80, y: -12, width: 182, height: 95))
        imageView.contentMode = .scaleAspectFit
        imageView.image = logo

        container.addSubview(imageView)

        self.navigationItem.titleView = container
    }

    private func setupConstraints() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(140)
            make.bottom.equalTo(-90)
        }
    }
}

extension HomeScreenViewController: UICollectionViewDataSource, UICollectionViewDelegate {

//    func createDataSource() {
//        dataSource = UICollectionViewDiffableDataSource<SectionType, SectionType>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
//
//            switch itemIdentifier {
//
//            case .movies(let movie):
//                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.UI.movieCellIdentifier, for: indexPath) as? MoviesCollectionViewCell else {
//                    return UICollectionViewCell()
//                }
//                let item = movie[indexPath.row]
//                cell.configure(with: item)
//                return cell
//            case .tvShows(let tvShow):
//                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.UI.tvShowCellIdentifier, for: indexPath) as? TVShowsCollectionViewCell else {
//                    return UICollectionViewCell()
//                }
//                let item = tvShow[indexPath.row]
//                cell.configure(with: item)
//                return cell
//            }
//        })
//    }
//
//
//    func reloadData() {
//        var snapshot = NSDiffableDataSourceSnapshot<SectionType, SectionType>()
//        snapshot.appendSections(viewModel.sections)
//
//        for sections in viewModel.sections {
//            snapshot.appendItems(sections.items, toSection: sections)
//        }
//
//        dataSource?.apply(snapshot)
//    }

        //MARK: - DataSource

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            let collectionType = viewModel.sections[section]
            switch collectionType {
            case .movies(let movies):
                return movies.count
            case .tvShows(let tvShows):
                return tvShows.count
            }
        }

        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return viewModel.sections.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let collectionType = viewModel.sections[indexPath.section]
            switch collectionType {
            case .movies(let movie):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.UI.movieCellIdentifier, for: indexPath) as? MoviesCollectionViewCell else {
                    return UICollectionViewCell()
                }
                let item = movie[indexPath.row]
                cell.configure(with: item)
                return cell
            case .tvShows(let tvShow):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.UI.tvShowCellIdentifier, for: indexPath) as? TVShowsCollectionViewCell else {
                    return UICollectionViewCell()
                }
                let item = tvShow[indexPath.row]
                cell.configure(with: item)
                return cell
            }
        }

        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

            let collectionType = viewModel.sections[indexPath.section]
            switch collectionType {
            case .movies(movie: let movie):
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.UI.headerIdentifier, for: indexPath) as? SectionHeaderReusableView, kind == UICollectionView.elementKindSectionHeader else {
                    return UICollectionReusableView()
                }
                let item = movie[indexPath.row]
                header.configure(with: .movie(movie: item))
                return header
            case .tvShows(tvShow: let tvShow):
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.UI.headerIdentifier, for: indexPath) as? SectionHeaderReusableView, kind == UICollectionView.elementKindSectionHeader else {
                    return UICollectionReusableView()
                }
                let item = tvShow[indexPath.row]
                header.configure(with: .tvShow(tvShow: item))
                return header
            }
        }

        //MARK: - Delegate

        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            collectionView.deselectItem(at: indexPath, animated: true)
            let section = viewModel.sections[indexPath.section]
            switch section {
            case .movies(let movies): // сделать общий массив медиа
                let movie = movies[indexPath.row]
                let vc = MediaViewController(media: .movie(movie: movie)) // тут мы берем тип из моделей если нужен
                vc.navigationController?.navigationItem.largeTitleDisplayMode = .never
                navigationController?.pushViewController(vc, animated: true)
            case .tvShows(let TvShows):
                let tvShow = TvShows[indexPath.row]
                let vc = MediaViewController(media: .tvShow(tvShow: tvShow))
                vc.navigationController?.navigationItem.largeTitleDisplayMode = .never
                navigationController?.pushViewController(vc, animated: true)
            }
        }

    //MARK: - CollectionLayotSection

    static func createLayout(section: Int) -> NSCollectionLayoutSection { //вынести реализацию в один метод
        switch section {
        case 0:
            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
            // Group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
                                                   heightDimension: .fractionalHeight(0.38))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .flexible(0),
                                                              top: nil,
                                                              trailing: nil,
                                                              bottom: nil)
            // Footer&Header
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .estimated(50.0))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                     elementKind: UICollectionView.elementKindSectionHeader,
                                                                     alignment: .top)
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [header]
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
            return section

        case 1:
            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
            // Group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
                                                   heightDimension: .fractionalHeight(0.38))
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
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [header]
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
            
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

            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [header]
            section.orthogonalScrollingBehavior = .groupPaging

            return section
        }
    }
}
