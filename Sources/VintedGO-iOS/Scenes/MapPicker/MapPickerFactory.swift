import UIKit

struct MapPickerFactory {
    
    static func makeViewController(pickupPointsResponse: PickupPointsResponse,
                                   coordinates: VintedGOPicker.Coordinates,
                                   completion: @escaping (_ shippingPointCode: String) -> ()) -> UIViewController {
        let presenter = MapPickerPresenter()
        let interactor = MapPickerInteractor(
            presenter: presenter,
            worker: MapPickerWorker(),
            pickupPointsResponse: pickupPointsResponse
        )
        let router = MapPickerRouter()
        let viewController = MapPickerViewController(
            interactor: interactor,
            router: router,
            completion: completion
        )
        router.viewController = viewController
        presenter.viewController = viewController
        
        return viewController
    }
}
