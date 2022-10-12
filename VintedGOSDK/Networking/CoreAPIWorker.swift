import Foundation

class CoreAPIWorker {

    private let urlSession = URLSession.shared
    private let dependencies: NetworkingDependencies
    
    var authorizationToken: String?

    init(networkingDependencies: NetworkingDependencies = .sandbox) {
        dependencies = networkingDependencies
    }

    func performRequest<T: Decodable>(request: Requestable, completion: @escaping (Result<T, NetworkError>) -> Void) {
        func finish(result: Result<T, NetworkError>, completion: @escaping (Result<T, NetworkError>) -> Void) {
            DispatchQueue.main.async {
                completion(result)
            }
        }

        guard let urlRequest = makeUrlRequest(dependencies: dependencies, request: request) else {
            finish(result: .failure(.invalidEndpoint), completion: completion)
            return
        }

        urlSession.dataTask(with: urlRequest) { data, response, error  in
             guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                finish(result: .failure(.invalidResponse), completion: completion)
                return
            }

            guard (200 ... 299).contains(statusCode) else {
                finish(result: .failure(.invalidResponse), completion: completion)
                return
            }

            guard error == nil else {
                finish(result: .failure(.apiError), completion: completion)
                return
            }

            guard let data = data else {
                finish(result: .failure(.noData), completion: completion)
                return
            }

            Logger.shared.log(NSString(string: String(data: data, encoding: .utf8) ?? ""))

            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                finish(result: .success(result), completion: completion)
            } catch {
                finish(result: .failure(.decodeError), completion: completion)
            }
        }.resume()
    }

    private func makeUrlRequest(dependencies: NetworkingDependencies, request: Requestable) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = dependencies.scheme
        urlComponents.host = dependencies.host
        urlComponents.path = request.path

        urlComponents.queryItems = request.query.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let unprocessedUrl = urlComponents.url,
              let url = URL(string: unprocessedUrl.absoluteString.replacingOccurrences(of: "%2F", with: "/")) else {
            return nil
        }

        var urlRequest = URLRequest(url: url)

        var headers = [String: String]()
        
        headers["accept"] = "application/json"

        if let authorizationToken = authorizationToken {
            headers["authorization: Basic "] = authorizationToken
        }

        switch request.method {
        case .delete:
            urlRequest.httpMethod = "DELETE"
        case .get:
            urlRequest.httpMethod  = "GET"
        case .post:
            urlRequest.httpBody = try? request.encode(using: JSONEncoder())
            urlRequest.httpMethod = "POST"
            headers["Content-type"] = "application/x-www-form-urlencoded"
        case .patch:
            urlRequest.httpMethod = "PATCH"
        case .put:
            urlRequest.httpMethod = "PUT"
        }

        headers.merge(request.headers, uniquingKeysWith: { _, new in new })

        urlRequest.allHTTPHeaderFields = headers

        return urlRequest
    }
}
