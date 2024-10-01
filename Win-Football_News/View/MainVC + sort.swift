
import Foundation
import UIKit

extension MainViewController {
    func setupSort() {
        view.addSubview(sortView)
        
        sortView.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.width.centerX.equalToSuperview()
            make.height.equalTo(189)
        }
    }

    func cancelSort() {
        self.sortView.removeFromSuperview()
        self.view.layoutIfNeeded()
    }
    
    @objc
    func cancelSortPressed() {
        cancelSort()
        sortShowed = false
    }
    
    @objc
    func sortByEarlier() {
    
        if currentSort == 1 {
            startLoadingAnimation()
            self.collectionView.isHidden = true
            if currentTournament != "" {
                viewModel.getNextTwentyMatchesWith(leagueId: currentTournament, sortedBy: .ascending) {
                    self.collectionView.reloadData()
                    self.collectionView.isHidden = false
                    self.stopLoadingAnimation()
                    
                    let firstIndexPath = IndexPath(item: 0, section: 0)
                    self.collectionView.scrollToItem(at: firstIndexPath, at: .top, animated: true)
                }
            } else {
                viewModel.getNextTwentyMatches(sortedBy: .ascending) {
                    self.collectionView.reloadData()
                    self.collectionView.isHidden = false
                    self.stopLoadingAnimation()
                    
                    let firstIndexPath = IndexPath(item: 0, section: 0)
                    self.collectionView.scrollToItem(at: firstIndexPath, at: .top, animated: true)

                }
            }
            currentSort = 0
        }
        cancelSort()
    }
    
    @objc
    func sortByLater() {
        if currentSort == 0 {
            startLoadingAnimation()
            self.collectionView.isHidden = true
            if currentTournament != "" {
                viewModel.getNextTwentyMatchesWith(leagueId: currentTournament, sortedBy: .descending) {
                    self.collectionView.reloadData()
                    self.collectionView.isHidden = false
                    self.stopLoadingAnimation()
                    
                    let firstIndexPath = IndexPath(item: 0, section: 0)
                    self.collectionView.scrollToItem(at: firstIndexPath, at: .top, animated: true)
                }
            } else {
                viewModel.getNextTwentyMatches(sortedBy: .descending) {
                    self.collectionView.reloadData()
                    self.collectionView.isHidden = false
                    self.stopLoadingAnimation()
                    
                    let firstIndexPath = IndexPath(item: 0, section: 0)
                    self.collectionView.scrollToItem(at: firstIndexPath, at: .top, animated: true)

                }
            }
            currentSort = 1
        }
        cancelSort()
    }
}
