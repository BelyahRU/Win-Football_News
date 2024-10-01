import UIKit
import SnapKit

class MainView: UIView {
    
//    public let filtersButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: Resources.Images.Buttons.filtersButton), for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    public let sortButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: Resources.Images.Buttons.sortButton), for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    public let logoImageView: UIImageView = {
         let im = UIImageView()
         im.contentMode = .scaleAspectFit
         im.image = UIImage(named: Resources.Images.logoImage)
         return im
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
        setupUI()
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
    }
    
    private func setupSubviews() {
        addSubview(logoImageView)
//        addSubview(filtersButton)
    }
    
    private func setupConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.width.equalTo(124)
            make.height.equalTo(37.2)
            make.leading.equalToSuperview().offset(17)
            make.top.equalToSuperview().offset(65)
        }
//        
//        filtersButton.snp.makeConstraints { make in
//            make.size.equalTo(28)
//            make.top.equalToSuperview().offset(70)
//            make.trailing.equalTo(sortButton.snp.leading).offset(-17)
//        }
        
    }
}
