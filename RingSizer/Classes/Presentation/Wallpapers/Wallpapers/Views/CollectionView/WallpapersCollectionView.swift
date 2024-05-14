//
//  WallpapersCollectionView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 26.04.2024.
//

import UIKit
import RxSwift
import RxCocoa

final class WallpapersCollectionView: UICollectionView {
    lazy var elements = [Wallpaper]()
    
    private lazy var didSelectTrigger = PublishRelay<Wallpaper>()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension WallpapersCollectionView {
    func setup(elements: [Wallpaper]) {
        self.elements = elements
        
        reloadData()
    }
    
    var didSelect: Signal<Wallpaper> {
        didSelectTrigger.asSignal()
    }
}

// MARK: UICollectionViewDataSource
extension WallpapersCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: String(describing: WallpapersCollectionCell.self), for: indexPath) as! WallpapersCollectionCell
        cell.setup(element: elements[indexPath.row])
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension WallpapersCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectTrigger.accept(elements[indexPath.row])
    }
}

// MARK: Private
private extension WallpapersCollectionView {
    func initialize() {
        register(WallpapersCollectionCell.self, forCellWithReuseIdentifier: String(describing: WallpapersCollectionCell.self))
        
        dataSource = self
        delegate = self
    }
}
