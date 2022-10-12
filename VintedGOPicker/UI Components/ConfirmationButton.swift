import UIKit

final class ConfirmationButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }

    private func setup() {
        clipsToBounds = true
        layer.cornerRadius = ThemeManager.currentTheme.radius.small

        backgroundColor = ThemeManager.currentTheme.colors.primary
        setTitleColor(ThemeManager.currentTheme.colors.white, for: .normal)
        contentEdgeInsets = UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16)
    }
}
