import UIKit
import CoreLocation

extension Map {
    
    final class Pin {

        let image: UIImage
        let coordinate: Coordinate
        let content: Any?

        let isExcludedFromZoomingToPins: Bool
        let isSelected: Bool
        
        let code: String

        init(image: UIImage,
             coordinate: Coordinate,
             content: Any? = nil,
             code: String,
             isExcludedFromZoomingToPins: Bool,
             isSelected: Bool) {
            self.image = image
            self.coordinate = coordinate
            self.content = content
            self.code = code
            self.isExcludedFromZoomingToPins = isExcludedFromZoomingToPins
            self.isSelected = isSelected
        }
    }
}

extension Map.Pin: Equatable {

    static func == (lhs: Map.Pin, rhs: Map.Pin) -> Bool {
        lhs.isExcludedFromZoomingToPins == rhs.isExcludedFromZoomingToPins &&
            lhs.coordinate.latitude == rhs.coordinate.latitude &&
            lhs.coordinate.longitude == rhs.coordinate.longitude &&
            lhs.image == rhs.image
    }
}
