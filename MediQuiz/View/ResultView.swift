import Foundation
import UIKit

class ResultView: UIView {
    
    lazy var resultStackView: UIStackView = configureStackView()
    lazy var titleLabel: UILabel = configureTitleLabel()
    lazy var progressBar: CAShapeLayer = configureCircularProgressBar()
    lazy var backgroundCircle: CAShapeLayer = configureBackgroundCircle()
    
    let darkBlueColor = Constants.darkBlueColor
    
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
    
    func configureBackgroundCircle() -> CAShapeLayer {
        let path = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi, clockwise: true)
        let trackLayer = CAShapeLayer()
        let center = center
        trackLayer.path = path.cgPath
        trackLayer.strokeColor = UIColor.darkGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        return trackLayer
    }
    
    func configureCircularProgressBar() -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi * CGFloat(QuizBrain.shared.getScore()), clockwise: true)
        let center = center
        
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 4
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
        return shapeLayer
    }
    
    private func configureStackView() -> UIStackView {
        let stackView = UIStackView()
        let purpleColor = UIColor(red: 120/255, green: 88/255, blue: 166/255, alpha: 1)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        stackView.backgroundColor = .clear
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
        label.text = "Twój wynik: "
        label.textColor = labelColor
        return label
    }
    
    private func addViews() {
        addSubview(resultStackView)
        resultStackView.layer.addSublayer(backgroundCircle)
        resultStackView.layer.addSublayer(progressBar)
        addSubview(titleLabel)
    }
    
    private func addConstaints() {
        layoutCategoryStackView()
        layoutTitleLabel()
    }
    
    private func layoutCategoryStackView() {
        resultStackView.translatesAutoresizingMaskIntoConstraints = false
        resultStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        resultStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        resultStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        resultStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
    }
    
    private func layoutTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
