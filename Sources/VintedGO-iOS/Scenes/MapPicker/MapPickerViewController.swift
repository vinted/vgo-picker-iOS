import UIKit

protocol MapPickerDisplaying: AnyObject {
    
    func display(_ state: MapPicker.View)
    func displayConfirmation(with pickupPointCode: String)
}

final class MapPickerViewController: UIViewController {
    
    private let interactor: MapPickerInteracting
    private let router: MapPickerRouting
    private let completion: (_ shippingPointCode: String) -> ()
    
    private var mapPickerView: MapPickerView?
    
    init(interactor: MapPickerInteracting,
         router: MapPickerRouting,
         completion: @escaping (_ shippingPointCode: String) -> ()) {
        self.interactor = interactor
        self.router = router
        self.completion = completion
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        interactor.setup()
    }
}

extension MapPickerViewController: MapPickerDisplaying {
    
    func display(_ state: MapPicker.View) {
        if mapPickerView == nil {
            mapPickerView = MapPickerView(with: state)
            mapPickerView?.onPickupPointSelect = { [weak self] pickupPointCode in
                self?.interactor.selectPickupPoint(with: pickupPointCode)
            }
            mapPickerView?.onPickupPointConfirm = { [weak self] in
                self?.interactor.confirmPickupPoint()
            }
            mapPickerView?.onUnselectPickupPoint = { [weak self] in
                self?.interactor.unselectPickupPoint()
            }
            
            view = mapPickerView
            
            mapPickerView?.updateMap(with: state, shouldZoomToPins: true)
        } else {
            mapPickerView?.updateMap(with: state, shouldZoomToPins: false)
        }
        
        mapPickerView?.updateSelectedPickupPointDetails(with: state)
    }
    
    func displayConfirmation(with pickupPointCode: String) {
        completion(pickupPointCode)
    }
}
