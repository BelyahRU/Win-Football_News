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
    
    func extractTime(from dateTimeString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = inputFormatter.date(from: dateTimeString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "HH:mm"
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
    

    func formatDate(_ dateTimeString: String) -> String? {
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            inputFormatter.locale = Locale(identifier: "en_US_POSIX")
            
            guard let date = inputFormatter.date(from: dateTimeString) else { return nil }
            
            let outputFormatter = DateFormatter()
            outputFormatter.locale = Locale(identifier: "en_US")
            outputFormatter.dateFormat = "d MMM yyyy, EEE"
            
            return outputFormatter.string(from: date)
    }

}
