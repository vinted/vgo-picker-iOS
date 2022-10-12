import UIKit

public struct VintedGOPicker {
    
    private let rootViewController: UIViewController
    
    public init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    public func start(pickupPointResponse: PickupPointsResponse,
                      completion: @escaping (_ shippingPointCode: String) -> ()) {
        let viewController = MapPickerFactory.makeViewController(
            pickupPointsResponse: pickupPointResponse,
            completion: { shippingPointCode in
                rootViewController.dismiss(animated: true)
                completion(shippingPointCode)
            }
        )
        
        rootViewController.present(viewController, animated: true)
    }
}
