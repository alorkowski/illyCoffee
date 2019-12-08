import Foundation

enum NetworkError: Error {
    case fileNotFound
    case defaultError(Error)
    case noData
    case invalidData

    var localizedDescription: String {
        switch self{
        case .fileNotFound: return "File not found."
        case .defaultError(let error): return error.localizedDescription
        case .noData: return "No data available from file."
        case .invalidData: return "Data cannot be decoded."
        }
    }
}

final class NetworkService {
    func getLocalData<T: Decodable>(forResource fileName: String,
                                    ofType fileExtension: String,
                                    completion: @escaping (Result<T, NetworkError>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
                completion(.failure(.fileNotFound))
                return
            }
            guard let data = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.invalidData))
                return
            }
            completion(.success(decodedData))
        }
    }

//    func getLocalData<T: Decodable>(forResource fileName: String,
//                                    ofType fileExtension: String,
//                                    completion: @escaping (Result<T, NetworkError>) -> Void) {
//        guard let path = Bundle.main.path(forResource: fileName, ofType: fileExtension) else {
//            completion(.failure(.fileNotFound))
//            return
//        }
//        URLSession.shared.dataTask(with: URL(fileURLWithPath: path)) { (data, _, error) in
//            if let error = error {
//                completion(.failure(.defaultError(error)))
//                return
//            }
//            guard let data = data else {
//                completion(.failure(.noData))
//                return
//            }
//            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
//                completion(.failure(.invalidData))
//                return
//            }
//            completion(.success(decodedData))
//        }.resume()
//    }
}
