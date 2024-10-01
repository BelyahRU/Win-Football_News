
import Foundation
import UIKit

class LastFiveMatchesView: UIView {
    
    private let firstResult: UIImageView = {
        let im = UIImageView()
         im.contentMode = .scaleAspectFit
         return im
    }()
    
    private let secondResult: UIImageView = {
        let im = UIImageView()
         im.contentMode = .scaleAspectFit
         return im
    }()
    
    private let thirdResult: UIImageView = {
        let im = UIImageView()
         im.contentMode = .scaleAspectFit
         return im
    }()
    
    private let fourthResult: UIImageView = {
        let im = UIImageView()
         im.contentMode = .scaleAspectFit
         return im
    }()
    
    private let fifthResult: UIImageView = {
        let im = UIImageView()
         im.contentMode = .scaleAspectFit
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
    }
    
    private func setupSubviews() {
        addSubview(firstResult)
        addSubview(secondResult)
        addSubview(thirdResult)
        addSubview(fourthResult)
        addSubview(fifthResult)
    }
    
    private func setupConstraints() {
        firstResult.snp.makeConstraints { make in
            make.size.equalTo(13)
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        secondResult.snp.makeConstraints { make in
            make.size.equalTo(13)
            make.leading.equalTo(firstResult.snp.trailing).offset(4)
            make.centerY.equalToSuperview()
        }
        
        thirdResult.snp.makeConstraints { make in
            make.size.equalTo(13)
            make.leading.equalTo(secondResult.snp.trailing).offset(4)
            make.centerY.equalToSuperview()
        }
        
        fourthResult.snp.makeConstraints { make in
            make.size.equalTo(13)
            make.leading.equalTo(thirdResult.snp.trailing).offset(4)
            make.centerY.equalToSuperview()
        }
        
        fifthResult.snp.makeConstraints { make in
            make.size.equalTo(13)
            make.leading.equalTo(fourthResult.snp.trailing).offset(4)
            make.centerY.equalToSuperview()
        }
    }
    
    public func setupUI(str: String) {
        let im1 = UIImage(named: Resources.Images.MatchResultImage.greenCircle)
        let im2 = UIImage(named: Resources.Images.MatchResultImage.yellowCircle)
        let im3 = UIImage(named: Resources.Images.MatchResultImage.redCircle)
        
        // Перевод строки в массив символов для удобства обработки
        let resultsArray = Array(str)
        
        // Функция для выбора изображения на основе результата
        func image(for result: Character) -> UIImage? {
            switch result {
            case "В":
                return im1
            case "Н":
                return im2
            case "П":
                return im3
            default:
                return nil
            }
        }
        
        // Применение изображений к соответствующим `UIImageView`
        if resultsArray.indices.contains(0) {
            firstResult.image = image(for: resultsArray[0])
        }
        if resultsArray.indices.contains(1) {
            secondResult.image = image(for: resultsArray[1])
        }
        if resultsArray.indices.contains(2) {
            thirdResult.image = image(for: resultsArray[2])
        }
        if resultsArray.indices.contains(3) {
            fourthResult.image = image(for: resultsArray[3])
        }
        if resultsArray.indices.contains(4) {
            fifthResult.image = image(for: resultsArray[4])
        }
    }
}
