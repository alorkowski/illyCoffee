import UIKit

enum ImageCacheError: Error {
    case imageNotFound
}

final class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
}

// MARK: Cache Functions
extension ImageCache {
    func retreiveImage(for key: String, completion: (Result<UIImage, ImageCacheError>) -> Void) {
        if let image = cache.object(forKey: NSString(string: key)) {
            completion(.success(image))
        }
        guard let image = UIImage(named: key) else { completion(.failure(.imageNotFound)); return }
        completion(.success(image))
    }
}
