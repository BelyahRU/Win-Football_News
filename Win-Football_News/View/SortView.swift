
import Foundation
import UIKit

final class SortView: UIView {
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 23/255.0, green: 24/255.0, blue: 39/255.0, alpha: 0.95)
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let separatorLine1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        return view
    }()
    
    private let separatorLine2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        return view
    }()
    
    private let sortingLabel: UILabel = {
        let label = UILabel()
        label.text = "Sorting"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        return label
    }()
    
    public let earlierMatchesFirst: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Earlier matches first", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return button
    }()
    
    public let laterMatchesFirst: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Later matches first", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return button
    }()
    
    public let cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 23/255.0, green: 24/255.0, blue: 39/255.0, alpha: 0.95)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
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
        addSubview(separatorLine1)
        addSubview(separatorLine2)
        addSubview(sortingLabel)
        addSubview(earlierMatchesFirst)
        addSubview(laterMatchesFirst)
        addSubview(cancelButton)
    }
    
    private func setupConstraints() {
        backView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(136)
        }
        
        separatorLine1.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(136/3)
        }
        
        separatorLine2.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset((136/1.5))
        }
        
        sortingLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(8)
            make.bottom.equalTo(separatorLine1.snp.top).offset(-8)
        }
        
        earlierMatchesFirst.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(separatorLine1.snp.bottom)
            make.bottom.equalTo(separatorLine2.snp.top)
        }
        
        laterMatchesFirst.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(45)
            make.bottom.equalTo(backView.snp.bottom)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(46)
        }
    }
}
