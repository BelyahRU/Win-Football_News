
import Foundation

extension MainViewController {
    func setupFilter() {
        view.addSubview(filterView)
        filterView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(492)
        }
    }
    
    func cancelFilter() {
        self.filterView.removeFromSuperview()
        self.view.layoutIfNeeded()
        filterShowed = false
    }
    
    @objc
    func cancelFilterPressed() {
        cancelFilter()
        filterShowed = false
    }
    
    @objc
    func premierPressed() {
        if filterView.plSelectedImageView.isHidden {
            filterView.plSelectedImageView.isHidden = false
            filterView.sASelectedImageView.isHidden = true
            filterView.bundSelectedImageView.isHidden = true
            filterView.laLigaSelectedImageView.isHidden = true
            filterView.uclSelectedImageView.isHidden = true
            currentTournament = "Premier League"
        } else {
            filterView.plSelectedImageView.isHidden = true
            currentTournament = ""
        }
    }
    
    @objc
    func seriaAPressed() {
        if filterView.sASelectedImageView.isHidden {
            filterView.plSelectedImageView.isHidden = true
            filterView.sASelectedImageView.isHidden = false
            filterView.bundSelectedImageView.isHidden = true
            filterView.laLigaSelectedImageView.isHidden = true
            filterView.uclSelectedImageView.isHidden = true
            currentTournament = "Seria A"
        } else {
            filterView.sASelectedImageView.isHidden = true
            currentTournament = ""
        }
    }
    
    @objc
    func bundesPressed() {
        if filterView.bundSelectedImageView.isHidden {
            filterView.plSelectedImageView.isHidden = true
            filterView.sASelectedImageView.isHidden = true
            filterView.bundSelectedImageView.isHidden = false
            filterView.laLigaSelectedImageView.isHidden = true
            filterView.uclSelectedImageView.isHidden = true
            currentTournament = "Bundesliga"
        } else {
            filterView.bundSelectedImageView.isHidden = true
            currentTournament = ""
        }
    }
    
    @objc
    func laLigaPressed() {
        if filterView.laLigaSelectedImageView.isHidden {
            filterView.plSelectedImageView.isHidden = true
            filterView.sASelectedImageView.isHidden = true
            filterView.bundSelectedImageView.isHidden = true
            filterView.laLigaSelectedImageView.isHidden = false
            filterView.uclSelectedImageView.isHidden = true
            currentTournament = "LaLiga"
        } else {
            filterView.laLigaSelectedImageView.isHidden = true
            currentTournament = ""
        }
    }
    
    @objc
    func uclPressed() {
        if filterView.uclSelectedImageView.isHidden {
            filterView.plSelectedImageView.isHidden = true
            filterView.sASelectedImageView.isHidden = true
            filterView.bundSelectedImageView.isHidden = true
            filterView.laLigaSelectedImageView.isHidden = true
            filterView.uclSelectedImageView.isHidden = false
            currentTournament = "Champions League"
        } else {
            filterView.uclSelectedImageView.isHidden = true
            currentTournament = ""
        }

    }
//    if currentSort == 1 {
//        startLoadingAnimation()
//        self.collectionView.isHidden = true
//        viewModel.getNextTwentyMatches(sortedBy: .ascending) {
//            self.collectionView.reloadData()
//            self.collectionView.isHidden = false
//            self.stopLoadingAnimation()
//        }
//        currentSort = 0
//    }
//    cancelSort()
    @objc
    func applyPressed() {
        if currentTournament != "" {
            startLoadingAnimation()
            self.collectionView.isHidden = true
            switch currentSort {
            case 1:
                viewModel.getNextTwentyMatchesWith(leagueId: currentTournament, sortedBy: .descending) {
                    self.collectionView.reloadData()
                    self.collectionView.isHidden = false
                    self.stopLoadingAnimation()
                    
                }
            default:
                viewModel.getNextTwentyMatchesWith(leagueId: currentTournament, sortedBy: .ascending) {
                    self.collectionView.reloadData()
                    self.collectionView.isHidden = false
                    self.stopLoadingAnimation()
                }
            }
        }
        cancelFilter()
    }
}
