import UIKit

struct DefaultColors: Colors {
    
    var primary: UIColor { color(red: 3, green: 119, blue: 130) }
    var white: UIColor { color(red: 255, green: 255, blue: 255) }
    var gray: UIColor { color(red: 102, green: 102, blue: 102) }
    
    private func color(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
}

struct DefaultRadius: Radius {
    
    var small: CGFloat { 8 }
    var medium: CGFloat { 16 }
}

struct DefaultTheme: Theme {
    
    var colors: Colors { DefaultColors() }
    var radius: Radius { DefaultRadius() }
}
