
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
    
    public let teamView = TeamsView()
    
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
        setupTeamView()
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
    }
    
    private func setupTeamView() {
        addSubview(teamView)
        teamView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(17)
            make.trailing.equalToSuperview().offset(-17)
            make.height.equalTo(27)
        }
            
        // Изначально обе команды не выбраны
        teamView.selectTeam(.left)
        
        // Добавляем жесты нажатия
        let leftTapGesture = UITapGestureRecognizer(target: self, action: #selector(teamTapped(_:)))
        teamView.addGestureRecognizer(leftTapGesture)
        
        let rightTapGesture = UITapGestureRecognizer(target: self, action: #selector(teamTapped(_:)))
        teamView.addGestureRecognizer(rightTapGesture)
        }
    @objc private func teamTapped(_ gesture: UITapGestureRecognizer) {
        if gesture.location(in: teamView).x < teamView.bounds.width / 2 {
            teamView.selectTeam(.left)
            updateData(for: "Первая команда")
        } else {
            teamView.selectTeam(.right)
            updateData(for: "Вторая команда")
        }
    }
    
    func updateData(for team: String) {
//            dataLabel.text = "Данные для \(team)"
    }
}
