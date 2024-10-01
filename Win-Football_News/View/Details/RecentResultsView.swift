
import Foundation
import UIKit

class RecentResultsView: UIView {
    
    private let firtsSeparatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.1)
        return view
    }()
    
    private let recentResultsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Last 5 results"
        label.textAlignment = .left
        return label
    }()
    
    public let lastFiveMatchesResult = LastFiveMatchesView()
    
    private let previousMatchLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Previous match"
        label.textAlignment = .left
        return label
    }()
    
    public let previousMatchResult: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setupUI()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupUI() {
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        self.backgroundColor = .white
    }
    
    private func setupSubviews() {
        addSubview(firtsSeparatorLine)
        addSubview(recentResultsLabel)
        addSubview(lastFiveMatchesResult)
        addSubview(previousMatchLabel)
        addSubview(previousMatchResult)
    }
    
    private func setupConstraints() {
        firtsSeparatorLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalToSuperview().offset(57)
        }
        
        recentResultsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(20)
        }
        
        lastFiveMatchesResult.snp.makeConstraints { make in
            make.bottom.equalTo(firtsSeparatorLine.snp.top).offset(-12)
            make.leading.equalTo(recentResultsLabel.snp.leading)
            make.width.equalTo(90)
            make.height.equalTo(14)
        }
        
        previousMatchLabel.snp.makeConstraints { make in
            make.leading.equalTo(recentResultsLabel.snp.leading)
            make.top.equalTo(firtsSeparatorLine.snp.bottom).offset(12)
        }
        
        previousMatchResult.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom).offset(-12)
            make.leading.equalTo(recentResultsLabel.snp.leading)
        }
        
    }
    
    func setupUI(fiveMatches: String, lastResult: String) {
        lastFiveMatchesResult.setupUI(str: fiveMatches)
        previousMatchResult.text = lastResult
    }
}
