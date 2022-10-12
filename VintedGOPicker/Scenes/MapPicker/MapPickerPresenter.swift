import VintedGOSDK

protocol MapPickerPresenting {
    
    func present(_ state: MapPicker.Data)
}

final class MapPickerPresenter {
    
    weak var viewController: MapPickerDisplaying?
}

extension MapPickerPresenter: MapPickerPresenting {
    
    func present(_ state: MapPicker.Data) {
        switch state {
        case .pickupsPoints(pickupPointsResponse: let pickupPointsResponse):
            viewController?.display(makeState(from: pickupPointsResponse, selectedPickupPointCode: nil))
        case .pickupPointsWithSelection(let pickupPointsResponse, let selectedPickupPointCode):
            viewController?.display(makeState(from: pickupPointsResponse, selectedPickupPointCode: selectedPickupPointCode))
        case .confirmedPickupPoint(let selectedPickupPoint):
            viewController?.displayConfirmation(with: selectedPickupPoint)
        }
    }
    
    private func makeState(from pickupPointsResponse: PickupPointsResponse,
                       selectedPickupPointCode: String?) -> MapPicker.View {
        .init(
            pickupPoints:
                pickupPoints(
                    from: pickupPointsResponse,
                    selectedPickupPointCode: selectedPickupPointCode
                ),
            details: details(from: pickupPointsResponse, when: selectedPickupPointCode)
        )
    }
    
    private func pickupPoints(from pickupPointsResponse: PickupPointsResponse,
                              selectedPickupPointCode: String?) -> [MapPicker.View.PickupPoint] {
        pickupPointsResponse.compactMap {
            guard let latitude = Double($0.point.latitude),
                  let longitude = Double($0.point.longitude) else {
                return nil
            }
            
            return MapPicker.View.PickupPoint(
                latitude: latitude,
                longitude: longitude,
                isSelected: $0.point.code == selectedPickupPointCode,
                code: $0.point.code
            )
        }
    }
    
    private func details(from pickupPointsResponse: PickupPointsResponse,
                         when selectedPickupPointCode: String?) -> MapPicker.View.Details? {
        guard let selectedPickupPoint = pickupPointsResponse.first(where: { $0.point.code == selectedPickupPointCode }) else {
            return nil
        }
        
        return .init(
            carrierName: selectedPickupPoint.carrier,
            pickupPointName: selectedPickupPoint.point.name,
            address: selectedPickupPoint.point.addressLine1
        )
    }
}
