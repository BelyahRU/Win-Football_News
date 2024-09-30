
import Foundation

final class APICaller {
    static let shared = APICaller()
    private let apiKey = "83818a3718a84be5b58e7b34b614ed02"
    
    var leagueConverter: [String: String] = ["PL": "Premier League",
                                           "SA": "Seria A",
                                           "BL1": "Bundesliga",
                                           "PD": "LaLiga",
                                           "CL": "Champions League",
    ]
    
    private init() {}

    private func fetchMatches(for league: LeagueIds, completion: @escaping (Result<[Match?], Error>) -> Void) {
        let urlString = "https://api.football-data.org/v4/competitions/\(league.rawValue)/matches"
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.invalidURL(league: league)))
            return
        }

        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "X-Auth-Token")

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(APIError.fetchingMatchesFailed(league: league, error: error)))
                return
            }

            guard let data = data else {
                
                completion(.failure(APIError.noData(league: league)))
                return
            }

            do {
                let decoder = JSONDecoder()
                print(String(data: data, encoding: .utf8))
                var matchesResponse = try decoder.decode(MatchesResponse.self, from: data)
                
                guard let matches = matchesResponse.matches else {
                    completion(.failure(APIError.decodingFailed(league: league, error: NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No matches available"]))))
                    return
                }
                matchesResponse.matches = matches.map { match in
                    var updatedMatch = match
                    updatedMatch.leagueId = self.leagueConverter[league.rawValue]!
                    return updatedMatch
                }

                let upcomingMatches = matchesResponse.matches!.filter { match in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
                    dateFormatter.timeZone = TimeZone(identifier: "UTC")


                    guard let matchDate = dateFormatter.date(from: match.utcDate) else {
                        return false
                    }
                    return matchDate > Date()
                }
                completion(.success(upcomingMatches))
            } catch {
                completion(.failure(APIError.decodingFailed(league: league, error: error)))
            }
        }.resume()
    }


    func fetchAllMatches(completion: @escaping (Result<[Match], Error>) -> Void) {
        let dispatchGroup = DispatchGroup()
        var combinedMatches = [Match]()
        var errors = [Error]()
        
        for league in LeagueIds.allCases {
            dispatchGroup.enter()
            
            fetchMatches(for: league) { result in
                switch result {
                case .success(let matches):
                    let nonNilMatches = matches.compactMap { $0 }
                    combinedMatches.append(contentsOf: nonNilMatches)
                case .failure(let error):
                    errors.append(error)
                }
                
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            if errors.isEmpty {
                completion(.success(combinedMatches))
            } else {
                completion(.failure(APIError.multipleErrors(errors: errors)))
            }
        }
    }
}

struct MatchesResponse: Decodable {
    var matches: [Match]?
    enum CodingKeys: String, CodingKey {
            case matches
        }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.matches = try container.decodeIfPresent([Match].self, forKey: .matches)
    }
}
