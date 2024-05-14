//
//  WPLockscreenView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 26.04.2024.
//

import UIKit
import Kingfisher

final class WPLockscreenView: UIView {
    lazy var lockView = makeLockView()
    lazy var dateLabel = makeDateLabel()
    lazy var lightView = makeLightView()
    lazy var cameraView = makeCameraView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Make constraints
private extension WPLockscreenView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            lockView.widthAnchor.constraint(equalToConstant: 23.48.scale),
            lockView.heightAnchor.constraint(equalToConstant: 34.29.scale),
            lockView.centerXAnchor.constraint(equalTo: centerXAnchor),
            lockView.topAnchor.constraint(equalTo: topAnchor, constant: 58.66.scale)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dateLabel.topAnchor.constraint(equalTo: lockView.bottomAnchor, constant: 4.scale)
        ])
        
        NSLayoutConstraint.activate([
            lightView.widthAnchor.constraint(equalToConstant: 50.scale),
            lightView.heightAnchor.constraint(equalToConstant: 50.scale),
            lightView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 44.scale),
            lightView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50.scale)
        ])
        
        NSLayoutConstraint.activate([
            cameraView.widthAnchor.constraint(equalToConstant: 50.scale),
            cameraView.heightAnchor.constraint(equalToConstant: 50.scale),
            cameraView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -44.scale),
            cameraView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension WPLockscreenView {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeDateLabel() -> UILabel {
        let timeAttrs = TextAttributes()
            .textColor(Appearance.v4White)
            .font(Fonts.Sen.regular(size: 83.scale))
            .lineHeight(99.scale)
            .textAlignment(.center)
            .letterSpacing(-0.24.scale)
        let dateAttrs = TextAttributes()
            .textColor(Appearance.v4White)
            .font(Fonts.Sen.regular(size: 22.scale))
            .lineHeight(28.scale)
            .textAlignment(.center)
            .letterSpacing(0.35.scale)
        
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        
        let date = Date()
        
        formatter.dateFormat = "HH:mm"
        let timeString = formatter.string(from: date) + "\n"
        
        formatter.dateFormat = "EEEE, MMMM d"
        let dateString = formatter.string(from: date)
        
        let result = NSMutableAttributedString()
        result.append(timeString.attributed(with: timeAttrs))
        result.append(dateString.attributed(with: dateAttrs))
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = result
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
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
        addSubview(view)
        return view
    }
    
    func makeLockView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "WallpapersPreview.Lock")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeLightView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "WallpapersPreview.Light")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCameraView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "WallpapersPreview.Camera")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
