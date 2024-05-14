//
//  WallpapersView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 26.04.2024.
//

import UIKit

final class WallpapersView: UIView {
    lazy var headerView = makeHeaderView()
    lazy var collectionView = makeCollectionView()
    lazy var backButton = makeBackButton()
    
    private let title: String
    
    init(title: String) {
        self.title = title
        
        super.init(frame: .zero)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension WallpapersView {
    func initialize() {
        backgroundColor = Appearance.v4WarmBeige
    }
}

// MARK: Make constraints
private extension WallpapersView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            backButton.heightAnchor.constraint(equalToConstant: 24.scale),
            backButton.widthAnchor.constraint(equalTo: backButton.heightAnchor),
            backButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 80.scale : 26.scale),
            headerView.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 3.scale),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 2.scale),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension WallpapersView {
    func makeHeaderView() -> HeaderView {
        let view = HeaderView(title: title)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.button.isHidden = true
        addSubview(view)
        return view
    }
    
    func makeCollectionView() -> WallpapersCollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 14.scale
        layout.minimumInteritemSpacing = 14.scale
        layout.itemSize = CGSize(width: 109.scale, height: 194.scale)
        layout.sectionInset = UIEdgeInsets()
        
        let view = WallpapersCollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.clear
        view.showsVerticalScrollIndicator = false
        view.contentInset = UIEdgeInsets(value: 16.scale)
        view.setContentOffset(CGPoint(x: 0, y: -16.scale), animated: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeBackButton() -> TapAreaButton {
        let view = TapAreaButton()
        view.setImage(UIImage(named: "FingerSizer.Back"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
