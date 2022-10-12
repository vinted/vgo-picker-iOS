protocol PointsWorking {

    func fetch(with request: PointsRequest,
               completion: @escaping (Result<PickupPointsResponse, NetworkError>) -> Void)
}

final class PointsWorker: CoreAPIWorker {}

extension PointsWorker: PointsWorking {

    func fetch(with request: PointsRequest,
               completion: @escaping (Result<PickupPointsResponse, NetworkError>) -> Void) {
        performRequest(request: request, completion: completion)
    }
}
