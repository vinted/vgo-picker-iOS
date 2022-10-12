import UIKit

protocol MapProviding {

    var onTap: (() -> Void)? { get set }
    var onDoubleTap: (() -> Void)? { get set }
    var onUserScroll: (() -> Void)? { get set }
    var onUserZoom: (() -> Void)? { get set }
    var onSelect: ((Map.Pin) -> Void)? { get set }

    var logoBottomPadding: CGFloat { get set }
    var isUserLocationMarkerEnabled: Bool { get set }

    var onViewPortChange: ((Map.ViewPort) -> Void)? { get set }
    var onZoomComplete: ((Bool) -> Void)? { get set }

    func zoom(to region: Map.Region)
    func add(_ markers: Map.Markers)
}
