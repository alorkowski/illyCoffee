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
