import UIKit

class TeamSelectionView: UIView {

    // Создаем кнопки для домашней и гостевой команды
    public let homeTeamButton: UIButton = {
        let button = UIButton()
        button.setTitle("Home Team", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    public let awayTeamButton: UIButton = {
        let button = UIButton()
        button.setTitle("Away Team", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(.black, for: .normal)
        return button
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

    // Инициализация кастомной вьюшки
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        // Настраиваем основной контейнер с заданными размерами и скругленными углами
        self.layer.cornerRadius = 30 / 2
        self.layer.masksToBounds = true
        self.backgroundColor = .white
        // Создаем стек вью, чтобы держать обе кнопки
        let stackView = UIStackView(arrangedSubviews: [homeTeamButton, awayTeamButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0

        // Добавляем стек вью на нашу кастомную вьюшку
        self.addSubview(stackView)

        // Устанавливаем авто-лейаут ограничения для стека
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        // Задаем начальный стиль кнопок
        styleButtons(isHomeSelected: true)
        
        self.addSubview(logo1ImageView)
        self.addSubview(logo2ImageView)
        
        logo1ImageView.snp.makeConstraints { make in
            make.size.equalTo(23)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(3)
        }
        
        logo2ImageView.snp.makeConstraints { make in
            make.size.equalTo(23)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-3)
        }
        
    }

    // Функция для обновления стилей кнопок в зависимости от выбранной команды
    public func styleButtons(isHomeSelected: Bool) {
        if isHomeSelected {
            homeTeamButton.backgroundColor = Resources.Colors.darkBlueColor
            awayTeamButton.backgroundColor = UIColor.clear
            homeTeamButton.setTitleColor(.white, for: .normal)
            awayTeamButton.setTitleColor(.black, for: .normal)
        } else {
            homeTeamButton.backgroundColor = UIColor.clear
            awayTeamButton.backgroundColor = Resources.Colors.darkBlueColor
            homeTeamButton.setTitleColor(.black, for: .normal)
            awayTeamButton.setTitleColor(.white, for: .normal)
        }
    }
}
