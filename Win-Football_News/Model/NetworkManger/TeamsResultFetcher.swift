import Foundation

class TeamResultsFetcher {
    
    static let shared = TeamResultsFetcher()
    
    private init() {}
    
    private let baseURL = "https://api.football-data.org/v4/teams/"
    private let apiKey = NetworkConstant.token

    func fetchLastFiveResults(for teamId: Int, completion: @escaping (String?, String?, String?) -> Void) {
        guard let url = URL(string: "\(baseURL)\(teamId)/matches?status=FINISHED&limit=5") else {
            print("Error: uncorrected URL")
            completion(nil, nil, "Некорректный URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "X-Auth-Token")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Network Error: \(error?.localizedDescription ?? "Неизвестная ошибка")")
                completion(nil, nil, "Ошибка сети")
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                if let message = jsonResponse?["message"] as? String,
                   let errorCode = jsonResponse?["errorCode"] as? Int, errorCode == 429 {
                    completion(nil, nil, message)
                    return
                }
                
                guard let matches = jsonResponse?["matches"] as? [[String: Any]] else {
                    print("Error: Can't get array of matches")
                    completion(nil, nil, "Не удалось получить матчи")
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
                
                if let lastMatch = matches.first {
                    let lastMatchDescription = self.formatLastMatch(from: lastMatch, for: teamId)
                    completion(results.joined(), lastMatchDescription, nil)
                } else {
                    completion(results.joined(), nil, nil)
                }

            } catch {
                print("Parsing error: \(error.localizedDescription)")
                completion(nil, nil, "Ошибка при разборе данных")
            }
        }
        
        task.resume()
    }

    
    func fetchCurrentPosition(for teamId: Int, in leagueId: Int, completion: @escaping (Int?) -> Void) {
        guard let url = URL(string: "https://api.football-data.org/v2/competitions/\(leagueId)/standings") else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "X-Auth-Token")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Network error: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }

            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                guard let standings = jsonResponse?["standings"] as? [[String: Any]] else {
                    print("Error: can't get table")
                    completion(nil)
                    return
                }
                
                for standing in standings {
                    if let type = standing["type"] as? String, type == "TOTAL",
                       let table = standing["table"] as? [[String: Any]] {
                        
                        for teamInfo in table {
                            if let team = teamInfo["team"] as? [String: Any],
                               let id = team["id"] as? Int, id == teamId {
                                if let position = teamInfo["position"] as? Int {
                                    completion(position)
                                    return
                                }
                            }
                        }
                    }
                }
                
                completion(nil)
            } catch {
                print("JSON parsing error: \(error.localizedDescription)")
                completion(nil)
            }
        }

        task.resume()
    }

    
    private func formatLastMatch(from match: [String: Any], for teamId: Int) -> String? {
        guard let score = match["score"] as? [String: Any],
              let fullTime = score["fullTime"] as? [String: Any],
              let homeScore = fullTime["home"] as? Int,
              let awayScore = fullTime["away"] as? Int,
              let homeTeam = match["homeTeam"] as? [String: Any],
              let awayTeam = match["awayTeam"] as? [String: Any],
              let homeTeamName = homeTeam["name"] as? String,
              let awayTeamName = awayTeam["name"] as? String,
              let homeTeamId = homeTeam["id"] as? Int,
              let utcDate = match["utcDate"] as? String else {
            return nil
        }
        let homeTeamFormatted = formattedTeamName(homeTeamName)
        let awayTeamFormatted = formattedTeamName(awayTeamName)
        
        let dateFormatted = formattedDate(from: utcDate)
        
        let scoreFormatted = "\(homeScore):\(awayScore)"
        
        let lastMatchDescription = "\"\(homeTeamFormatted)\" - \"\(awayTeamFormatted)\" \(scoreFormatted), \(dateFormatted)"
        return lastMatchDescription
    }

    private func formattedTeamName(_ name: String) -> String {
        return name.prefix(1).uppercased() + name.dropFirst().lowercased()
    }

    private func formattedDate(from utcDate: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        inputFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        guard let date = inputFormatter.date(from: utcDate) else {
            return Date().description
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd.MM"
        return outputFormatter.string(from: date)
    }

}
