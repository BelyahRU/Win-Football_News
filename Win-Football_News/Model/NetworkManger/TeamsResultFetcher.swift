import Foundation

class TeamResultsFetcher {
    
    static let shared = TeamResultsFetcher()
    
    private init() {}
    
    private let baseURL = "https://api.football-data.org/v4/teams/"
    private let apiKey = NetworkConstant.token

    func fetchLastFiveResults(for teamId: Int, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "\(baseURL)\(teamId)/matches?status=FINISHED&limit=5") else {
            print("Ошибка: Неверный URL для команды")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "X-Auth-Token")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Ошибка сетевого запроса: \(error?.localizedDescription ?? "Неизвестная ошибка")")
                completion(nil)
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                guard let matches = jsonResponse?["matches"] as? [[String: Any]] else {
                    print("Ошибка: Невозможно извлечь список матчей")
                    completion(nil)
                    return
                }
                let results = matches.prefix(5).compactMap { match -> String? in
                    guard let score = match["score"] as? [String: Any],
                          let fullTime = score["fullTime"] as? [String: Any],
                          let homeScore = fullTime["home"] as? Int,
                          let awayScore = fullTime["away"] as? Int,
                          let homeTeam = match["homeTeam"] as? [String: Any],
                          let homeTeamId = homeTeam["id"] as? Int else {
                        return nil
                    }
                    
                    let isHomeTeam = (homeTeamId == teamId)
                    
                    if homeScore == awayScore {
                        return "Н"
                    } else if (homeScore > awayScore && isHomeTeam) || (awayScore > homeScore && !isHomeTeam) {
                        return "В"
                    } else {
                        return "П"
                    }
                }
                
                completion(results.joined())

            } catch {
                print("Ошибка парсинга JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
