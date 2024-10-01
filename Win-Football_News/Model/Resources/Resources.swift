
import Foundation
import UIKit

enum Resources {
    
    enum Colors {
        static let mainBackgroundColor = UIColor(red: 0x17 / 255.0, green: 0x18 / 255.0, blue: 0x27 / 255.0, alpha: 1.0)

        static let darkBlueColor = UIColor(red: 0x15 / 255.0, green: 0x22 / 255.0, blue: 0xD9 / 255.0, alpha: 1.0)

        static let blueColor = UIColor(red: 0x24 / 255.0, green: 0xAD / 255.0, blue: 0xF3 / 255.0, alpha: 1.0)

        static let redColor = UIColor(red: 0xD9 / 255.0, green: 0x1D / 255.0, blue: 0x00 / 255.0, alpha: 1.0)

        static let yellowColor = UIColor(red: 0xF3 / 255.0, green: 0xBF / 255.0, blue: 0x18 / 255.0, alpha: 1.0)

        static let greenColor = UIColor(red: 0x37 / 255.0, green: 0xDE / 255.0, blue: 0x5D / 255.0, alpha: 1.0)
    }
    
    enum Images {
        static let logoImage = "logoImage"
        static let selectedImage = "selectedImage"
        
        enum Buttons {
            static let filtersButton = "filtersButton"
            static let sortButton = "sortButton"
            static let reloadButton = "reloadButton"
            static let closeButton = "closeButton"
            static let backButton = "backButton"
        }
        
        enum MatchResultImage {
            static let greenCircle = "greenCircle"
            static let redCircle = "redCircle"
            static let yellowCircle = "yellowCircle"
        }
    }
}
