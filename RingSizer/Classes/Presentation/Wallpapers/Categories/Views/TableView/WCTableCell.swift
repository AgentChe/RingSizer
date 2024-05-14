//
//  WCTableCell.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 26.04.2024.
//

import UIKit
import Kingfisher

final class WCTableCell: UITableViewCell {
    lazy var pictureView = makeImageView()
    lazy var gradientView = makeGradientView()
    lazy var countLabel = makeLabel()
    lazy var nameLabel = makeLabel()
    lazy var preloader = makePreloader()
    
    private lazy var countAttrs = TextAttributes()
        .textColor(Appearance.v4White.withAlphaComponent(0.8))
        .font(Fonts.Sen.regular(size: 20.scale))
        .lineHeight(26.scale)
        .textAlignment(.left)
    private lazy var nameAttrs = TextAttributes()
        .textColor(Appearance.v4White)
        .font(Fonts.Sen.bold(size: 20.scale))
        .lineHeight(22.scale)
        .textAlignment(.left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        pictureView.kf.cancelDownloadTask()
        pictureView.image = nil
    }
}

// MARK: Public
extension WCTableCell {
    func setup(element: WallpaperCategory) {
        activity(true)
        pictureView.kf.setImage(with: element.imageUrl) { [weak self] _ in
            self?.activity(false)
        }
        
        let count = String(format: "WallpapersCategories.Count".localized, element.wallpapers.count)
        countLabel.attributedText = count.attributed(with: countAttrs)
        
        nameLabel.attributedText = element.name.attributed(with: nameAttrs)
    }
}

// MARK: Private
private extension WCTableCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
    
    func activity(_ activity: Bool) {
        countLabel.isHidden = activity
        nameLabel.isHidden = activity
        
        activity ? preloader.startAnimating() : preloader.stopAnimating()
    }
}

// MARK: Make constraints
private extension WCTableCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            pictureView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            pictureView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            pictureView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.scale),
            pictureView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.scale),
            pictureView.heightAnchor.constraint(equalToConstant: 440.scale)
        ])
        
        NSLayoutConstraint.activate([
            gradientView.leadingAnchor.constraint(equalTo: pictureView.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: pictureView.trailingAnchor),
            gradientView.topAnchor.constraint(equalTo: pictureView.topAnchor),
            gradientView.bottomAnchor.constraint(equalTo: pictureView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            countLabel.leadingAnchor.constraint(equalTo: pictureView.leadingAnchor, constant: 16.scale),
            countLabel.trailingAnchor.constraint(equalTo: pictureView.trailingAnchor, constant: -16.scale),
            countLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: pictureView.leadingAnchor, constant: 16.scale),
            nameLabel.trailingAnchor.constraint(equalTo: pictureView.trailingAnchor, constant: -16.scale),
            nameLabel.topAnchor.constraint(equalTo: countLabel.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            preloader.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            preloader.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension WCTableCell {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeGradientView() -> GradientView {
        let view = GradientView()
        view.gradientLayer.colors = [
            UIColor.black.withAlphaComponent(0.5).cgColor,
            UIColor.black.withAlphaComponent(0).cgColor,
        ]
        view.gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        view.gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makePreloader() -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView()
        view.color = Appearance.v4Grey
        view.style = .large
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
