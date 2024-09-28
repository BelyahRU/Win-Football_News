
import UIKit

protocol MainViewModelDelegate: AnyObject {
    func matchesLoaded()
}

class MainViewController: UIViewController, MainViewModelDelegate {
    
    var viewModel: MainViewModel!
    var mainView = MainView()
    
    public let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupColletionView()
    }
    
    func setupViewModel() {
        viewModel = MainViewModel()
        viewModel.getNextTwentyMatches(sortedBy: .ascending)
        viewModel.delegate = self
    }

    func matchesLoaded() {
        view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
            make.top.equalTo(mainView.sortButton.snp.bottom).offset(10)
        }
    }

}

