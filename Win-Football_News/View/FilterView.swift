
import Foundation
import UIKit

class FilterView: UIView {
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = Resources.Colors.mainBackgroundColor
        return view
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = Resources.Colors.darkBlueColor
        return view
    }()
    
    private let filterLabel: UILabel = {
        let label = UILabel()
        label.text = "Filter"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    public let cancelButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: Resources.Images.Buttons.closeButton), for: .normal)
        return button
    }()
    
    private let tournamentBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let tournamentLabel: UILabel = {
        let label = UILabel()
        label.text = "Tournament"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    public let premierLeagueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Premier League", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.backgroundColor = .clear
        return button
     }()
    
    public let seriaAButton: UIButton = {
        let button = UIButton()
        button.setTitle("Seria A", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.backgroundColor = .clear
        return button
     }()
    
    public let bundesligaButton: UIButton = {
        let button = UIButton()
        button.setTitle("Bundesliga", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.backgroundColor = .clear
        return button
     }()
    
    public let laLigaButton: UIButton = {
        let button = UIButton()
        button.setTitle("LaLiga", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.backgroundColor = .clear
        return button
     }()
    
    public let uclButton: UIButton = {
        let button = UIButton()
        button.setTitle("UCL", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.backgroundColor = .clear
        return button
     }()
    
    public let plSelectedImageView: UIImageView = {
       let im = UIImageView()
        im.image = UIImage(named: Resources.Images.selectedImage)
        im.isHidden = true
        return im
    }()
    
    public let sASelectedImageView: UIImageView = {
       let im = UIImageView()
        im.image = UIImage(named: Resources.Images.selectedImage)
        im.isHidden = true
        return im
    }()
    
    public let bundSelectedImageView: UIImageView = {
       let im = UIImageView()
        im.image = UIImage(named: Resources.Images.selectedImage)
        im.isHidden = true
        return im
    }()
    
    public let laLigaSelectedImageView: UIImageView = {
       let im = UIImageView()
        im.image = UIImage(named: Resources.Images.selectedImage)
        im.isHidden = true
        return im
    }()
    
    public let uclSelectedImageView: UIImageView = {
       let im = UIImageView()
        im.image = UIImage(named: Resources.Images.selectedImage)
        im.isHidden = true
        return im
    }()
    
    public let applyFilter: UIButton = {
        let button = UIButton()
        button.setTitle("Apply", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.backgroundColor = Resources.Colors.darkBlueColor
        button.layer.cornerRadius = 16
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        addSubview(backView)
        addSubview(headerView)
        addSubview(filterLabel)
        addSubview(cancelButton)
        addSubview(tournamentBackView)
        addSubview(tournamentLabel)
        
        addSubview(premierLeagueButton)
        addSubview(seriaAButton)
        addSubview(bundesligaButton)
        addSubview(laLigaButton)
        addSubview(uclButton)
        
        addSubview(plSelectedImageView)
        addSubview(sASelectedImageView)
        addSubview(bundSelectedImageView)
        addSubview(laLigaSelectedImageView)
        addSubview(uclSelectedImageView)
        
        addSubview(applyFilter)
    }
    
    private func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(63)
        }
            
        backView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
            
        filterLabel.snp.makeConstraints { make in
            make.center.equalTo(headerView)
        }
            
        cancelButton.snp.makeConstraints { make in
            make.size.equalTo(28)
            make.centerY.equalTo(headerView.snp.centerY)
            make.leading.equalToSuperview().offset(17)
        }
        
        tournamentBackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().offset(-14)
            make.top.equalTo(headerView.snp.bottom).offset(27)
            make.height.equalTo(155)
        }
        
        tournamentLabel.snp.makeConstraints { make in
            make.leading.equalTo(tournamentBackView.snp.leading).offset(20)
            make.top.equalTo(tournamentBackView.snp.top).offset(17)
        }
        
        premierLeagueButton.snp.makeConstraints { make in
            make.width.equalTo(110)
            make.height.equalTo(10)
            make.leading.equalToSuperview().offset(42)
            make.top.equalTo(tournamentBackView.snp.top).offset(41)
        }
        
        plSelectedImageView.snp.makeConstraints { make in
            make.size.equalTo(10)
            make.trailing.equalToSuperview().offset(-35)
            make.centerY.equalTo(premierLeagueButton.snp.centerY)
        }
        
        seriaAButton.snp.makeConstraints { make in
            make.width.equalTo(110)
            make.height.equalTo(10)
            make.leading.equalToSuperview().offset(42)
            make.top.equalTo(premierLeagueButton.snp.bottom).offset(12)
        }
        
        sASelectedImageView.snp.makeConstraints { make in
            make.size.equalTo(10)
            make.trailing.equalToSuperview().offset(-35)
            make.centerY.equalTo(seriaAButton.snp.centerY)
        }
        
        bundesligaButton.snp.makeConstraints { make in
            make.width.equalTo(110)
            make.height.equalTo(10)
            make.leading.equalToSuperview().offset(42)
            make.top.equalTo(seriaAButton.snp.bottom).offset(12)
        }
        
        bundSelectedImageView.snp.makeConstraints { make in
            make.size.equalTo(10)
            make.trailing.equalToSuperview().offset(-35)
            make.centerY.equalTo(bundesligaButton.snp.centerY)
        }
        
        laLigaButton.snp.makeConstraints { make in
            make.width.equalTo(110)
            make.height.equalTo(10)
            make.leading.equalToSuperview().offset(42)
            make.top.equalTo(bundesligaButton.snp.bottom).offset(12)
        }
        
        laLigaSelectedImageView.snp.makeConstraints { make in
            make.size.equalTo(10)
            make.trailing.equalToSuperview().offset(-35)
            make.centerY.equalTo(laLigaButton.snp.centerY)
        }
        
        uclButton.snp.makeConstraints { make in
            make.width.equalTo(110)
            make.height.equalTo(10)
            make.leading.equalToSuperview().offset(42)
            make.top.equalTo(laLigaButton.snp.bottom).offset(12)
        }
        
        uclSelectedImageView.snp.makeConstraints { make in
            make.size.equalTo(10)
            make.trailing.equalToSuperview().offset(-35)
            make.centerY.equalTo(uclButton.snp.centerY)
        }
        
        applyFilter.snp.makeConstraints { make in
            make.width.equalTo(164)
            make.height.equalTo(47)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Установка cornerRadius только у верхних углов
        let path = UIBezierPath(roundedRect: headerView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 16, height: 16))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        headerView.layer.mask = mask
    }
}
