enum MapPicker {
    
    struct content {
        
        let pickupPointsResponse: PickupPointsResponse
        var selectedPickupPointCode: String?
        var isPickupPointConfirmed: Bool
    }
    
    enum Data {
        
        case pickupsPoints(pickupPointsResponse: PickupPointsResponse)
        case pickupPointsWithSelection(pickupPointsResponse: PickupPointsResponse, selectedPickupPointCode: String)
        case confirmedPickupPoint(selectedPickupPointCode: String)
    }
    
    struct View {
        
        struct Details {
            
            let carrierName: String
            let pickupPointName: String
            let address: String
        }
        
        struct PickupPoint {
            
            let latitude: Double
            let longitude: Double
            let isSelected: Bool
            let code: String
        }
        
        let pickupPoints: [PickupPoint]
        let details: Details?
    }
}
