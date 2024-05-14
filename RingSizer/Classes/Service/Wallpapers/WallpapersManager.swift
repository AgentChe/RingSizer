//
//  WallpapersManager.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 25.04.2024.
//

import RxSwift

protocol WallpapersManagerProtocol {
    func obtainCategories() -> Single<[WallpaperCategory]>
}

final class WallpapersManager {
    private lazy var restApiTransport = RestAPITransport()
}

// MARK: WallpapersManagerProtocol
extension WallpapersManager: WallpapersManagerProtocol {
    func obtainCategories() -> Single<[WallpaperCategory]> {
        restApiTransport
            .callServerApi(requestBody: GetWallpapersCategoriesRequest())
            .map { WallpaperCategory.map(from: $0) }
    }
}
