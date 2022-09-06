import UIKit
import RealmSwift

class ResultView: UIView {
    
    lazy var resultStackView: UIStackView = configureStackView()
    lazy var titleLabel: UILabel = configureTitleLabel()
    let darkBlueColor = Constants.darkBlueColor
    var finalScore = QuizBrain.shared.getFloatScore() * 100
    
    private var topPadding: CGFloat = 15
    private var bottomPadding: CGFloat = -15
    private var leftPadding: CGFloat = 15
    private var rightPadding: CGFloat = -15
    private var fontSize: CGFloat = -15
    
    public var pushCategoriesVC: ((_ sender: UIButton?) -> Void)?
    
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
    
    private func configureStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 2
        stackView.backgroundColor = .clear
        return stackView
    }
    
    
    private func configureTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.text = "Twój wynik to \(QuizBrain.shared.returnScoreString())% "
        label.textColor = Constants.mainLabelsColor
        return label
    }
    
    lazy var backToCategoriesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Spróbuj ponownie", for: .normal)
        button.setTitleColor(Constants.backToCategoriesButtonFontColor, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.fontName, size: 30)
        button.titleLabel?.font = .boldSystemFont(ofSize: 30)
        button.backgroundColor = Constants.backToCategoriesButtonColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 30
        return button
    }()
    
    private func addViews() {
        addSubview(resultStackView)
        addSubview(titleLabel)
        addSubview(backToCategoriesButton)
        let pieView = PieSliceView()
        resultStackView.addArrangedSubview(pieView)
    }
    
    private func addConstaints() {
        layoutTitleLabel()
        layoutBackButton()
        layoutResultStackView()
    }
    
    private func layoutBackButton() {
        backToCategoriesButton.translatesAutoresizingMaskIntoConstraints = false
        backToCategoriesButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        backToCategoriesButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        backToCategoriesButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        backToCategoriesButton.heightAnchor.constraint(equalToConstant: 100).isActive = true    }
    
    private func layoutResultStackView() {
        resultStackView.translatesAutoresizingMaskIntoConstraints = false
        resultStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50).isActive = true
        resultStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        resultStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        resultStackView.bottomAnchor.constraint(equalTo: backToCategoriesButton.topAnchor, constant: -20).isActive = true
        //        resultStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func layoutTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
