
import Foundation
import UIKit

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func setupColletionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MatchColletionViewCell.self, forCellWithReuseIdentifier: MatchColletionViewCell.reuseId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = Int(self.view.bounds.width)
        
        let itemWidth = CGFloat(screenWidth - 40)
        
        let itemHeight = CGFloat(125)
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MatchColletionViewCell.reuseId, for: indexPath) as? MatchColletionViewCell else {
            return UICollectionViewCell()
        }
        let match = viewModel.getMatch(by: indexPath.row)
        let date = viewModel.formatDate(match.utcDate) ?? "dateError"
        let time = viewModel.extractTime(from: match.utcDate) ?? "timeError"
        
        cell.setupText(league: match.leagueId ?? "", time: time,date: date, team1: match.homeTeam.name ?? "", team2: match.awayTeam.name ?? "")
        return cell

    }
}
