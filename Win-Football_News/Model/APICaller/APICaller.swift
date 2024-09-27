import Foundation

enum LeagueIds: String {
    case premierLeague = "PL"
    case serieA = "SA"
    case bundesliga = "BL1"
    case laLiga = "PD"
    case championsLeague = "CL"
}

// Класс для работы с API Football-Data.org
class FootballAPI {
    static let shared = FootballAPI()

    var matches: [Match] = []

    // token
    private let apiKey = "83818a3718a84be5b58e7b34b614ed02"

    let leagues = [
        League(id: LeagueIds.premierLeague.rawValue,
               name: "Premier League",
               imageName: "premier_league"),
        League(id: LeagueIds.serieA.rawValue,
               name: "Serie A",
               imageName: "serie_a"),
        League(id: LeagueIds.bundesliga.rawValue,
               name: "Bundesliga",
               imageName: "bundesliga"),
        League(id: LeagueIds.laLiga.rawValue,
               name: "La Liga",
               imageName: "primera_division"),
        League(id: LeagueIds.championsLeague.rawValue,
               name: "UEFA Champions League",
               imageName: "champions_league")
    ]
    func fetchChampionsLeagueMatches(from league: LeagueIds.RawValue) {

        let urlString = "https://api.football-data.org/v4/competitions/\(league)/matches"

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "X-Auth-Token")
        
        URLSession.shared.dataTask(with: request) {data,responce,error in
            if let error = error {
                print("Error fetching matches: \(error)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }
            do {
                let decoder = JSONDecoder()
                let matchesResponse = try decoder.decode(MatchesResponse.self, from: data)
                self.matches = matchesResponse.matches.filter { match in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
                    dateFormatter.timeZone = TimeZone(identifier: "UTC")
                    guard let matchDate = dateFormatter.date(from: match.utcDate) else {
                        return false
                    }
                    return matchDate > Date()
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        .resume()
    }
}

struct MatchesResponse: Decodable {
    let matches: [Match]
}

struct Match: Decodable {
    let id: Int
    let season: Season
    let utcDate: String
    let status: String
    let matchday: Int?
    let stage: String
    let group: String?
    let homeTeam: Team
    let awayTeam: Team
}

struct Season: Decodable {
    let id: Int
    let startDate: String
    let endDate: String
}

struct Team: Decodable {
    let id: Int?
    let name: String?
}
