import UIKit

protocol Colors {

    var primary: UIColor { get }
    var white: UIColor { get }
    var gray: UIColor { get }
}

protocol Radius {

    var small: CGFloat { get }
    var medium: CGFloat { get }
}

protocol Theme {

    var colors: Colors { get }
    var radius: Radius { get }
}
