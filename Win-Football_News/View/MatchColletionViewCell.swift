
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
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.1)
        return view
    }()
    
    private let leftSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Resources.Colors.blueColor
        view.layer.cornerRadius = 2
        return view
    }()
    
    public let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    public let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        return label
    }()
    
    public let flagLeagueImageView: UIImageView = {
       let im = UIImageView()
        im.contentMode = .scaleAspectFit
        return im
    }()
    
    public let team1Label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Название команды 1"
        label.textAlignment = .left
        return label
    }()
    
    public let team2Label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Название команды 2"
        label.textAlignment = .left
        return label
    }()
    
    public let logo1ImageView: UIImageView = {
        let im = UIImageView()
         im.contentMode = .scaleAspectFit
         return im
    }()
    
    public let logo2ImageView: UIImageView = {
        let im = UIImageView()
         im.contentMode = .scaleAspectFit
         return im
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
        leagueNameLabel.text = ""
        flagLeagueImageView.image = nil
        timeLabel.text = ""
        dateLabel.text = ""
        team1Label.text = ""
        team2Label.text = ""
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
        contentView.addSubview(flagLeagueImageView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(leftSeparatorView)
        contentView.addSubview(logo1ImageView)
        contentView.addSubview(team1Label)
        contentView.addSubview(logo2ImageView)
        contentView.addSubview(team2Label)
        contentView.addSubview(dateLabel)
    }
    
    private func setupConstraints() {
        whiteBackRoundedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(42)
        }
        
        flagLeagueImageView.snp.makeConstraints { make in
            make.width.equalTo(16)
            make.height.equalTo(10)
            make.leading.equalToSuperview().offset(21)
            make.top.equalToSuperview().offset(20)
        }
        
        leagueNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(45)
            make.centerY.equalTo(flagLeagueImageView.snp.centerY)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.leading.equalTo(flagLeagueImageView.snp.leading).offset(-2)
            make.top.equalTo(separatorView.snp.bottom).offset(8)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-21)
            make.centerY.equalTo(timeLabel.snp.centerY)
        }
        
        leftSeparatorView.snp.makeConstraints { make in
            make.width.equalTo(2)
            make.height.equalTo(32)
            make.leading.equalTo(flagLeagueImageView.snp.leading)
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
        }
        
        
        team1Label.snp.makeConstraints { make in
            make.top.equalTo(leftSeparatorView.snp.top)
            make.leading.equalTo(leftSeparatorView.snp.trailing).offset(30)
        }
        
        
        team2Label.snp.makeConstraints { make in
            make.bottom.equalTo(leftSeparatorView.snp.bottom)
            make.leading.equalTo(leftSeparatorView.snp.trailing).offset(30)
        }
        
        logo1ImageView.snp.makeConstraints { make in
            make.centerY.equalTo(team1Label.snp.centerY)
            make.leading.equalTo(leftSeparatorView.snp.trailing).offset(7)
            make.size.equalTo(16)
        }
        
        logo2ImageView.snp.makeConstraints { make in
            make.centerY.equalTo(team2Label.snp.centerY)
            make.leading.equalTo(leftSeparatorView.snp.trailing).offset(7)
            make.size.equalTo(16)
        }
    }
    
    public func setupText(league: String, time: String, date: String, team1: String, team2: String, logo1Data: Data?, logo2Data: Data?) {
        leagueNameLabel.text = league
        flagLeagueImageView.image = UIImage(named: league)
        timeLabel.text = time
        dateLabel.text = date
        team1Label.text = team1
        team2Label.text = team2
        if let logo1Data = logo1Data {
            logo1ImageView.image = UIImage(data: logo1Data)
        }
        
        if let logo2Data = logo2Data {
            logo2ImageView.image = UIImage(data: logo2Data)
        }
    }
}
