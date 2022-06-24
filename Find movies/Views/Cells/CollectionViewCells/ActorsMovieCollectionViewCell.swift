//
//  ActorsMovieCollectionViewCell.swift
//  Find movies
//
//  Created by admin on 15.06.2022.
//

import UIKit
import SnapKit
import SDWebImage

class ActorsMovieCollectionViewCell: UICollectionViewCell {

    private lazy var actorImage: UIImageView = {
        let actorImage = UIImageView()
        actorImage.contentMode = .scaleAspectFill
        actorImage.clipsToBounds = true
        actorImage.frame.size.height = 100
        return actorImage
    }()

    private lazy var actorNameLabel: UILabel = {
        let actorNameLabel = UILabel()
        actorNameLabel.textColor = .customWhite
        actorNameLabel.font.withSize(14)
        return actorNameLabel
    }()

    private lazy var roleNameLabel: UILabel = {
        let roleNameLabel = UILabel()
        roleNameLabel.textColor = .customGray
        roleNameLabel.font.withSize(14)
        return roleNameLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.addSubview(actorImage)
        contentView.addSubview(actorNameLabel)
        contentView.addSubview(roleNameLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        actorImage.layer.cornerRadius = 50
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        actorImage.image = nil
        actorNameLabel.text = nil
        roleNameLabel.text = nil
    }

    func configure(with actor: Cast) {
        if let imagePath = actor.profilePath {
            let movieImageUrl = Constants.network.defaultImagePath + imagePath
            let url = URL(string: movieImageUrl)
            actorImage.sd_setImage(with: url)
        } else {
            actorImage.image = UIImage(named: Constants.UI.defaultImage)
        }

        actorNameLabel.text = actor.name
        roleNameLabel.text = actor.character

    }
}
extension ActorsMovieCollectionViewCell {
    func setupConstraints() {
        actorImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        actorNameLabel.snp.makeConstraints { make in
            make.top.equalTo(actorImage.snp_bottomMargin).inset(-10)
            make.left.equalToSuperview()
            make.width.equalToSuperview()
        }
        roleNameLabel.snp.makeConstraints { make in
            make.top.equalTo(actorNameLabel.snp_bottomMargin).inset(-10)
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
}
