import UIKit

enum ImageCacheError: Error {
    case imageNotFound
}

final class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
}

// MARK: Cache Methods
extension ImageCache {
    func retrieveImage(for key: String,
                       animation: (() -> Void)?,
                       completion: @escaping (Result<UIImage, ImageCacheError>) -> Void) {
        if let image = self.cache.object(forKey: NSString(string: key)) {
            completion(.success(image))
            return
        }
        animation?()
        DispatchQueue.global(qos: .default).async {
            guard let image = UIImage(named: key) else {
                completion(.failure(.imageNotFound))
                return
            }
            self.cache.setObject(image, forKey: NSString(string: key))
            completion(.success(image))
        }
    }
}
