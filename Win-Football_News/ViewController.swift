
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        FootballAPI.shared.fetchChampionsLeagueMatches(from: LeagueIds.premierLeague.rawValue)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            print(FootballAPI.shared.matches)
        }
    }


}

