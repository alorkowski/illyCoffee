import Foundation
@testable import illyCoffee

final class MockNetworkingService: NetworkingService {
    func getLocalData<T: Decodable>(forResource fileName: String,
                                    ofType fileExtension: String,
                                    completion: @escaping (Result<T, NetworkError>) -> Void) {
        let data = try! JSONSerialization.data(withJSONObject: MockCoffeeData.json, options:[])
        let decodedData = try! JSONDecoder().decode(T.self, from: data)
        completion(.success(decodedData))
    }
}
