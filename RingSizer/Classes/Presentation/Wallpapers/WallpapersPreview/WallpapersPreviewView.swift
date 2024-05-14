//
//  WallpapersPreviewView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 26.04.2024.
//

import UIKit

final class WallpapersPreviewView: UIView {
    lazy var collectionView = makeCollectionView()
    lazy var backButton = makeBackButton()
    lazy var saveButton = makeSaveButton()
    lazy var previewButton = makePreviewButton()
    lazy var lockscreenView = makeLockscreenView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension WallpapersPreviewView {
    func initialize() {
        backgroundColor = Appearance.v4WarmBeige
    }
}

// MARK: Make constraints
private extension WallpapersPreviewView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 24.scale),
            backButton.heightAnchor.constraint(equalToConstant: 24.scale),
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16.scale),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.widthAnchor.constraint(equalToConstant: 166.scale),
            saveButton.heightAnchor.constraint(equalToConstant: 54.scale),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -60.scale : -30.scale)
        ])
        
        NSLayoutConstraint.activate([
            previewButton.widthAnchor.constraint(equalToConstant: 60.scale),
            previewButton.heightAnchor.constraint(equalToConstant: 54.scale),
            previewButton.centerYAnchor.constraint(equalTo: saveButton.centerYAnchor),
            previewButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale)
        ])
        
        NSLayoutConstraint.activate([
            lockscreenView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lockscreenView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lockscreenView.topAnchor.constraint(equalTo: topAnchor),
            lockscreenView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension WallpapersPreviewView {
    func makeCollectionView() -> WPCollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets()
        
        let view = WPCollectionView(frame: .zero, collectionViewLayout: layout)
        view.isPagingEnabled = true
        view.backgroundColor = UIColor.clear
        view.showsVerticalScrollIndicator = false
        view.contentInset = UIEdgeInsets()
        view.setContentOffset(CGPoint.zero, animated: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeBackButton() -> TapAreaButton {
        let view = TapAreaButton()
        view.setImage(UIImage(named: "WallpapersPreview.Back.White"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSaveButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(Appearance.v4DarkGrey)
            .font(Fonts.Sen.regular(size: 16.scale))
        
        let view = UIButton(type: .system)
        view.backgroundColor = Appearance.v4White
        view.setAttributedTitle("WallpapersPreview.Save".localized.attributed(with: attrs), for: .normal)
        view.layer.borderWidth = 1.scale
        view.layer.borderColor = Appearance.v4DarkGrey.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makePreviewButton() -> UIButton {
        let view = UIButton(type: .system)
        view.backgroundColor = Appearance.v4White
        view.setImage(UIImage(named: "WallpapersPreview.Preview")?.withRenderingMode(.alwaysOriginal), for: .normal)
        view.contentMode = .scaleAspectFit
        view.contentEdgeInsets = UIEdgeInsets(t: 19.scale, l: 17.scale, b: 18.45.scale, r: 17.43.scale)
        view.layer.borderWidth = 1.scale
        view.layer.borderColor = Appearance.v4DarkGrey.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeLockscreenView() -> WPLockscreenView {
        let view = WPLockscreenView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
