import Foundation
import UIKit

class ResultView: UIView {
    
    lazy var resultStackView: UIStackView = configureStackView()
    lazy var titleLabel: UILabel = configureTitleLabel()
    lazy var progressBar: CAShapeLayer = configureCircularProgressBar(view: topStackView)
    lazy var backgroundCircle: CAShapeLayer = configureBackgroundCircle(view: topStackView)
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
    
    func configureCircularPath(score: Float) -> UIBezierPath {
        let path = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi * CGFloat(score), clockwise: true)
        return path
    }
    
    func configureBackgroundCircle(view: UIStackView) -> CAShapeLayer {
        let path = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi, clockwise: true)
        let trackLayer = CAShapeLayer()
        let center = view.center
        trackLayer.path = path.cgPath
        trackLayer.strokeColor = UIColor.darkGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        return trackLayer
    }
    
    func configureCircularProgressBar(view: UIStackView) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi/2, endAngle: -CGFloat.pi/2 + (2 * CGFloat.pi * CGFloat(QuizBrain.shared.getScore())), clockwise: true)
        let center = view.center
        
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        
        switch finalScore {
        case 0..<40:
            shapeLayer.strokeColor = UIColor.red.cgColor
        case 40..<60:
            shapeLayer.strokeColor = UIColor.orange.cgColor
        case 60..<80:
            shapeLayer.strokeColor = UIColor.yellow.cgColor
        case 80...100:
            shapeLayer.strokeColor = UIColor.green.cgColor
        default:
            shapeLayer.strokeColor = UIColor.gray.cgColor
        }
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.fillMode = .forwards
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
        return shapeLayer
    }
    
    private func configureStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        stackView.backgroundColor = .clear
        return stackView
    }
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = topPadding
        return stackView
    }()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = topPadding
        return stackView
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
    
    private lazy var backToCategoriesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("BACK BUTTON", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .purple
        button.addTarget(self, action: #selector(onPressBacktoCategories), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func onPressBacktoCategories(_ sender: UIButton) {
        pushCategoriesVC?(sender)
        self.window?.rootViewController?.dismiss(animated: true, completion: nil)
        print("button pressed")
    }
    
    private func addViews() {
        addSubview(titleLabel)
        addSubview(resultStackView)
        resultStackView.layer.addSublayer(backgroundCircle)
        resultStackView.layer.addSublayer(progressBar)
//        topStackView.layer.addSublayer(backgroundCircle)
//        topStackView.layer.addSublayer(progressBar)
//        resultStackView.addArrangedSubview(topStackView)
//        resultStackView.addArrangedSubview(bottomStackView)
//        bottomStackView.addArrangedSubview(backToCategoriesButton)
    }
    
    private func addConstaints() {
        layoutTitleLabel()
        layoutResultStackView()
    }
    
    private func layoutResultStackView() {
        resultStackView.translatesAutoresizingMaskIntoConstraints = false
        resultStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        resultStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        resultStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        resultStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
//        resultStackView.heightAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    private func layoutTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
