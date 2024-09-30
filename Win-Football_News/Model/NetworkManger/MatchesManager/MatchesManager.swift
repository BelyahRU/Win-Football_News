import Foundation

enum MatchSortOrder {
    case ascending
    case descending
}

enum MatchesManagerError: Error {
    case networkError(Error)
    case emptyMatchesData
    case invalidTeamId
    case logoFetchError(teamId: Int)
}

final class MatchesManager {
    private(set) var allMatches: [Match] = []
    private let pageSize = 20
    private var currentPage = 0
    private var currentSortOrder: MatchSortOrder = .ascending
    private var currentLeague: String?

    init(completion: @escaping (Result<Void, MatchesManagerError>) -> Void) {
        // Загружаем данные при инициализации
        self.loadInitialMatches(completion: completion)
    }
    
    private func loadInitialMatches(completion: @escaping (Result<Void, MatchesManagerError>) -> Void) {
        loadMatchesFromAPI { [weak self] result in
            switch result {
            case .success(let matches):
                self?.allMatches = matches.sorted { $0.utcDate < $1.utcDate }
                completion(.success(()))
            case .failure(let error):
                completion(.failure(MatchesManagerError.networkError(error)))
            }
        }
    }
    
    func reloadMatches(completion: @escaping (Result<Void, MatchesManagerError>) -> Void) {
        // Сброс параметров перед повторной загрузкой данных
        currentPage = 0
        currentLeague = nil
        currentSortOrder = .ascending
        allMatches = []  // Очистка текущих матчей
        
        // Загрузка данных заново с помощью APICaller
        loadInitialMatches(completion: completion)
    }

    func loadMoreMatches(sortedBy order: MatchSortOrder, completion: @escaping (Result<[Match], MatchesManagerError>) -> Void) {
        updatePaginationSettings(for: nil, sortedBy: order)
        loadPaginatedMatches(from: allMatches, sortedBy: order, completion: completion)
    }

    func loadMoreMatchesFrom(leagueId: String, sortedBy order: MatchSortOrder, completion: @escaping (Result<[Match], MatchesManagerError>) -> Void) {
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

    private func loadPaginatedMatches(from matches: [Match], sortedBy order: MatchSortOrder, completion: @escaping (Result<[Match], MatchesManagerError>) -> Void) {
        let startIndex: Int
        let endIndex: Int

        guard pageSize > 0 else {
            completion(.failure(.emptyMatchesData))
            return
        }

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

        loadLogosSequentially(matches: paginatedMatches, index: 0) { result in
            switch result {
            case .success(let updatedMatches):
                completion(.success(order == .ascending ? updatedMatches : updatedMatches.reversed()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func loadLogosSequentially(matches: [Match], index: Int, completion: @escaping (Result<[Match], MatchesManagerError>) -> Void) {
        var matches = matches
        guard index < matches.count else {
            completion(.success(matches))
            return
        }

        let match = matches[index]
        let group = DispatchGroup()
        var errorOccurred: MatchesManagerError?

        group.enter()
        LogoFetcher.shared.fetchLogo(for: match.homeTeam.id ?? 0) { result in
            switch result {
            case .success(let data):
                if let matchIndex = matches.firstIndex(where: { $0.id == match.id }) {
                    matches[matchIndex].homeTeamLogo = data
                }
            case .failure(let error):
                errorOccurred = .logoFetchError(teamId: match.homeTeam.id ?? 0)
            }
            group.leave()
        }

        group.enter()
        LogoFetcher.shared.fetchLogo(for: match.awayTeam.id ?? 0) { result in
            switch result {
            case .success(let data):
                if let matchIndex = matches.firstIndex(where: { $0.id == match.id }) {
                    matches[matchIndex].guestTeamLogo = data
                }
            case .failure(let error):
                errorOccurred = .logoFetchError(teamId: match.awayTeam.id ?? 0)
            }
            group.leave()
        }

        group.notify(queue: .main) {
            if let error = errorOccurred {
                completion(.failure(error))
            } else {
                self.loadLogosSequentially(matches: matches, index: index + 1, completion: completion)
            }
        }
    }

    // Метод для загрузки матчей с помощью APICaller
    private func loadMatchesFromAPI(completion: @escaping (Result<[Match], Error>) -> Void) {
        // Используем APICaller для получения матчей
        APICaller.shared.fetchAllMatches { result in
            switch result {
            case .success(let matches):
                completion(.success(matches))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
