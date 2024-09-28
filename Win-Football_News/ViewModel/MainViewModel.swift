import Foundation

class MainViewModel {
    
    weak var delegate: ViewController?
    
    private var matchesManager: MatchesManager?
    private var apiCaller = APICaller.shared
    
    init() {
        apiCaller.fetchAllMatches { [weak self] matchesArray in
            guard let self = self else { return }
            self.matchesManager = MatchesManager(matches: matchesArray)
            self.matchesLoaded()
        }
    }
    
    private func matchesLoaded() {
        delegate?.matchesLoaded()
    }
    
    public func getNextTwentyMatches(sortedBy sortOrder: MatchSortOrder) -> [Match] {
        return matchesManager?.loadMoreMatches(sortedBy: sortOrder) ?? []
    }
    
    public func getNextTwentyMatches(with leagueId: LeagueIds) -> [Match] {
        return matchesManager?.loadMoreMatchesFrom(leagueId: leagueId.rawValue) ?? []
    }
}
