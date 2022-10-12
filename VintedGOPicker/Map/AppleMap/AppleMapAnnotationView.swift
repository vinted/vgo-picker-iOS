import MapKit

final class AppleMapAnnotationView: MKAnnotationView {
    
    init(annotation: AppleMapAnnotation) {
        super.init(annotation: annotation, reuseIdentifier: annotation.reuseIdentifier)

        setAnchorPoint()
        configure(with: annotation)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with annotation: AppleMapAnnotation) {
        image = annotation.pin.image

        configureDepth(when: annotation.pin.isSelected)
    }
    
    private func configureDepth(when isSelected: Bool) {
        if #available(iOS 14.0, *) {
            zPriority = isSelected ? .max : .min
        } else {
            if isSelected {
                layer.zPosition = 1
            } else {
                layer.zPosition = 0
            }
        }
    }

    private func setAnchorPoint() {
        let bottomMiddlePoint = CGPoint(x: 0.5, y: 1.0)
        layer.anchorPoint = bottomMiddlePoint
    }
}
