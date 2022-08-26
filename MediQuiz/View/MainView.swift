import Foundation
import UIKit

class MainView: UIView {
    
    var categoriesNames: [String]?

    convenience init() {
        self.init(frame: .zero)
        backgroundColor = .red
        addViews()
        addConstaints()
    }
    func printCategories() {
        print(categoriesNames ?? "No categories")
    }

    private func configureStackView() -> UIStackView{
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        stackView.backgroundColor = .systemMint
        return stackView
    }
    
    private func configureTitleLabel() -> UILabel{
            let label = UILabel()
            label.text = "Wybierz kategorię"
            label.font = UIFont.boldSystemFont(ofSize: 40)
            label.textAlignment = .center
            label.numberOfLines = 1
            label.adjustsFontSizeToFitWidth = true
            label.textColor = .white
            return label
    }
    
    private lazy var categoryStackView: UIStackView = configureStackView()
    private lazy var titleLabel: UILabel = configureTitleLabel()
    
    
    private func addViews() {
        addSubview(categoryStackView)
        addSubview(titleLabel)
    }
    
    private func addConstaints() {
        categoryStackView.translatesAutoresizingMaskIntoConstraints = false
        categoryStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        categoryStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        categoryStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        categoryStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
