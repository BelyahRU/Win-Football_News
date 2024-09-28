import Foundation
enum LeagueIds: String, CaseIterable {
    case premierLeague = "PL"
    case serieA = "SA"
    case bundesliga = "BL1"
    case laLiga = "PD"
    case championsLeague = "CL"
}

class MainViewModel {
    
    weak var delegate: MainViewController?
    
    private var matchesManager: MatchesManager?
    private var apiCaller = APICaller.shared
    
    private(set) var matches: [Match] = []
    
    init() {
        apiCaller.fetchAllMatches { [weak self] matchesArray in
            guard let self = self else { return }
            self.matchesManager = MatchesManager(matches: matchesArray)
            self.matchesLoaded()
            self.getNextTwentyMatches(sortedBy: .ascending)
        }
    }
    
    private func matchesLoaded() {
        delegate?.matchesLoaded()
    }
    
    public func getNextTwentyMatches(sortedBy sortOrder: MatchSortOrder){
        matches = matchesManager?.loadMoreMatches(sortedBy: sortOrder) ?? []
    }
    
    public func getNextTwentyMatchesWith(leagueId: LeagueIds, sortedBy sortOrder: MatchSortOrder){
        matches = matchesManager?.loadMoreMatchesFrom(leagueId: leagueId.rawValue, sortedBy: sortOrder) ?? []
    }
    
    public func getMatch(by index: Int) -> Match {
        return matches[index]
    }
}
