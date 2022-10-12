import MapKit

final class AppleMapView: UIView {

    private var runningAnimationsCount = 0

    private var onTapHandler: (() -> Void)?
    private var onDoubleTapHandler: (() -> Void)?
    private var onViewPortChangeHandler: ((Map.ViewPort) -> Void)?
    private var onZoomCompleteHandler: ((Bool) -> Void)?
    private var onSelectHandler: ((Map.Pin) -> Void)?
    private var onUserScrollHandler: (() -> Void)?
    private var onUserZoomHandler: (() -> Void)?

    private lazy var mapView: MKMapView = {
        let view = MKMapView()
//        view.tintColor = Color(.primaryDefault)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()

    init() {
        super.init(frame: .zero)
        layout()
        setupGestures()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        embed(view: mapView, inContainerView: self)
    }

    private func setupGestures() {
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.delegate = self
        addGestureRecognizer(singleTapGestureRecognizer)

        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        doubleTapGestureRecognizer.delegate = self
        addGestureRecognizer(doubleTapGestureRecognizer)

        singleTapGestureRecognizer.require(toFail: doubleTapGestureRecognizer)

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleScroll))
        panGestureRecognizer.delegate = self
        addGestureRecognizer(panGestureRecognizer)

        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        pinchGestureRecognizer.delegate = self
        addGestureRecognizer(pinchGestureRecognizer)
    }

    @objc
    private func handleScroll(_ sender: UITapGestureRecognizer) {
        guard sender.state == .ended else {
            return
        }

        onUserScrollHandler?()
    }

    @objc
    private func handlePinch(_ sender: UITapGestureRecognizer) {
        guard sender.state == .ended else {
            return
        }

        onUserZoomHandler?()
    }

    @objc
    private func handleSingleTap(sender: UITapGestureRecognizer) {
        onTapHandler?()
    }

    @objc
    private func handleDoubleTap() {
        onDoubleTapHandler?()
    }
}

extension AppleMapView: MapProviding {

    var onUserScroll: (() -> Void)? {
        get {
            onUserScrollHandler
        }
        set {
            onUserScrollHandler = newValue
        }
    }

    var onUserZoom: (() -> Void)? {
        get {
            onUserZoomHandler
        }
        set {
            onUserZoomHandler = newValue
        }
    }

    var onTap: (() -> Void)? {
        get {
            onTapHandler
        }
        set {
            onTapHandler = newValue
        }
    }

    var onDoubleTap: (() -> Void)? {
        get {
            onDoubleTapHandler
        }
        set {
            onDoubleTapHandler = newValue
        }
    }

    var logoBottomPadding: CGFloat {
        get {
            mapView.layoutMargins.bottom
        }
        set {
            mapView.layoutMargins.bottom = newValue
        }
    }

    var isUserLocationMarkerEnabled: Bool {
        get {
            mapView.showsUserLocation
        }
        set {
            mapView.showsUserLocation = newValue
        }
    }

    var onViewPortChange: ((Map.ViewPort) -> Void)? {
        get {
            onViewPortChangeHandler
        }
        set {
            onViewPortChangeHandler = newValue
        }
    }

    var onZoomComplete: ((Bool) -> Void)? {
        get {
            onZoomCompleteHandler
        }
        set {
            onZoomCompleteHandler = newValue
        }
    }

    var onSelect: ((Map.Pin) -> Void)? {
        get {
            onSelectHandler
        }
        set {
            onSelectHandler = newValue
        }
    }

    func zoom(to region: Map.Region) {
        runningAnimationsCount += 1

        MKMapView.animate(
            withDuration: 1.5,
            animations: { [weak self] in
                self?.mapView.setRegion(region.mkCoordinateRegion, animated: true)
            },
            completion: { [weak self] isFinished in
                guard let self = self, isFinished else {
                    return
                }
                self.runningAnimationsCount -= 1
                self.onZoomCompleteHandler?(self.runningAnimationsCount > 0)
            }
        )
    }

    func add(_ markers: Map.Markers) {
        let annotations: [AppleMapAnnotation] = markers.pins.enumerated().map { index, pin in
            let rating = markers.pins.count - index
            
            return AppleMapAnnotation(pin: pin, rating: rating)
        }

        removePinsMissingIn(annotations)

        annotations.forEach { addPin(for: $0) }

        if markers.shouldZoomToPins {
            zoomToAnnotations()
        }
    }

    private func removePinsMissingIn(_ newAnnotations: [MKAnnotation]) {
        mapView.annotations.forEach { annotation in
            if !newAnnotations.contains(where: { $0.matches(annotation) }) {
                mapView.removeAnnotation(annotation)
            }
        }
    }

    private func addPin(for annotation: AppleMapAnnotation) {
        if let existingAnnotation = mapView.annotations.first(where: { $0.matches(annotation) }) {
            update(annotation.pin.image, for: existingAnnotation)
        } else {
            mapView.addAnnotation(annotation)
        }
    }

    private func update(_ image: UIImage, for annotation: MKAnnotation) {
        guard let view = mapView.view(for: annotation) else {
            return
        }

        view.image = image
    }

    private func zoomToAnnotations() {
        guard !mapView.annotations.isEmpty else {
            return
        }

        mapView.setVisibleMapRect(annotationRectWithInsets, animated: true)
    }

    private var annotationRectWithInsets: MKMapRect {
        let horizontalInsetMultiplier = 0.1
        let verticalInsetMultiplier = 0.2
        let rect = annotationMapRect

        return rect.insetBy(
            dx: -rect.size.width * horizontalInsetMultiplier,
            dy: -rect.size.height * verticalInsetMultiplier
        )
    }

    private var annotationMapRect: MKMapRect {
        mapView.annotations.reduce(MKMapRect.null) { rect, annotation in
            annotation.isExcludedFromZooming ? rect : rect.union(makeRect(from: annotation))
        }
    }

    private func makeRect(from annotation: MKAnnotation) -> MKMapRect {
        let pointSize = 0.1
        let point = MKMapPoint(annotation.coordinate)

        return MKMapRect(
            x: point.x,
            y: point.y,
            width: pointSize,
            height: pointSize
        )
    }
}

extension AppleMapView: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        tappedAnnotations(for: touch).isEmpty
    }

    private func tappedAnnotations(for touch: UITouch) -> [MKAnnotationView] {
        mapView.annotations.compactMap {
            guard let view = mapView.view(for: $0), view.bounds.contains(touch.location(in: view)) else {
                return nil
            }
            return view
        }
    }
}

extension AppleMapView: MKMapViewDelegate {

    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        let centerCoordinate = Map.Coordinate(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)

        let viewPort = Map.ViewPort(centerCoordinate: centerCoordinate)

        onViewPortChangeHandler?(viewPort)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? AppleMapAnnotation else {
            return nil
        }

        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotation.reuseIdentifier) as? AppleMapAnnotationView {
            annotationView.configure(with: annotation)
            return annotationView
        } else {
            return AppleMapAnnotationView(annotation: annotation)
        }
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? AppleMapAnnotation else {
            return
        }

        onSelect?(annotation.pin)
    }
}

private extension Map.Region {

    var mkCoordinateRegion: MKCoordinateRegion {
        .init(
            center: center.clLocationCoordinate2D,
            latitudinalMeters: size.latitudalMeters,
            longitudinalMeters: size.longitudalMeters
        )
    }
}

private extension Map.Coordinate {

    var clLocationCoordinate2D: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
    }
}

private extension MKAnnotation {

    var isExcludedFromZooming: Bool {
        guard let annotation = self as? AppleMapAnnotation else {
            return true
        }

        return annotation.pin.isExcludedFromZoomingToPins
    }

    func matches(_ annotation: MKAnnotation) -> Bool {
        guard let firstAnnotation = self as? AppleMapAnnotation,
              let secondAnnotation = annotation as? AppleMapAnnotation
        else {
            return false
        }

        return firstAnnotation.pin == secondAnnotation.pin
    }
}
