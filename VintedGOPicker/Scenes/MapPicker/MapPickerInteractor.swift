import VintedGOSDK

protocol MapPickerInteracting {
    
    func setup()
    func selectPickupPoint(with pickupPointCode: String)
    func unselectPickupPoint()
    func confirmPickupPoint()
}

final class MapPickerInteractor {
    
    private let presenter: MapPickerPresenting
    private let worker: MapPickerWorking
    
    private var state: MapPicker.Data
    
    init(presenter: MapPickerPresenting,
         worker: MapPickerWorking,
         pickupPointsResponse: PickupPointsResponse) {
        self.presenter = presenter
        self.worker = worker
        self.state = .pickupsPoints(pickupPointsResponse: pickupPointsResponse)
    }
}

extension MapPickerInteractor: MapPickerInteracting {
    
    func setup() {
        presenter.present(state)
        presentState()
    }
    
    func selectPickupPoint(with pickupPointCode: String) {
        state = state.with(selectedPickupPointCode: pickupPointCode)
        presentState()
    }
    
    func confirmPickupPoint() {
        state = state.withConfirmedPickupPoint
        presentState()
    }
    
    func unselectPickupPoint() {
        state = state.withoutSelectedPickupPoint
        presentState()
    }
    
    private func presentState() {
        presenter.present(state)
    }
}

extension MapPicker.Data {
    
    func with(selectedPickupPointCode: String) -> Self {
        guard let pickupPointsResponse = pickupPointsResponse else {
            return self
        }
        
        return .pickupPointsWithSelection(
            pickupPointsResponse: pickupPointsResponse,
            selectedPickupPointCode: selectedPickupPointCode
        )
    }
    
    var withoutSelectedPickupPoint: Self {
        guard let pickupPointsResponse = pickupPointsResponse else {
            return self
        }
        
        return .pickupsPoints(pickupPointsResponse: pickupPointsResponse)
    }
    
    var withConfirmedPickupPoint: Self {
        guard let selectedPickupPointCode = selectedPickupPointCode else {
            return self
        }
        
        return .confirmedPickupPoint(selectedPickupPointCode: selectedPickupPointCode)
    }
    
    var pickupPointsResponse: PickupPointsResponse? {
        switch self {
        case .confirmedPickupPoint:
            return nil
        case .pickupPointsWithSelection(let pickupPointsResponse, _):
            return pickupPointsResponse
        case .pickupsPoints(let pickupPointsResponse):
            return pickupPointsResponse
        }
    }
    
    var selectedPickupPointCode: String? {
        switch self {
        case .confirmedPickupPoint(let selectedPickupPointCode):
            return selectedPickupPointCode
        case .pickupPointsWithSelection(_, let selectedPickupPointCode):
            return selectedPickupPointCode
        case .pickupsPoints:
            return nil
        }
    }
}
