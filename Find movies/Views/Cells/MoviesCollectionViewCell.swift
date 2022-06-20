//
//  MoviesCollectionViewCell.swift
//  Find movies
//
//  Created by admin on 09.06.2022.
//

import UIKit
import SDWebImage

class MoviesCollectionViewCell: UICollectionViewCell {

    private lazy var posterImage: UIImageView = {
        let posterImage = UIImageView()
        posterImage.contentMode = .scaleAspectFill
        posterImage.clipsToBounds = true
        return posterImage
    }()

    private lazy var title: UILabel = {
        let title = UILabel()
        title.textColor = .customWhite
        title.font.withSize(18)
        return title
    }()

    private lazy var releaseDate: UILabel = {
        let releaseDate = UILabel()
        releaseDate.textColor = .customGray
        releaseDate.font.withSize(14)
        return releaseDate
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.addSubview(posterImage)
        contentView.addSubview(title)
        contentView.addSubview(releaseDate)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
//        posterImage.sizeToFit()
//        title.sizeToFit()
//        releaseDate.sizeToFit()


        setupConstraints()
        posterImage.layer.cornerRadius = 16
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        posterImage.image = nil
        title.text = nil
        releaseDate.text = nil
    }

    func configure(with viewModel: Movie) {
        let imagePath = viewModel.posterPath ?? ""
        let movieImageUrl = Constants.network.defaultImagePath + imagePath
        let url = URL(string: movieImageUrl)
        posterImage.sd_setImage(with: url)
        title.text = viewModel.title
        releaseDate.text = viewModel.releaseDate
    }
}

extension MoviesCollectionViewCell {
    func setupConstraints() {
        posterImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(160)
        }
        title.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp_bottomMargin).inset(-10)
            make.left.equalToSuperview()

            make.width.equalToSuperview()
        }
        releaseDate.snp.makeConstraints { make in
            make.top.equalTo(title.snp_bottomMargin).inset(-10)
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
}
