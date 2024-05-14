//
//  WallpapersPreviewViewModel.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 26.04.2024.
//

import RxSwift
import RxCocoa

final class WallpapersPreviewViewModel {
    enum Route {
        case close
        case toast(String)
        case lockscreen(Bool)
    }
}

// MARK: Public
extension WallpapersPreviewViewModel {
    struct Input {
        let didTapClose: Signal<Void>
        let didSaveResult: Signal<PhotoLibraryWrapper.Result>
        let didTapLockscreen: Signal<Void>
    }
    
    struct Output {
        let route: Driver<Route>
    }
    
    func configure(input: Input) -> Output {
        Output(
            route: makeRoute(
                didTapClose: input.didTapClose,
                didSaveResult: input.didSaveResult,
                didTapLockscreen: input.didTapLockscreen
            )
        )
    }
}

// MARK: Private
private extension WallpapersPreviewViewModel {
    func makeRoute(
        didTapClose: Signal<Void>,
        didSaveResult: Signal<PhotoLibraryWrapper.Result>,
        didTapLockscreen: Signal<Void>
    ) -> Driver<Route> {
        let close = didTapClose
            .map { Route.close }
            .asDriver(onErrorDriveWith: .never())
        
        let toast = didSaveResult
            .map { result -> String in
                switch result {
                case .deniedPermission:
                    return "WallpapersPreview.Result.NotPermission".localized
                case .failure:
                    return "WallpapersPreview.Result.Failure".localized
                case .savedToPhotosAlbum:
                    return "WallpapersPreview.Result.Success".localized
                }
            }
            .map { Route.toast($0) }
            .asDriver(onErrorDriveWith: .never())
        
        let lockscreen = didTapLockscreen
            .scan(false) { showing, _ -> Bool in !showing }
            .startWith(false)
            .map { Route.lockscreen($0) }
            .asDriver(onErrorDriveWith: .never())
        
        return Driver
            .merge(close, toast, lockscreen)
    }
}
