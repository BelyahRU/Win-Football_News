
import Foundation

class MainViewModel {
    
    private var matchesManager: MatchesManager
    private var apiCaller = APICaller.shared
    
    private init() {
        apiCaller.fetchAllMatches { matchesArray in
            //delegate
            self.matchesManager = MatchesManager(matches: matchesArray)
            self.matchesLoaded()
        }
    }
    
    private func matchesLoaded() {
        
    }
    
    public func getNextTwentyMatches(sortedBy sortOrder: MatchSortOrder) -> [Match] {
        return matchesManager.loadMoreMatches(sortedBy: sortOrder)
    }
}
