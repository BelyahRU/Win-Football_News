
import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    public let detailsView = DetailsView()
    public let viewModel = DetailsViewModel()
    public var match: Match!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        setupUI()
        setupButtons()
        setupData()
    }
    
    private func setupUI() {
        view.addSubview(detailsView)
        
        detailsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupData() {
        guard let match = match else {
            return
        }
        detailsView.leagueNameLabel.text = match.leagueId ?? ""
        detailsView.timeLabel.text = viewModel.extractTime(from: match.utcDate)
        detailsView.team1Label.text = match.homeTeam.name
        detailsView.team2Label.text = match.awayTeam.name
        detailsView.dateLabel.text = viewModel.formatDate(match.utcDate)
        
        DetailsCaller.shared.fetchMatchDetails(matchID: match.id) { venue, location in
            if let venue = venue, let location = location {
                print("Стадион: \(venue), Местоположение: \(location)")
            } else {
                print("Информация о стадионе не найдена.")
            }
        }
    }
}
