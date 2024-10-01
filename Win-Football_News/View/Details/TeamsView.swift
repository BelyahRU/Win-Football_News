
import Foundation
import UIKit

class TeamsView: UIView {
    
    private let leftTeamView = UIView()
    private let rightTeamView = UIView()
    
    private var selectedTeam: TeamSide = .none {
        didSet {
            updateColors()
        }
    }

    enum TeamSide {
        case left, right, none
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        layer.cornerRadius = 15
        layer.masksToBounds = true
        
        leftTeamView.layer.cornerRadius = 15
        rightTeamView.layer.cornerRadius = 15
        
        leftTeamView.translatesAutoresizingMaskIntoConstraints = false
        rightTeamView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(leftTeamView)
        addSubview(rightTeamView)
        
        NSLayoutConstraint.activate([
            leftTeamView.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftTeamView.topAnchor.constraint(equalTo: topAnchor),
            leftTeamView.bottomAnchor.constraint(equalTo: bottomAnchor),
            leftTeamView.trailingAnchor.constraint(equalTo: centerXAnchor),
            
            rightTeamView.leadingAnchor.constraint(equalTo: centerXAnchor),
            rightTeamView.topAnchor.constraint(equalTo: topAnchor),
            rightTeamView.bottomAnchor.constraint(equalTo: bottomAnchor),
            rightTeamView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        // Изначально скрываем обе половины
        leftTeamView.backgroundColor = .clear
        rightTeamView.backgroundColor = .clear
    }

    func selectTeam(_ team: TeamSide) {
        selectedTeam = team
    }
    
    private func updateColors() {
        switch selectedTeam {
        case .left:
            leftTeamView.backgroundColor = .blue // Цвет для первой команды
            rightTeamView.backgroundColor = .clear
        case .right:
            leftTeamView.backgroundColor = .clear
            rightTeamView.backgroundColor = .red // Цвет для второй команды
        case .none:
            leftTeamView.backgroundColor = .clear
            rightTeamView.backgroundColor = .clear
        }
    }
}

