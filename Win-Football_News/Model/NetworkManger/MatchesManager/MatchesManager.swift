
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
    private var currentLeague = ""

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
            return Array(allMatches[startIndex..<endIndex]).reversed()
        }
    }
    
    func loadMoreMatchesFrom(leagueId: String, sortedBy order: MatchSortOrder) -> [Match] {
        if leagueCounter == false || currentLeague != leagueId || currentSortOrder != order  {
            currentPage = 0
            leagueCounter = true
            currentLeague = leagueId
            currentSortOrder = order
        }
        
        
        let filteredMatches = allMatches.filter { $0.leagueId == leagueId }
        let startIndex: Int
        let endIndex: Int
        switch order {
        case .ascending:
            startIndex = currentPage * pageSize
            endIndex = min(startIndex + pageSize, filteredMatches.count)
            currentPage += 1
            return Array(allMatches[startIndex..<endIndex])
        case .descending:
            startIndex = max(0, allMatches.count - (currentPage + 1) * pageSize)
            endIndex = allMatches.count - currentPage * pageSize
            currentPage += 1
            return Array(allMatches[startIndex..<endIndex]).reversed()
        }
    }

    func resetCurrentPage() {
        currentPage = 0
    }
}
