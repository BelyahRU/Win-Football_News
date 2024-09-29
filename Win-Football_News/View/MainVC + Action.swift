
import Foundation
import UIKit

extension MainViewController {
    
    func setupButtons() {
        mainView.sortButton.addTarget(self, action: #selector(sortPressed), for: .touchUpInside)
        mainView.filtersButton.addTarget(self, action: #selector(filterPressed), for: .touchUpInside)
        mainView.reloadButton.addTarget(self, action: #selector(reloadPressed), for: .touchUpInside)
    }
    
    @objc
    func filterPressed() {
        print("adsf")
    }
    
    @objc
    func sortPressed() {
        print("adsf")
    }
    
    @objc
    func reloadPressed() {
        startLoadingAnimation()
        setupViewModel()
        print("adsf")
    }
}
