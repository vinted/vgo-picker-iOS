import UIKit
@testable
import VintedGOSDK
import VintedGOPicker

final class ViewController: UIViewController {
    
    private lazy var picker = VintedGOPicker(rootViewController: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startVintedPicker()
    }
    
    private func startVintedPicker() {
        picker.start(
            pickupPointResponse: pickupPointResponseStub,
            coordinates: .init(latitude: 52, longitude: 42),
            completion: { pickupPointCode in
                print(pickupPointCode)
            }
        )
    }
    
    private var pickupPointResponseStub: PickupPointsResponse {
        [
            .init(
                carrier: "Chronopost",
                service: "Shop2Shop by Chronopost",
                distance: 0.5285805233452836,
                distanceUnit: "km",
                point: .init(
                    code: "8c4bfbe6-fdea-4030-821b-c0cbaec2cc4d",
                    name: "Locker DE00013105",
                    pointDescription: "The locker is located in the carpark to the left of the atrium entrance",
                    addressLine1: "Hauptstr 4",
                    addressLine2: "5 - 7",
                    postalCode: "10827",
                    city: "Berlin",
                    countryCode: "DE",
                    latitude: "50.45830680468374",
                    longitude: "30.514632075325878",
                    photoURL: "https://ww2.mondialrelay.com/public/permanent/photo_relais.aspx?num=02043&pays=FR",
                    businessHours: []
                )
            ),
            .init(
                carrier: "Mondial",
                service: "Shop2Shop by Chronopost",
                distance: 0.5285805233452836,
                distanceUnit: "km",
                point: .init(
                    code: "8c4bfbe6-fdea-4030-821b-c0cbaec2cc4c",
                    name: "Locker DE00013105",
                    pointDescription: "The locker is located in the carpark to the left of the atrium entrance",
                    addressLine1: "Baumil street 33322",
                    addressLine2: "5 - 7",
                    postalCode: "10827",
                    city: "Berlin",
                    countryCode: "DE",
                    latitude: "50.458360680468374",
                    longitude: "30.514320732578",
                    photoURL: "https://ww2.mondialrelay.com/public/permanent/photo_relais.aspx?num=02043&pays=FR",
                    businessHours: []
                )
            ),
            .init(
                carrier: "DPD",
                service: "Shop2Shop by Chronopost",
                distance: 0.5285805233452836,
                distanceUnit: "km",
                point: .init(
                    code: "8c4bfbe6-fdea-4030-821b-c0cbaec2cc4e",
                    name: "Coffee shop",
                    pointDescription: "The locker is located in the carpark to the left of the atrium entrance",
                    addressLine1: "Svitrigailos 59-4",
                    addressLine2: "5 - 7",
                    postalCode: "10827",
                    city: "Berlin",
                    countryCode: "DE",
                    latitude: "50.458368046874",
                    longitude: "30.514632075325878",
                    photoURL: "https://ww2.mondialrelay.com/public/permanent/photo_relais.aspx?num=02043&pays=FR",
                    businessHours: []
                )
            )
        ]
    }
}
