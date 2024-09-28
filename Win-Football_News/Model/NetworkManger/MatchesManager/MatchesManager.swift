
import Foundation

enum MatchSortOrder {
    case ascending
    case descending
}

final class MatchesManager {
    private(set) var allMatches: [Match] = []
    private let pageSize = 20
    private var currentPage = 0
    private var currentSortOrder: MatchSortOrder = .ascending
    private var leagueCounter = false
    private var currentLeague = "BL1"

    init(matches: [Match]) {
        self.allMatches = matches.sorted { $0.utcDate < $1.utcDate }
    }

    func loadMoreMatches(sortedBy order: MatchSortOrder) -> [Match] {
        if currentSortOrder != order {
            currentPage = 0
            currentSortOrder = order
        }
        leagueCounter = false

        let startIndex: Int
        let endIndex: Int

        switch order {
        case .ascending:
            startIndex = currentPage * pageSize
            endIndex = min((currentPage + 1) * pageSize, allMatches.count)
            currentPage += 1
            return Array(allMatches[startIndex..<endIndex])
        case .descending:
            startIndex = max(0, allMatches.count - (currentPage + 1) * pageSize)
            endIndex = allMatches.count - currentPage * pageSize
            currentPage += 1
            return Array(allMatches[startIndex..<endIndex])
        }
    }
    
    func loadMoreMatchesFrom(leagueId: String) -> [Match] {
        if leagueCounter == false || currentLeague != leagueId {
            currentPage = 0
            leagueCounter = true
            currentLeague = leagueId
        }
        
        
        let filteredMatches = allMatches.filter { $0.leagueId == leagueId }
        
        let startIndex = currentPage * pageSize
        let endIndex = min(startIndex + pageSize, filteredMatches.count)

        guard startIndex < endIndex else {
            print("No more matches to load for league \(leagueId)")
            return []
        }

        currentPage += 1
        let matchesToLoad = Array(filteredMatches[startIndex..<endIndex])
        return matchesToLoad
    }

    func resetCurrentPage() {
        currentPage = 0
    }
}
