
import Foundation
import UIKit

extension DetailsViewController {
    
    func setupButtons() {
        detailsView.backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        detailsView.teamsSelectionView.homeTeamButton.addTarget(self, action: #selector(homeTeamPressed), for: .touchUpInside)
        detailsView.teamsSelectionView.awayTeamButton.addTarget(self, action: #selector(guestTeamPressed), for: .touchUpInside)
    }
    
    @objc
    func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func homeTeamPressed() {
        currentTeam = "home"
        detailsView.teamsSelectionView.styleButtons(isHomeSelected: true)
        loadData()
    }
    
    @objc
    func guestTeamPressed() {
        currentTeam = "guest"
        detailsView.teamsSelectionView.styleButtons(isHomeSelected: false)
        loadData()
    }
}
