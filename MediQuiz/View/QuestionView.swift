import Foundation
import UIKit

class QuestionView: UIView {
    
    lazy var questionStackView: UIStackView = configureStackView()
    lazy var questionLabel: UILabel = configureTitleLabel()
    
    convenience init() {
        self.init(frame: .zero)
        let darkBlueColor = UIColor(red: 61/255, green: 44/255, blue: 141/255, alpha: 1)
        backgroundColor = darkBlueColor
        addViews()
        addConstaints()
    }

    private func configureStackView() -> UIStackView {
        let stackView = UIStackView()
        let purpleColor = UIColor(red: 120/255, green: 88/255, blue: 166/255, alpha: 1)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        stackView.backgroundColor = purpleColor
        return stackView
    }
    
    private func configureTitleLabel() -> UILabel {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 40)
            label.textAlignment = .center
            label.numberOfLines = 1
            label.adjustsFontSizeToFitWidth = true
            label.textColor = .white
            let labelColor = UIColor(red: 143/255, green: 227/255, blue: 207/255, alpha: 1)
            label.text = "Pytanie"
            label.textColor = labelColor
            return label
    }
    
    private func addViews() {
        addSubview(questionStackView)
        addSubview(questionLabel)
    }
    
    private func addConstaints() {
        layoutQuestionStackView()
        layoutQuestionLabel()
    }
    
    private func layoutQuestionStackView() {
        questionStackView.translatesAutoresizingMaskIntoConstraints = false
        questionStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20).isActive = true
        questionStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        questionStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        questionStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
    }
    
    private func layoutQuestionLabel() {
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        questionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        questionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
