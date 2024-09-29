
import UIKit
import SnapKit

protocol MainViewModelDelegate: AnyObject {
    func matchesLoaded()
}

class MainViewController: UIViewController, MainViewModelDelegate {
    
    var viewModel: MainViewModel!
    var mainView = MainView()
    
    // Объявляем индикатор активности
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    public let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupActivityIndicator()
        setupColletionView()
        setupButtons()
        startLoadingAnimation()
    }
    
    func setupViewModel() {
        viewModel = MainViewModel()
        viewModel.delegate = self
    }

    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func startLoadingAnimation() {
        activityIndicator.isHidden = false
        self.view.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func stopLoadingAnimation() {
        activityIndicator.isHidden = true
        self.view.bringSubviewToFront(activityIndicator)
        activityIndicator.stopAnimating()
    }
    
    func matchesLoaded() {
        stopLoadingAnimation()
        
        //mainView not added
        if mainView.widthAnchor != view.widthAnchor {
            view.addSubview(mainView)
            mainView.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = Resources.Colors.mainBackgroundColor
            NSLayoutConstraint.activate([
                mainView.topAnchor.constraint(equalTo: self.view.topAnchor),
                mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                mainView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                mainView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
            
            view.addSubview(collectionView)
            collectionView.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(17)
                make.trailing.equalToSuperview().offset(-17)
                make.bottom.equalToSuperview()
                make.top.equalTo(mainView.logoImageView.snp.bottom).offset(28)
            }
        //added before
        } else {
            collectionView.reloadData()
        }
        
    }
}
