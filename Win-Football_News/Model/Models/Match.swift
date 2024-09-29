
import Foundation

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
    var leagueId: String? 
    var homeTeamLogo: Data?
    var guestTeamLogo: Data?
}


