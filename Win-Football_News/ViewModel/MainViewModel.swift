import Foundation
enum LeagueIds: String, CaseIterable {
    case premierLeague = "PL"
    case serieA = "SA"
    case bundesliga = "BL1"
    case laLiga = "PD"
    case championsLeague = "CL"
}



class MainViewModel {
    
    weak var delegate: MainViewController?
    
    private var matchesManager: MatchesManager?
    private var apiCaller = APICaller.shared
    
    var matches: [Match] = []
    
    init() {
        self.matchesManager = MatchesManager(completion: { result in
            switch result {
            case .success():
                self.getNextTwentyMatches(sortedBy: .ascending) {
                    print("matches loaded")
                    if self.matches.count != 20 {
                        print("Error")
                    } else {
                        self.matchesLoaded()
                    }
                }
                print("OK")
            case .failure(let error):
                print("Error \(error)")
            }
        })
    }
    
    private func matchesLoaded() {
        DispatchQueue.main.async {
            self.delegate?.matchesLoaded()
        }
    }
    
    // Метод для сброса и перезагрузки данных
    public func reloadData(completion: @escaping () -> Void) {
        matchesManager?.resetCurrentPage()  // Сброс currentPage в 0
        matchesManager?.reloadMatches { [weak self] result in
            switch result {
            case .success:
                self?.getNextTwentyMatches(sortedBy: .ascending) {
                    print("Data reloaded successfully")
                    self?.matchesLoaded()
                    completion()
                }
            case .failure(let error):
                self?.handleError(error)
            }
        }
    }
    
    // Функция для загрузки следующих 20 матчей
    public func getNextTwentyMatches(sortedBy sortOrder: MatchSortOrder, completion: @escaping () -> Void) {
        matchesManager?.loadMoreMatches(sortedBy: sortOrder) { [weak self] result in
            switch result {
            case .success(let loadedMatches):
                self?.matches = loadedMatches
                completion()
            case .failure(let error):
                self?.handleError(error)
                completion()
            }
        }
    }

    // Функция для загрузки матчей по лиге
    public func getNextTwentyMatchesWith(leagueId: String, sortedBy sortOrder: MatchSortOrder, completion: @escaping () -> Void) {
        matchesManager?.loadMoreMatchesFrom(leagueId: leagueId, sortedBy: sortOrder) { [weak self] result in
            switch result {
            case .success(let loadedMatches):
                print(loadedMatches)
                self?.matches = loadedMatches
                completion()
            case .failure(let error):
                self?.handleError(error)
                completion()
            }
        }
    }
    
    // Получение конкретного матча по индексу
    public func getMatch(by index: Int) -> Match? {
        guard index >= 0 && index < matches.count else { return nil }
        return matches[index]
    }
    
    private func handleError(_ error: Error) {
        DispatchQueue.main.async {
            // Сообщение делегату или обработка ошибки в интерфейсе
            self.delegate?.showError(message: "Failed to load data: \(error.localizedDescription)")
        }
    }
    
    func extractTime(from dateTimeString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = inputFormatter.date(from: dateTimeString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "HH:mm"
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
    

    func formatDate(_ dateTimeString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let date = inputFormatter.date(from: dateTimeString) else { return nil }
        
        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "en_US")
        outputFormatter.dateFormat = "d MMM yyyy, EEE"
        
        return outputFormatter.string(from: date)
    }

}
