import Foundation

enum RequestMethod {
    case post, get, put, patch, delete
}

protocol Requestable: Encodable {

    var path: String { get }
    var method: RequestMethod { get }
    var headers: [String: String] { get }
    var query: [String: String] { get }
}

extension Requestable {

    var headers: [String: String] { [:] }
    var query: [String: String] { [:] }

    func encode(using encoder: JSONEncoder) throws -> Data {
        try encoder.encode(self)
    }
}
