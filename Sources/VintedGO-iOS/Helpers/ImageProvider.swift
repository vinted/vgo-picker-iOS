import UIKit

public class ImageProvider {
    
    public static func image(named: String) -> UIImage {
        UIImage(named: named, in: .module, compatibleWith: nil)!
    }
}
