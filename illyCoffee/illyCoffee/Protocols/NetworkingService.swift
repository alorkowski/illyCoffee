import Foundation

protocol NetworkingService {
    func getLocalData<T: Decodable>(forResource fileName: String,
                                    ofType fileExtension: String,
                                    completion: @escaping (Result<T, NetworkError>) -> Void)
}
