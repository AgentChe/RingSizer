//
//  TabItemView.swift
//  Soccer
//
//  Created by Андрей Чернышев on 07.07.2022.
//

import UIKit

final class TabItemView: UIButton {
    enum Mode {
        case selected, deselected
    }
    
    lazy var label = makeLabel()
    lazy var indicator = makeIndicator()
    
    var mode = Mode.deselected {
        didSet {
            update()
        }
    }
    
    private let name: String
    
    init(name: String) {
        self.name = name
        
        super.init(frame: .zero)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension TabItemView {
    func update() {
        let selected = mode == .selected
        
        label.alpha = selected ? 1 : 0.6
        indicator.isHidden = !selected
    }
}

// MARK: Make constraints
private extension TabItemView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            indicator.widthAnchor.constraint(equalToConstant: 3.scale),
            indicator.heightAnchor.constraint(equalToConstant: 3.scale),
            indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicator.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension TabItemView {
    func makeLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.v4DarkGrey)
            .font(Fonts.Sen.regular(size: 12.scale))
            .lineHeight(14.44.scale)
            .letterSpacing(0.24.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = name.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view 
    }
    
    func makeIndicator() -> CircleView {
        let view = CircleView()
        view.backgroundColor = Appearance.v4DarkGrey
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
