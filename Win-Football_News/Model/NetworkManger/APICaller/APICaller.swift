
import Foundation

final class APICaller {
    static let shared = APICaller()
    private let apiKey = "83818a3718a84be5b58e7b34b614ed02"
    
    private init() {}

    private func fetchMatches(for league: LeagueIds, completion: @escaping ([Match]?) -> Void) {
        let urlString = "https://api.football-data.org/v4/competitions/\(league.rawValue)/matches"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "X-Auth-Token")

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching matches for league \(league): \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data received for league \(league)")
                completion(nil)
                return
            }

            do {
                let decoder = JSONDecoder()
                var matchesResponse = try decoder.decode(MatchesResponse.self, from: data)
                
                // Добавляем идентификатор лиги к каждому матчу
                matchesResponse.matches = matchesResponse.matches.map { match in
                    var updatedMatch = match
                    updatedMatch.leagueId = league.rawValue
                    return updatedMatch
                }

                // Фильтруем только будущие матчи
                let upcomingMatches = matchesResponse.matches.filter { match in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
                    dateFormatter.timeZone = TimeZone(identifier: "UTC")

                    guard let matchDate = dateFormatter.date(from: match.utcDate) else {
                        return false
                    }
                    return matchDate > Date()
                }
                completion(upcomingMatches)
            } catch {
                print("Error decoding JSON for league \(league): \(error)")
                completion(nil)
            }
        }.resume()
    }


    func fetchAllMatches(completion: @escaping ([Match]) -> Void) {
        let dispatchGroup = DispatchGroup()
        var combinedMatches = [Match]()

        for league in LeagueIds.allCases {
            dispatchGroup.enter()
            fetchMatches(for: league) { matches in
                if let matches = matches {
                    combinedMatches.append(contentsOf: matches)
                }
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            completion(combinedMatches)
        }
    }
}

struct MatchesResponse: Decodable {
    var matches: [Match]
}
