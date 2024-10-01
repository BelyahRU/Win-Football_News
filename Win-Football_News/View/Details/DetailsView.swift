
import Foundation
import UIKit

class DetailsView: UIView {
    
    public let logoImageView: UIImageView = {
         let im = UIImageView()
         im.contentMode = .scaleAspectFit
         im.image = UIImage(named: Resources.Images.logoImage)
         return im
     }()
    
    public let backButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named:Resources.Images.Buttons.backButton), for: .normal)
        return button
    }()
    
    public let leagueNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.text = "Seria A"
        return label
    }()
    
    public let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .white
        label.text = "10:00"
        return label
    }()
    
    private let leftSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Resources.Colors.blueColor
        view.layer.cornerRadius = 2
        return view
    }()
    
    public let team1Label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Название команды 1"
        label.textAlignment = .left
        return label
    }()
    
    public let team2Label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Название команды 2"
        label.textAlignment = .left
        return label
    }()
    
    public let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        return label
    }()
    
    public let teamsSelectionView = TeamSelectionView()
    
    private let recentResults1Label: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Recent results"
        label.textAlignment = .left
        return label
    }()
    
    
    public var recentResultView = RecentResultsView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Resources.Colors.mainBackgroundColor
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(logoImageView)
        addSubview(backButton)
        addSubview(leagueNameLabel)
        addSubview(timeLabel)
        addSubview(leftSeparatorView)
        addSubview(team1Label)
        addSubview(team2Label)
        addSubview(dateLabel)
        addSubview(teamsSelectionView)
        addSubview(recentResults1Label)
        addSubview(recentResultView)
    }
    
    private func setupConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.width.equalTo(124)
            make.height.equalTo(37.2)
            make.leading.equalToSuperview().offset(17)
            make.top.equalToSuperview().offset(65)
        }
        
        backButton.snp.makeConstraints { make in
            make.size.equalTo(22)
            make.leading.equalToSuperview().offset(17)
            make.top.equalTo(logoImageView.snp.bottom).offset(41)
        }
        
        leagueNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(backButton.snp.trailing)
            make.centerY.equalTo(backButton.snp.centerY)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.leading.equalTo(leagueNameLabel.snp.leading)
            make.top.equalTo(leagueNameLabel.snp.bottom).offset(14)
        }
        
        leftSeparatorView.snp.makeConstraints { make in
            make.width.equalTo(2)
            make.height.equalTo(32)
            make.leading.equalTo(leagueNameLabel.snp.leading)
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
        }
        
        
        team1Label.snp.makeConstraints { make in
            make.top.equalTo(leftSeparatorView.snp.top)
            make.leading.equalTo(leftSeparatorView.snp.trailing).offset(7)
        }
        
        
        team2Label.snp.makeConstraints { make in
            make.bottom.equalTo(leftSeparatorView.snp.bottom)
            make.leading.equalTo(leftSeparatorView.snp.trailing).offset(7)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(leftSeparatorView.snp.bottom).offset(14)
            make.trailing.equalToSuperview().offset(-17)
        }
        
        teamsSelectionView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(17)
            make.trailing.equalToSuperview().offset(-17)
            make.height.equalTo(27)
        }
        
        recentResults1Label.snp.makeConstraints { make in
            make.top.equalTo(teamsSelectionView.snp.bottom).offset(14)
            make.leading.equalTo(leftSeparatorView.snp.leading)
        }
        
        recentResultView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(17)
            make.trailing.equalToSuperview().offset(-17)
            make.height.equalTo(115)
            make.top.equalTo(recentResults1Label.snp.bottom).offset(14)
        }
        
    }
   
    func setupTeamsView(team1Name: String, firstImage: Data, team2Name: String, secondImage: Data) {
        teamsSelectionView.homeTeamButton.setTitle(team1Name, for: .normal)
        teamsSelectionView.awayTeamButton.setTitle(team2Name, for: .normal)
        teamsSelectionView.logo1ImageView.image = UIImage(data: firstImage)
        teamsSelectionView.logo2ImageView.image = UIImage(data: secondImage)
    }
}
