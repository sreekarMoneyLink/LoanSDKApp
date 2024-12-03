
import UIKit

public class ResourceManager {
    private static let bundle: Bundle = {
        // Get the bundle for the SDK class
        return Bundle(for: MyAppSDKManager.self)
    }()

    public static func image(named name: String) -> UIImage? {
        return UIImage(named: name, in: bundle, compatibleWith: nil)
    }
}
