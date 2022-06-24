//
//  MoviesTableViewCell.swift
//  Find movies
//
//  Created by admin on 24.06.2022.
//

import Foundation
import UIKit
import SDWebImage

class MoviesTableViewCell: UITableViewCell {

    private lazy var posterImageView: UIImageView = {
        let posterImage = UIImageView()
        posterImage.contentMode = .scaleAspectFill
        posterImage.clipsToBounds = true
        return posterImage
    }()

    private lazy var movieNameLabel: UILabel = {
        let movieNameLabel = UILabel()
        movieNameLabel.font = .systemFont(ofSize: 30, weight: .bold)
        movieNameLabel.textColor = .customWhite
        return movieNameLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .customBlack
        contentView.addSubview(posterImageView)
        contentView.addSubview(movieNameLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        posterImageView.layer.cornerRadius = 16

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        movieNameLabel.text = nil

    }

    private func setupUI() {
        selectionStyle = .none
    }

    func movieConfigureWith(imageURL: URL?, movieName: String?) {
        movieNameLabel.text = movieName
        posterImageView.sd_setImage(with: imageURL, completed: nil)
        setupUI()
    }
}

extension  MoviesTableViewCell {
    func setupConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(200)
        }
        movieNameLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp_bottomMargin).inset(-10)
            make.left.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
}
