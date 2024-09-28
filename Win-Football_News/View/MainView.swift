import UIKit
import SnapKit

class MainView: UIView {
    
    
    public let filterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("Filter", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public let sortButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Sort", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
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
        addSubview(filterButton)
        addSubview(sortButton)
    }
    
    private func setupConstraints() {
        filterButton.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(30)
            make.top.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        sortButton.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(30)
            make.top.equalToSuperview().offset(60)
            make.leading.equalToSuperview().offset(20)
        }
        
        
    }
}
