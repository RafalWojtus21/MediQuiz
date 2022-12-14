import UIKit

class AnswerButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    func setupButton() {
        backgroundColor = Constants.answerButtonColor
        titleLabel?.font = UIFont(name: "AvenirNext-DemiBoldItalic", size: 15)
        titleLabel?.numberOfLines = 0
        setTitleColor(Constants.answerButtonFontColor, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.textAlignment = .center
        layer.cornerRadius = 10
    }
}
