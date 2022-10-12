import UIKit

final class MapPickerView: UIView {
    
    var onPickupPointSelect: ((_ pickupPointCode: String) -> Void)?
    var onPickupPointConfirm: (() -> Void)?
    var onUnselectPickupPoint: (() -> Void)?
    
    private let state: MapPicker.View
    
    private var mapView: MapView = {
        MapView()
    }()
    
    private var carrierNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var pickupPointNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var button: ConfirmationButton = {
        let button = ConfirmationButton()
        button.setTitle("Select", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private var contentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private var pickupPointDetailsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = ThemeManager.currentTheme.radius.medium
        view.isHidden = true
        view.layer.borderWidth = 1
        view.layer.borderColor = ThemeManager.currentTheme.colors.gray.cgColor
        
        return view
    }()
    
    init(with state: MapPicker.View) {
        self.state = state
        super.init(frame: .zero)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        let padding: CGFloat = 24
        
        embed(view: mapView, inContainerView: self)
        
        contentStack.addArrangedSubview(carrierNameLabel)
        contentStack.addArrangedSubview(pickupPointNameLabel)
        contentStack.addArrangedSubview(addressLabel)
        contentStack.addArrangedSubview(button)
        
        addSubview(pickupPointDetailsView)
        NSLayoutConstraint.activate([
            pickupPointDetailsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            pickupPointDetailsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            pickupPointDetailsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
        ])
        
        embed(view: contentStack,
              inContainerView: pickupPointDetailsView,
              margins: .init(top: padding, left: padding, bottom: padding, right: padding)
        )
        
        button.addTarget(self, action: #selector(handleConfirmTap), for: .touchUpInside)
    }
    
    func updateSelectedPickupPointDetails(with state: MapPicker.View) {
        guard let details = state.details else {
            pickupPointDetailsView.isHidden = true
            
            return
        }
        
        pickupPointDetailsView.isHidden = false
        carrierNameLabel.text = details.carrierName
        pickupPointNameLabel.text = details.pickupPointName
        addressLabel.text = details.address
    }
    
    func updateMap(with state: MapPicker.View, shouldZoomToPins: Bool) {
        let markers = Map.Markers(
            pins: state.pickupPoints.map {
                .init(
                    image: ImageProvider.image(named: $0.isSelected ? "selected_pin" : "pin"),
                    coordinate: .init(latitude: $0.latitude, longitude: $0.longitude),
                    code: $0.code,
                    isExcludedFromZoomingToPins: false,
                    isSelected: false
                )
            },
            shouldZoomToPins: shouldZoomToPins
        )
        
        let map = Map(
            onTap: { [weak self] in
                self?.onUnselectPickupPoint?()
            },
            onPinSelect: { [weak self] pin in
                self?.onPickupPointSelect?(pin.code)
            },
            markers: markers
        )
        mapView.setup(map)
    }
    
    @objc
    private func handleConfirmTap() {
        onPickupPointConfirm?()
    }
}
