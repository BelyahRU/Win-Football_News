
import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    public let detailsView = DetailsView()
    public let viewModel = DetailsViewModel()
    public var match: Match!
    public var currentTeam = "home"
    public var isInitial = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        setupButtons()
        setupData()
    }
    
    private func setupUI() {
        isInitial = false
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
        
        detailsView.setupTeamsView(team1Name: match.homeTeam.name ?? "", firstImage: match.homeTeamLogo ?? Data(), team2Name: match.awayTeam.name ?? "", secondImage: match.guestTeamLogo ?? Data())
        
        loadData()
    }
    
    func loadData() {
        if currentTeam == "home" {
            TeamResultsFetcher.shared.fetchLastFiveResults(for: match.homeTeam.id ?? 0) { fiveString, lastString, errorMessage in
                if let errorMessage = errorMessage {
                    DispatchQueue.main.async {
                        let errorVC = ErrorViewController()
                        errorVC.configure(with: errorMessage)
                        self.navigationController?.pushViewController(errorVC, animated: true)
                    }
                    return
                }
                guard let fiveString = fiveString, let lastString = lastString else {
                    return
                }
                DispatchQueue.main.async {
                    self.detailsView.recentResultView.setupUI(fiveMatches: fiveString, lastResult: lastString)
                    if self.isInitial {
                        self.setupUI()
                    }
                    self.view.layoutIfNeeded()
                }
            }
        } else {
            TeamResultsFetcher.shared.fetchLastFiveResults(for: match.awayTeam.id ?? 0) { fiveString, lastString, errorMessage in
                if let errorMessage = errorMessage {
                    DispatchQueue.main.async {
                        let errorVC = ErrorViewController()
                        errorVC.configure(with: errorMessage)
                        self.present(errorVC, animated: true, completion: nil)
                    }
                    return
                }
                guard let fiveString = fiveString, let lastString = lastString else {
                    return
                }
                print(fiveString, lastString)
                DispatchQueue.main.async {
                    self.detailsView.recentResultView.setupUI(fiveMatches: fiveString, lastResult: lastString)
                    if self.isInitial {
                        self.setupUI()
                    }
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
}
