
import Foundation
import UIKit

extension MainViewController {
    
    func setupButtons() {
        mainView.sortButton.addTarget(self, action: #selector(sortPressed), for: .touchUpInside)
        mainView.filterButton.addTarget(self, action: #selector(filterPressed), for: .touchUpInside)
    }
    
    @objc
    func filterPressed() {
        
    }
    
    @objc
    func sortPressed() {
        
    }
}
