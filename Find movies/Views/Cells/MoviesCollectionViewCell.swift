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
        posterImage.sizeToFit()
        title.sizeToFit()
        releaseDate.sizeToFit()

//        let imageSize: CGFloat = contentView.frame.size.height - 10


//        posterImage.frame = CGRect(x: 5, y: 5, width: 130, height: 200)
//        posterImage.layer.cornerRadius = 30
        setupConstraints()
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
            posterImage.layer.cornerRadius = 30
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(title).inset(5)
        }
        title.snp.makeConstraints { make in
            make.top.equalTo(posterImage).inset(5)
            make.left.equalToSuperview()
            make.bottom.equalTo(releaseDate).inset(5)
            make.width.height.equalTo(40)
        }
        releaseDate.snp.makeConstraints { make in
            make.top.equalTo(title).inset(5)
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.height.equalTo(40)
        }
    }
}
