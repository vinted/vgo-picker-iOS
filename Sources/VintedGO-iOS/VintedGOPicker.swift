import UIKit

public struct VintedGOPicker {
    
    public struct Coordinates {
        
        let latitude: Double
        let longitude: Double
        
        public init(latitude: Double, longitude: Double) {
            self.latitude = latitude
            self.longitude = longitude
        }
    }
    
    private let rootViewController: UIViewController
    
    public init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    public func start(pickupPointResponse: PickupPointsResponse,
                      coordinates: Coordinates,
                      completion: @escaping (_ shippingPointCode: String) -> ()) {
        let viewController = MapPickerFactory.makeViewController(
            pickupPointsResponse: pickupPointResponse,
            coordinates: coordinates,
            completion: { shippingPointCode in
                rootViewController.dismiss(animated: true)
                completion(shippingPointCode)
            }
        )
        
        rootViewController.present(viewController, animated: true)
    }
}
