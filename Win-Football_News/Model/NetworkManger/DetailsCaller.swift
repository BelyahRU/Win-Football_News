
import Foundation

struct MatchDetails: Codable {
    let venue: String?
    let location: String?
}

final class DetailsCaller {
    
    static let shared = DetailsCaller()
    
    private let apiKey = NetworkConstant.token

    private init() {}
    
    // Функция для выполнения запроса и получения данных
    func fetchMatchDetails(matchID: Int, completion: @escaping (String?, String?) -> Void) {
        let url = URL(string: "https://api.football-data.org/v4/matches/\(matchID)")!
        var request = URLRequest(url: url)
        
        // Укажите свой API-ключ
        request.setValue(apiKey, forHTTPHeaderField: "X-Auth-Token")
        
        // Выполнение сетевого запроса
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil, nil)
                return
            }
            
            do {
                print(String(data: data, encoding: .utf8))
                // Декодирование JSON-ответа
                let matchDetails = try JSONDecoder().decode(MatchDetails.self, from: data)
                completion(matchDetails.venue, matchDetails.location)
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion(nil, nil)
            }
        }
        task.resume()
    }
}
