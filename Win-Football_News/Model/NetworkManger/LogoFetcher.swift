import Foundation

final class LogoFetcher {
    
    private let logoBaseURL = "https://crests.football-data.org/"
    
    static let shared = LogoFetcher()
    
    private init() {}
    
    func fetchLogo(for teamId: Int, completion: @escaping (Data?) -> Void) {
        let urlString = "\(logoBaseURL)\(teamId).png"
        
        guard let imageUrl = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let request = URLRequest(url: imageUrl)
        let task = URLSession.shared.dataTask(with: request) {  data, response, error in
            if let error = error {
                print("Error fetching matches for team \(teamId): \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data received for team \(teamId)")
                completion(nil)
                return
            }
            completion(data)
        }
        task.resume()
    }
}
