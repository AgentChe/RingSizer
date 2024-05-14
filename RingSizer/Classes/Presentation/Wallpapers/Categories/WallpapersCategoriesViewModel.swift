//
//  WallpapersCategoriesViewModel.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 26.04.2024.
//

import RxSwift
import RxCocoa

final class WallpapersCategoriesViewModel {
    enum Route {
        case selected(WallpaperCategory)
        case settings
    }
    
    private lazy var activity = RxActivityIndicator()
    
    private lazy var wallpapersManager = WallpapersManager()
}

// MARK: Public
extension WallpapersCategoriesViewModel {
    struct Input {
        let didSelect: Signal<WallpaperCategory>
        let didTapSettings: Signal<Void>
    }
    
    struct Output {
        let elements: Driver<[WallpaperCategory]>
        let route: Driver<Route>
        let activity: Driver<Bool>
    }
    
    func configure(input: Input) -> Output {
        Output(
            elements: makeElements(),
            route: makeRoute(
                didSelect: input.didSelect,
                didTapSettings: input.didTapSettings
            ),
            activity: activity.asDriver()
        )
    }
}

// MARK: Private
private extension WallpapersCategoriesViewModel {
    func makeElements() -> Driver<[WallpaperCategory]> {
        wallpapersManager
            .obtainCategories()
            .trackActivity(activity)
            .asDriver(onErrorJustReturn: [])
    }
    
    func makeRoute(
        didSelect: Signal<WallpaperCategory>,
        didTapSettings: Signal<Void>
    ) -> Driver<Route> {
        let selected = didSelect
            .map { Route.selected($0) }
            .asDriver(onErrorDriveWith: .never())
        
        let settings = didTapSettings
            .map { Route.settings }
            .asDriver(onErrorDriveWith: .never())
        
        return Driver
            .merge(selected, settings)
    }
}
