
import Foundation
import UIKit

class MatchColletionViewCell: UICollectionViewCell {
    
    public let whiteBackRoundedView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    
    public let leagueNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.1)
        return view
    }()
    
    public let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    static let reuseId = "MatchColletionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //ADD
    }
    
    private func configure() {
        setupSubviews()
        setupConstraints()
        contentView.backgroundColor = .clear
    }
    
    private func setupSubviews() {
        contentView.addSubview(whiteBackRoundedView)
        contentView.addSubview(leagueNameLabel)
        contentView.addSubview(separatorView)
    }
    
    private func setupConstraints() {
        whiteBackRoundedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        leagueNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(45)
            make.top.equalToSuperview().offset(18)
            make.height.equalTo(14)
        }
        
        separatorView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(leagueNameLabel.snp.bottom).offset(12)
        }
    }
    
    public func setupText(text: String) {
        leagueNameLabel.text = text
    }
}
