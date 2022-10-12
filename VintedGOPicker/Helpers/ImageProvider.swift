import UIKit

public class ImageProvider {
    
    public static func image(named: String) -> UIImage {
        return UIImage(named: named, in: Bundle(for: self), with: nil) ?? UIImage()
    }
}
