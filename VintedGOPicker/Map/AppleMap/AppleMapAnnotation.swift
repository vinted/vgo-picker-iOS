import MapKit
import UIKit

final class AppleMapAnnotation: NSObject {

    let pin: Map.Pin
    let rating: Int

    init(pin: Map.Pin, rating: Int) {
        self.pin = pin
        self.rating = rating
    }
}

extension AppleMapAnnotation: MKAnnotation {

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: pin.coordinate.latitude, longitude: pin.coordinate.longitude)
    }
}

extension AppleMapAnnotation: Reusable {}
