//
//  WallpapersViewModel.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 26.04.2024.
//

import RxSwift
import RxCocoa

final class WallpapersViewModel {
    enum Route {
        case close
        case selected((WallpaperCategory, Wallpaper))
    }
}

// MARK: Public
extension WallpapersViewModel {
    struct Input {
        let category: WallpaperCategory
        let didTapClose: Signal<Void>
        let didSelect: Signal<Wallpaper>
    }
    
    struct Output {
        let elements: Driver<[Wallpaper]>
        let route: Driver<Route>
    }
    
    func configure(input: Input) -> Output {
        Output(
            elements: makeElements(category: input.category),
            route: makeRoute(
                category: input.category,
                didTapClose: input.didTapClose,
                didSelect: input.didSelect
            )
        )
    }
}

// MARK: Private
private extension WallpapersViewModel {
    func makeElements(category: WallpaperCategory) -> Driver<[Wallpaper]> {
        BehaviorRelay(value: category)
            .asDriver()
            .map { category -> [Wallpaper] in
                category.wallpapers
            }
    }
    
    func makeRoute(
        category: WallpaperCategory,
        didTapClose: Signal<Void>,
        didSelect: Signal<Wallpaper>
    ) -> Driver<Route> {
        let close = didTapClose
            .map { Route.close }
            .asDriver(onErrorDriveWith: .never())
        
        let selected = didSelect
            .map { Route.selected((category, $0)) }
            .asDriver(onErrorDriveWith: .never())
        
        return Driver
            .merge(close, selected)
    }
}
