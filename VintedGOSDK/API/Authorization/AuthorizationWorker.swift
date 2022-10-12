protocol AuthorizationWorking {

    func authorize(with request: AuthorizationRequest,
                   completion: @escaping (Result<AuthorizationResponse, NetworkError>) -> Void)
}

final class AuthorizationWorker: CoreAPIWorker {}

extension AuthorizationWorker: AuthorizationWorking {

    func authorize(with request: AuthorizationRequest,
                   completion: @escaping (Result<AuthorizationResponse, NetworkError>) -> Void) {
        performRequest(request: request, completion: completion)
    }
}
