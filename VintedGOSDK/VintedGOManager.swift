import UIKit
public final class VintedGOManager {
    
    public var environment: Environment = .sandbox
    
    private let authorizationWorker: AuthorizationWorking = AuthorizationWorker()
    private let pointsWorker: PointsWorking = PointsWorker()
    private let encoder: Encoding = Encoder()
    
    private var authorizationToken: String? = "80c66481385991805320b37eb1749157fecf0fe42b72c77ce10ca58feb0336a549352df2c1f04d7c9ce399f1e9caace11bd26c14250859069b84d71bb7c807cf"
    
    public func authorize(with credentials: VintedGOCredentials, completion: @escaping () -> Void) {
        let concatenatedCredentials = credentials.userId + ":" + credentials.userSecret
        let base64encodedClientIdAndSecret = encoder.convertToBase64(string: concatenatedCredentials)
        let request = AuthorizationRequest(base64encodedClientIdAndSecret: base64encodedClientIdAndSecret)
        
        authorizationWorker.authorize(with: request) { [weak self] result in
            switch result {
            case.success(let request):
                self?.authorizationToken = request.accessToken
            case.failure:
                print("failure")
                #warning("failure not implemented")
            }
        }
    }
    
    public func fetchPoints(for orderId: String, completion: @escaping () -> Void) {
        
    }
}

public struct VintedGOCredentials {
    
    let userId: String
    let userSecret: String
}
