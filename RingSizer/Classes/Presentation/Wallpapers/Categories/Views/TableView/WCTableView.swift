//
//  WCTableView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 26.04.2024.
//

import UIKit
import RxSwift
import RxCocoa

final class WCTableView: UITableView {
    private lazy var elements = [WallpaperCategory]()
    
    private lazy var didSelectTrigger = PublishRelay<WallpaperCategory>()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension WCTableView {
    func setup(elements: [WallpaperCategory]) {
        self.elements = elements
        
        reloadData()
    }
    
    var didSelect: Signal<WallpaperCategory> {
        didSelectTrigger.asSignal()
    }
}

// MARK: UITableViewDataSource
extension WCTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: String(describing: WCTableCell.self)) as! WCTableCell
        cell.setup(element: elements[indexPath.row])
        return cell
    }
}

// MARK: UITableViewDelegate
extension WCTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectTrigger.accept(elements[indexPath.row])
    }
}

// MARK: Private
private extension WCTableView {
    func initialize() {
        register(WCTableCell.self, forCellReuseIdentifier: String(describing: WCTableCell.self))
        
        dataSource = self
        delegate = self
    }
}
