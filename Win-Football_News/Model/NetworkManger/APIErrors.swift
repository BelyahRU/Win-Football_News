import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL(league: LeagueIds)
    case noData(league: LeagueIds)
    case decodingFailed(league: LeagueIds, error: Error)
    case fetchingMatchesFailed(league: LeagueIds, error: Error)
    case multipleErrors(errors: [Error])
    case rateLimitExceeded(message: String)

    var errorDescription: String? {
        switch self {
        case .invalidURL(let league):
            return "Invalid URL for \(league)"
        case .noData(let league):
            return "No data received for \(league)"
        case .fetchingMatchesFailed(let league, let error) :
            return "Error fetching matches for league \(league): \(error)"
        case .decodingFailed(let league, let error):
            return "Failed to decode JSON data"
        case .multipleErrors(let errors):
            return "Multiple errors occurred: \(errors.map { $0.localizedDescription }.joined(separator: ", "))"
        case .rateLimitExceeded(let message):
            return "Rate limit% \(message)"
        }
    }
}
