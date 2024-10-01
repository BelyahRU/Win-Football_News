
import Foundation
import UIKit

extension DetailsViewController {
    
    func setupButtons() {
        detailsView.backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
    }
    
    @objc
    func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}
