import Foundation
enum LogoFetcherError: Error, CustomStringConvertible {
    case invalidURL(String)
    case networkError(Error)
    case invalidResponse(statusCode: Int)
    case noDataReceived

    var description: String {
        switch self {
        case .invalidURL(let urlString):
            return "LogoFetcherError.Invalid URL: \(urlString)"
        case .networkError(let error):
            return "LogoFetcherError.Network error occurred: \(error.localizedDescription)"
        case .invalidResponse(let statusCode):
            return "LogoFetcherError.Received invalid response with status code: \(statusCode)"
        case .noDataReceived:
            return "LogoFetcherError.No data received from the server."
        }
    }
}

final class LogoFetcher {
    
    private let logoBaseURL = "https://crests.football-data.org/"
    
    static let shared = LogoFetcher()
    
    private init() {}
    
    func fetchLogo(for teamId: Int, completion: @escaping (Result<Data, LogoFetcherError>) -> Void) {
            let urlString = "\(logoBaseURL)\(teamId).png"
            
            guard let imageUrl = URL(string: urlString) else {
                completion(.failure(.invalidURL(urlString)))
                return
            }
            
            let request = URLRequest(url: imageUrl)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(.networkError(error)))
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                    completion(.failure(.invalidResponse(statusCode: statusCode)))
                    return
                }

                guard let data = data else {
                    completion(.failure(.noDataReceived))
                    return
                }
                
                completion(.success(data))
            }
            task.resume()
        }
}
