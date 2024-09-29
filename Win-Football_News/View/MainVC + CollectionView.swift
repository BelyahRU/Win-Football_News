
import Foundation
import UIKit

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func setupColletionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MatchColletionViewCell.self, forCellWithReuseIdentifier: MatchColletionViewCell.reuseId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = Int(self.view.bounds.width)
        
        let itemWidth = CGFloat(screenWidth - 34)
        
        let itemHeight = CGFloat(125)
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MatchColletionViewCell.reuseId, for: indexPath) as? MatchColletionViewCell else {
            return UICollectionViewCell()
        }
        guard let match = viewModel.getMatch(by: indexPath.row) else { return MatchColletionViewCell() }
        let date = viewModel.formatDate(match.utcDate) ?? "dateError"
        let time = viewModel.extractTime(from: match.utcDate) ?? "timeError"
        let logo1Data = match.homeTeamLogo
        let logo2Data = match.guestTeamLogo
        cell.setupText(league: match.leagueId ?? "", time: time,date: date, team1: match.homeTeam.name ?? "", team2: match.awayTeam.name ?? "", logo1Data: logo1Data, logo2Data: logo2Data)
        return cell

    }
}
