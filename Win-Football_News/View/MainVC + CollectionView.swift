
import Foundation
import UIKit

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func setupColletionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        collectionView.register(MatchColletionViewCell.self, forCellWithReuseIdentifier: MatchColletionViewCell.reuseId)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let match = viewModel.getMatch(by: indexPath.row) else {
            print("Match not found")
            return
        }
        
        // Инициализация `DetailsViewController`
        let detailsVC = DetailsViewController()
        detailsVC.match = match  // Передаем данные о матче в контроллер
        
        // Переход на экран деталей
        navigationController?.pushViewController(detailsVC, animated: true)
    
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.matches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = Int(self.view.bounds.width)
        
        let itemWidth = CGFloat(screenWidth - 34)
        
        let itemHeight = CGFloat(125)
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MatchColletionViewCell.reuseId, for: indexPath) as? MatchColletionViewCell else {
            print("dequeReusableCellError")
            return UICollectionViewCell()
        }
        guard let match = viewModel.getMatch(by: indexPath.row) else { 
            print("matchError")
            return MatchColletionViewCell() }
        let date = viewModel.formatDate(match.utcDate) ?? "dateError"
        let time = viewModel.extractTime(from: match.utcDate) ?? "timeError"
        let logo1Data = match.homeTeamLogo
        let logo2Data = match.guestTeamLogo
        cell.setupText(league: match.leagueId ?? "", time: time,date: date, team1: match.homeTeam.name ?? "", team2: match.awayTeam.name ?? "", logo1Data: logo1Data, logo2Data: logo2Data)
        return cell

    }
    
    // Добавляем футер в CollectionView
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            if kind == UICollectionView.elementKindSectionFooter {
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath)
                footer.addSubview(footerView)
                footerView.frame = footer.bounds
                footerView.isHidden = !showMoreButtonVisible
                return footer
            }
            return UICollectionReusableView()
        }
        
        // Устанавливаем размер ячейки и футера
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
            return showMoreButtonVisible ? CGSize(width: view.frame.width, height: 60) : .zero
        }
        
        // MARK: - UICollectionViewDelegate Methods
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            // Показываем кнопку, если пользователь дошел до конца списка
            let isNearBottom = scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height - 50
            if isNearBottom {
                showMoreButtonVisible = true
                collectionView.reloadSections(IndexSet(integer: 0))
            }
        }
        
        // MARK: - Actions
        
    @objc func loadMoreCells() {
        guard currentTournament != "" else {
            switch currentSort {
            case 1:
                startLoadingAnimation()
                viewModel.getNextTwentyMatches(sortedBy: .descending) {
                    self.collectionView.reloadData()
                    self.collectionView.layoutIfNeeded() // Убедитесь, что обновление завершено
                    self.stopLoadingAnimation()
                }
            default:
                startLoadingAnimation()
                viewModel.getNextTwentyMatches(sortedBy: .ascending) {
                    self.collectionView.reloadData()
                    self.collectionView.layoutIfNeeded()

                    self.stopLoadingAnimation()
                }
            }
            return
        }
        
        // Выполнение для текущего турнира
        startLoadingAnimation()
        
        switch currentSort {
        case 1:
            viewModel.getNextTwentyMatchesWith(leagueId: currentTournament, sortedBy: .descending) {
                self.collectionView.reloadData()
                self.collectionView.layoutIfNeeded()
                self.stopLoadingAnimation()
            }
        default:
            viewModel.getNextTwentyMatchesWith(leagueId: currentTournament, sortedBy: .ascending) {
                self.collectionView.reloadData()
                self.collectionView.layoutIfNeeded()
                self.stopLoadingAnimation()
            }
        }
    }

}
