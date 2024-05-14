//
//  TabView.swift
//  Soccer
//
//  Created by Андрей Чернышев on 07.07.2022.
//

import UIKit

final class TabView: UIView {
    enum Tab {
        case ringSizer
		case converter(model: SavedRingSizeModel? = nil)
		case fingerSizer
        case wallpapers
    }
    
    lazy var separator = makeSeparator()
    lazy var ringSizerItem = makeItem(name: "Main.RingSizer".localized)
    lazy var convererItem = makeItem(name: "Main.Converter".localized)
    lazy var fingerSizerItem = makeItem(name: "Main.FingerSizer".localized)
    lazy var wallpapersItem = makeItem(name: "Main.Wallpapers".localized)
    
    var selectedTab = Tab.ringSizer {
        didSet {
            update()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension TabView {
    func update() {
        [
            ringSizerItem,
            convererItem,
            fingerSizerItem,
            wallpapersItem
        ]
        .forEach {
            $0.mode = .deselected
        }
        
        switch selectedTab {
        case .ringSizer:
            ringSizerItem.mode = .selected
        case .converter:
            convererItem.mode = .selected
        case .fingerSizer:
            fingerSizerItem.mode = .selected
        case .wallpapers:
            wallpapersItem.mode = .selected
        }
    }
}

// MARK: Make constraints
private extension TabView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.topAnchor.constraint(equalTo: topAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1.scale)
        ])
        
        NSLayoutConstraint.activate([
            ringSizerItem.leadingAnchor.constraint(equalTo: leadingAnchor),
            ringSizerItem.bottomAnchor.constraint(equalTo: bottomAnchor),
            ringSizerItem.topAnchor.constraint(equalTo: topAnchor),
            ringSizerItem.widthAnchor.constraint(equalTo: convererItem.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            convererItem.leadingAnchor.constraint(equalTo: ringSizerItem.trailingAnchor),
            convererItem.bottomAnchor.constraint(equalTo: bottomAnchor),
            convererItem.topAnchor.constraint(equalTo: topAnchor),
            convererItem.widthAnchor.constraint(equalTo: fingerSizerItem.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            fingerSizerItem.leadingAnchor.constraint(equalTo: convererItem.trailingAnchor),
            fingerSizerItem.bottomAnchor.constraint(equalTo: bottomAnchor),
            fingerSizerItem.topAnchor.constraint(equalTo: topAnchor),
            fingerSizerItem.widthAnchor.constraint(equalTo: wallpapersItem.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            wallpapersItem.leadingAnchor.constraint(equalTo: fingerSizerItem.trailingAnchor),
            wallpapersItem.bottomAnchor.constraint(equalTo: bottomAnchor),
            wallpapersItem.topAnchor.constraint(equalTo: topAnchor),
            wallpapersItem.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension TabView {
    func makeSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 205, green: 205, blue: 195)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeItem(name: String) -> TabItemView {
        let view = TabItemView(name: name)
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
