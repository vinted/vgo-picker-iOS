import UIKit

final class MapView: UIView {

    private lazy var mapView: UIView & MapProviding = {
        AppleMapView()
    }()

    init() {
        super.init(frame: .zero)
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initialize() {
        
        embed(view: mapView, inContainerView: self)
    }

    func setup(_ map: Map) {
        if let region = map.region {
            mapView.zoom(to: region)
        }

        if let isUserLocationMarkerEnabled = map.isUserLocationMarkerEnabled {
            mapView.isUserLocationMarkerEnabled = isUserLocationMarkerEnabled
        }

        mapView.onTap = map.onTap
        mapView.onDoubleTap = map.onDoubleTap
        mapView.onViewPortChange = map.onViewPortChange
        mapView.onSelect = map.onPinSelect
        mapView.onUserZoom = map.onUserZoom
        mapView.onUserScroll = map.onUserScroll

        if let markers = map.markers {
            mapView.add(markers)
        }

        if let logoBottomPadding = map.logoBottomPadding {
            mapView.logoBottomPadding = logoBottomPadding
        }
    }
}
