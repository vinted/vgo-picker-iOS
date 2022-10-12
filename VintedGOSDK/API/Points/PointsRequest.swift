struct PointsRequest {
    
    let orderId: String
}

extension PointsRequest: Requestable {
    
    var path: String { "/orders/\(orderId)/pudo_points" }
    var method: RequestMethod { .get }
}
