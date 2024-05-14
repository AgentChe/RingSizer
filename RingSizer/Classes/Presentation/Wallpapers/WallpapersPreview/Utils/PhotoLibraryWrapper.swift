//
//  PhotoLibraryWrapper.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 26.04.2024.
//

import Photos
import RxSwift
import RxCocoa
import Kingfisher

final class PhotoLibraryWrapper: NSObject {
    enum Result {
        case deniedPermission
        case savedToPhotosAlbum
        case failure
    }
    
    private let didResultTrigger = PublishRelay<Result>()
}

// MARK: Public
extension PhotoLibraryWrapper {
    func write(imageUrl: String) {
        permissionIsGranted(imageUrl: imageUrl)
    }
    
    var didResult: Signal<Result> {
        didResultTrigger.asSignal()
    }
}

// MARK: Private
private extension PhotoLibraryWrapper {
    func permissionIsGranted(imageUrl: String) {
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            DispatchQueue.main.async {
                switch status {
                case .denied:
                    self?.didResultTrigger.accept(.deniedPermission)
                default:
                    self?.retrieveImage(imageUrl: imageUrl)
                }
            }
        }
    }
    
    func retrieveImage(imageUrl: String) {
        DispatchQueue.global().async {
            ImageCache.default.retrieveImage(forKey: imageUrl) { [weak self] result in
                DispatchQueue.main.async {
                    guard case let .success(cache) = result, let cgImage = cache.image?.cgImage else {
                        self?.didResultTrigger.accept(.failure)
                        
                        return
                    }
                
                    let image = UIImage(cgImage: cgImage)
                    
                    self?.saveToAlbum(image: image)
                }
            }
        }
    }
    
    func saveToAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        DispatchQueue.main.async { [weak self] in
            let result = error != nil ? Result.failure : Result.savedToPhotosAlbum
            
            self?.didResultTrigger.accept(result)
        }
    }
}
