import UIKit
import ProgressHUD
import RealmSwift

class ResultView: UIView {
    
    lazy var resultStackView: UIStackView = configureStackView()
    lazy var titleLabel: UILabel = configureTitleLabel()
    let darkBlueColor = Constants.darkBlueColor
    var finalScore = QuizBrain.shared.getScore() * 100
    
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
    
    private lazy var showProgressView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var progressBar: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.trackTintColor = .red
        progressView.progressTintColor = .blue
        progressView.setProgress(0.5, animated: true)
        return progressView
    }()
    
    private func configureTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        let finalScoreString = String(format: "%.2f",finalScore)
        label.text = "Twój wynik to \(finalScoreString)% "
        label.textColor = Constants.mainLabelsColor
        return label
    }
    
    lazy var backToCategoriesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Spróbuj ponownie", for: .normal)
        button.setTitleColor(Constants.categoryButtonColor, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.fontName, size: 30)
        button.titleLabel?.font = .boldSystemFont(ofSize: 30)
        button.backgroundColor = .systemMint
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 30
        return button
    }()
    
    private func addViews() {
        addSubview(titleLabel)
        addSubview(backToCategoriesButton)
        addSubview(showProgressView)
        showProgressView.addSubview(progressBar)
    }
    
    private func addConstaints() {
        layoutTitleLabel()
        layoutBackButton()
        layoutProgressView()
        layoutProgressBar()
    }
    
    private func layoutProgressView() {
        showProgressView.translatesAutoresizingMaskIntoConstraints = false
        showProgressView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50).isActive = true
        showProgressView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        showProgressView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        showProgressView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    
    private func layoutProgressBar() {
        progressBar.frame = CGRect(x: showProgressView.frame.minX, y: showProgressView.frame.size.height/2 , width: 100, height: 30)
    }
    
    private func layoutBackButton() {
        backToCategoriesButton.translatesAutoresizingMaskIntoConstraints = false
        backToCategoriesButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        backToCategoriesButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        backToCategoriesButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        backToCategoriesButton.heightAnchor.constraint(equalToConstant: 100).isActive = true    }
    
    private func layoutResultStackView() {
        resultStackView.backgroundColor = .yellow
        resultStackView.translatesAutoresizingMaskIntoConstraints = false
        resultStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50).isActive = true
        resultStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        resultStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        resultStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
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
