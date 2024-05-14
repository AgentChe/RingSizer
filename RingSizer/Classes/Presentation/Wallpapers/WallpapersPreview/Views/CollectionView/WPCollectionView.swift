//
//  WPCollectionView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 26.04.2024.
//

import UIKit

final class WPCollectionView: UICollectionView {
    lazy var elements = [Wallpaper]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension WPCollectionView {
    func setup(elements: [Wallpaper], scrollTo: Wallpaper) {
        self.elements = elements
        
        reloadData()
        
        if let index = elements.firstIndex(where: { $0.id == scrollTo.id }) {
            let indexPath = IndexPath(item: index, section: 0)
            DispatchQueue.main.async { [weak self] in
                self?.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
            }
        }
    }
    
    func currentWallpaper() -> Wallpaper? {
        let visibleRect = CGRect(origin: contentOffset, size: bounds.size)
        let visibleCenterX = visibleRect.midX
        let visibleCenterY = visibleRect.midY
        let centerPoint = CGPoint(x: visibleCenterX, y: visibleCenterY)
        
        guard let index = indexPathForItem(at: centerPoint)?.row, elements.indices.contains(index) else {
            return nil
        }
        
        return elements[index]
    }
}

// MARK: UICollectionViewDataSource
extension WPCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: String(describing: WPCollectionCell.self), for: indexPath) as! WPCollectionCell
        cell.setup(element: elements[indexPath.row])
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension WPCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        bounds.size
    }
}

// MARK: Private
private extension WPCollectionView {
    func initialize() {
        register(WPCollectionCell.self, forCellWithReuseIdentifier: String(describing: WPCollectionCell.self))
        
        dataSource = self
        delegate = self
    }
}
