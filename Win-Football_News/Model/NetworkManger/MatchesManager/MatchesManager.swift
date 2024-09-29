
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
    private var currentLeague: String?

    init(matches: [Match]) {
        self.allMatches = matches.sorted { $0.utcDate < $1.utcDate }
    }

    func loadMoreMatches(sortedBy order: MatchSortOrder, completion: @escaping ([Match]) -> Void) {
        updatePaginationSettings(for: nil, sortedBy: order)
        loadPaginatedMatches(from: allMatches, sortedBy: order, completion: completion)
    }

    func loadMoreMatchesFrom(leagueId: String, sortedBy order: MatchSortOrder, completion: @escaping ([Match]) -> Void) {
        updatePaginationSettings(for: leagueId, sortedBy: order)
        let filteredMatches = allMatches.filter { $0.leagueId == leagueId }
        loadPaginatedMatches(from: filteredMatches, sortedBy: order, completion: completion)
    }


    func resetCurrentPage() {
        currentPage = 0
    }

    private func updatePaginationSettings(for leagueId: String?, sortedBy order: MatchSortOrder) {
        if currentSortOrder != order || currentLeague != leagueId {
            currentPage = 0
            currentSortOrder = order
            currentLeague = leagueId
        }
    }

    private func loadPaginatedMatches(from matches: [Match], sortedBy order: MatchSortOrder, completion: @escaping ([Match]) -> Void) {
        let startIndex: Int
        let endIndex: Int

        switch order {
        case .ascending:
            startIndex = currentPage * pageSize
            endIndex = min(startIndex + pageSize, matches.count)
        case .descending:
            startIndex = max(0, matches.count - (currentPage + 1) * pageSize)
            endIndex = matches.count - currentPage * pageSize
        }

        currentPage += 1
        let paginatedMatches = Array(matches[startIndex..<endIndex])
        
        loadLogosSequentially(matches: paginatedMatches, index: 0) { updatedMatches in
            completion(order == .ascending ? updatedMatches : updatedMatches.reversed())
        }
    }

    private func loadLogosSequentially(matches: [Match], index: Int, completion: @escaping ([Match]) -> Void) {
        var matches = matches
        guard index < matches.count else {
            completion(matches)
            return
        }

        let match = matches[index]
        let group = DispatchGroup()
        
        group.enter()
        LogoFetcher.shared.fetchLogo(for: match.homeTeam.id ?? 0) { data in
            if let data = data {
                if let index = matches.firstIndex(where: { $0.id == match.id }) {
                    matches[index].homeTeamLogo = data
                }
            }
            group.leave()
        }

        group.enter()
        LogoFetcher.shared.fetchLogo(for: match.awayTeam.id ?? 0) { data in
            if let data = data {
                if let index = matches.firstIndex(where: { $0.id == match.id }) {
                    matches[index].guestTeamLogo = data
                }
            }
            group.leave()
        }

        group.notify(queue: .main) { [weak self] in
            self?.loadLogosSequentially(matches: matches, index: index + 1, completion: completion)
        }
    }



}

