import UIKit

class CategoryView: UIView {
    
    lazy var categoryStackView: UIStackView = configureStackView()
    lazy var titleLabel: UILabel = configureTitleLabel()

    var buttons: [UIButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addViews()
        addConstaints()
        self.backgroundColor = Constants.darkBlueColor
    }
    
    func configureHorizontalStackView() -> UIStackView {
        let horizontalStackView = UIStackView()
        let purpleColor = UIColor(red: 120/255, green: 88/255, blue: 166/255, alpha: 1)
        horizontalStackView.backgroundColor = purpleColor
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 2
        horizontalStackView.distribution = .fillEqually
        return horizontalStackView
    }
        
    private func addButtons() {
        let numberOfRows = 5
        let numberOfColumns = 2
        for _ in 1...numberOfRows {
            let horizontalStackView = configureHorizontalStackView()
            categoryStackView.addArrangedSubview(horizontalStackView)
            for _ in 1...numberOfColumns {
                let button = CategoryButton()
                buttons.append(button)
                horizontalStackView.addArrangedSubview(button)
            }
        }
    }
    
    private func configureStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        stackView.backgroundColor = Constants.backgroundPurpleColor
        return stackView
    }
    
    private func configureTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.text = "Wybierz kategorię"
        label.textColor = Constants.mainLabelsColor
        return label
    }
    
    private func addViews() {
        addSubview(categoryStackView)
        addSubview(titleLabel)
        addButtons()
    }
    
    private func addConstaints() {
        layoutCategoryStackView()
        layoutTitleLabel()
    }
    
    private func layoutCategoryStackView() {
        categoryStackView.translatesAutoresizingMaskIntoConstraints = false
        categoryStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        categoryStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        categoryStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        categoryStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
    }
    
    private func layoutTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
}
