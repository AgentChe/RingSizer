//
//  WallpapersPreviewViewController.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 26.04.2024.
//

import UIKit
import RxSwift
import RxCocoa
import Toast_Swift

final class WallpapersPreviewViewController: UIViewController {
    private lazy var mainView = WallpapersPreviewView()
    
    private lazy var viewModel = WallpapersPreviewViewModel()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var photoLibrary = PhotoLibraryWrapper()
    
    private let category: WallpaperCategory
    private let initial: Wallpaper
    
    private init(category: WallpaperCategory, selected: Wallpaper) {
        self.category = category
        self.initial = selected
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hideLockscreenGesture = UITapGestureRecognizer()
        mainView.lockscreenView.addGestureRecognizer(hideLockscreenGesture)
        mainView.lockscreenView.isUserInteractionEnabled = true
        
        mainView.saveButton.rx.tap
            .compactMap { [weak self] in self?.mainView.collectionView.currentWallpaper() }
            .bind(to: Binder(self) { base, wallpaper in
                base.photoLibrary.write(imageUrl: wallpaper.imageUrl.absoluteString)
            })
            .disposed(by: disposeBag)
        
        let didTapLockscreen = Signal
            .merge(
                hideLockscreenGesture.rx.event
                    .mapToVoid()
                    .asSignal(onErrorSignalWith: .never()),
                mainView.previewButton.rx.tap
                    .asSignal()
            )
        
        let output = viewModel.configure(input: WallpapersPreviewViewModel.Input(
            didTapClose: mainView.backButton.rx.tap.asSignal(),
            didSaveResult: photoLibrary.didResult,
            didTapLockscreen: didTapLockscreen
        ))
        
        output.route
            .drive(Binder(self) { base, route in
                base.route(route)
            })
            .disposed(by: disposeBag)
        
        mainView.collectionView.setup(
            elements: category.wallpapers, 
            scrollTo: initial
        )
    }
}

// MARK: Public
extension WallpapersPreviewViewController {
    static func make(category: WallpaperCategory, selected: Wallpaper) -> WallpapersPreviewViewController {
        let vc = WallpapersPreviewViewController(category: category, selected: selected)
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}

// MARK: Private
private extension WallpapersPreviewViewController {
    func route(_ route: WallpapersPreviewViewModel.Route) {
        switch route {
        case .close:
            navigationController?.popViewController(animated: true)
        case .toast(let message):
            var style = ToastStyle()
            style.messageFont = Fonts.Sen.regular(size: 16.scale)
            style.messageColor = Appearance.v4DarkGrey
            style.cornerRadius = 0
            style.backgroundColor = Appearance.v4White
            
            mainView.makeToast(message, position: .center, style: style)
        case .lockscreen(let showing):
            mainView.lockscreenView.isHidden = !showing
            mainView.saveButton.isHidden = showing
            mainView.previewButton.isHidden = showing
            mainView.backButton.isHidden = showing
        }
    }
}
