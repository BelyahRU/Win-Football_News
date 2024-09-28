
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        APICaller.shared.fetchAllMatches { matchesArray in
            <#code#>
        }
        
    }
    
    func printMatches() {
        print()
    }


}

