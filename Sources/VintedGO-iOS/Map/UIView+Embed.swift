import UIKit

@discardableResult
public func embed(view viewToEmbed: UIView, inContainerView containerView: UIView, margins: UIEdgeInsets = UIEdgeInsets.zero) -> [NSLayoutConstraint] {
    viewToEmbed.translatesAutoresizingMaskIntoConstraints = false
    containerView.addSubview(viewToEmbed)
    
    let topContraint = NSLayoutConstraint(
        item: viewToEmbed,
        attribute: .top,
        relatedBy: .equal,
        toItem: containerView,
        attribute: .top,
        multiplier: 1.0,
        constant: margins.top
    )
    
    let bottomConstraint = NSLayoutConstraint(
        item: containerView,
        attribute: .bottom,
        relatedBy: .equal,
        toItem: viewToEmbed,
        attribute: .bottom,
        multiplier: 1.0,
        constant: margins.bottom
    )
    let leftConstraint = NSLayoutConstraint(
        item: viewToEmbed,
        attribute: .leading,
        relatedBy: .equal,
        toItem: containerView,
        attribute: .leading,
        multiplier: 1.0,
        constant: margins.left
    )
    let rightConstraint = NSLayoutConstraint(
        item: containerView,
        attribute: .trailing,
        relatedBy: .equal,
        toItem: viewToEmbed,
        attribute: .trailing,
        multiplier: 1.0,
        constant: margins.right
    )
    
    containerView.addConstraints([topContraint, rightConstraint, bottomConstraint, leftConstraint])
    return [topContraint, rightConstraint, bottomConstraint, leftConstraint]
}
