
import UIKit

protocol MainViewModelDelegate: AnyObject {
    func matchesLoaded()
}

class ViewController: UIViewController, MainViewModelDelegate {
    
    var viewModel: MainViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    func setupViewModel() {
        viewModel = MainViewModel()
        viewModel.delegate = self
    }

    func matchesLoaded() {
        print(viewModel.getNextTwentyMatches(with: .laLiga))
    }

}

