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
//        apiCaller.fetchAllMatches { [weak self] matchesArray in
//            guard let self = self else { return }
//            self.matchesManager = MatchesManager(matches: matchesArray)
//            self.getNextTwentyMatches(sortedBy: .ascending) {
//                print("matches loaded")
//                print(self.matches)
//                self.matchesLoaded()
//            }
//        }
    }
    
    private func matchesLoaded() {
        DispatchQueue.main.async {
            self.delegate?.matchesLoaded()
        }
    }
    
    public func getNextTwentyMatches(sortedBy sortOrder: MatchSortOrder, completion: @escaping () -> Void) {
        matchesManager?.loadMoreMatches(sortedBy: sortOrder) { [weak self] loadedMatches in
            self?.matches = loadedMatches
            completion()
        }
    }

    public func getNextTwentyMatchesWith(leagueId: LeagueIds, sortedBy sortOrder: MatchSortOrder, completion: @escaping ([Match]) -> Void) {
        matchesManager?.loadMoreMatchesFrom(leagueId: leagueId.rawValue, sortedBy: sortOrder) { [weak self] loadedMatches in
            self?.matches = loadedMatches
            completion(loadedMatches)
        }
    }
    
    public func getMatch(by index: Int) -> Match? {
        if index >= 0 && index < matches.count {
            print("MATCH: ")
            print("MATCH: ")
            print("MATCH: ")
            print("MATCH: ")
            print(matches[index], index)
            return matches[index]
        }
        print("returned nil")
        print("returned nil")
        print("returned nil")
        print("returned nil")
        print(matches)
        return nil
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
