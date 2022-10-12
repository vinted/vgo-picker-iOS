import UIKit

final class Map {

    struct Markers {

        let pins: [Pin]
        let shouldZoomToPins: Bool
    }

    struct ViewPort {

        let centerCoordinate: Coordinate
    }

    let region: Region?
    let onTap: (() -> Void)?
    let onDoubleTap: (() -> Void)?
    let onViewPortChange: ((ViewPort) -> Void)?
    let onZoomComplete: ((Bool) -> Void)?
    let onPinSelect: ((Pin) -> Void)?
    let onUserScroll: (() -> Void)?
    let onUserZoom: (() -> Void)?

    let logoBottomPadding: CGFloat?
    let markers: Markers?

    let isUserLocationMarkerEnabled: Bool?

    let accessibilityIdentifier: String?

    init(region: Region? = nil,
         accessibilityIdentifier: String? = nil,
         onTap: (() -> Void)? = nil,
         onDoubleTap: (() -> Void)? = nil,
         onUserScroll: (() -> Void)? = nil,
         onUserZoom: (() -> Void)? = nil,
         logoBottomPadding: CGFloat? = nil,
         onViewPortChange: ((ViewPort) -> Void)? = nil,
         onZoomComplete: ((Bool) -> Void)? = nil,
         onPinSelect: ((Map.Pin) -> Void)? = nil,
         markers: Markers? = nil,
         isUserLocationMarkerEnabled: Bool? = nil) {
        self.region = region
        self.accessibilityIdentifier = accessibilityIdentifier
        self.onTap = onTap
        self.onDoubleTap = onDoubleTap
        self.onUserScroll = onUserScroll
        self.onUserZoom = onUserZoom
        self.logoBottomPadding = logoBottomPadding
        self.onViewPortChange = onViewPortChange
        self.onZoomComplete = onZoomComplete
        self.onPinSelect = onPinSelect
        self.markers = markers
        self.isUserLocationMarkerEnabled = isUserLocationMarkerEnabled
    }
}
