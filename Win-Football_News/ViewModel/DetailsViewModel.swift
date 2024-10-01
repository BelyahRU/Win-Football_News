
import Foundation
import UIKit

class DetailsViewModel {
    
    func extractTime(from dateTimeString: String) -> String? {
        DateHelper.shared.extractTime(from: dateTimeString)
    }
    

    func formatDate(_ dateTimeString: String) -> String? {
        DateHelper.shared.formatDate(dateTimeString)
    }
}
