//
//  SectionHeaderReusableView.swift
//  Find movies
//
//  Created by admin on 22.06.2022.
//

import UIKit

enum HeaderType {
    case movie(movie: Movie)
    case tvShow(tvShow: TvShow)
}

final class SectionHeaderReusableView: UICollectionReusableView {

    static let reuseID = "SectionHeaderReusableView"

    private lazy var title: UILabel = {
        let title = UILabel()
        title.textColor = .customWhite
        title.font = .systemFont(ofSize: 28, weight: .bold)
        title.text = "Movies"
        return title
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        //        posterImage.sizeToFit()
        //        title.sizeToFit()
        //        releaseDate.sizeToFit()


        setupConstraints()
    }

    func configure(with viewModel: HeaderType) {
        switch viewModel {
        case .movie:
            self.title.text = "Movies"
        case .tvShow:
            self.title.text = "TVShows"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SectionHeaderReusableView {
    func setupConstraints() {
        addSubview(title)
        title.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()

        }
    }
}
