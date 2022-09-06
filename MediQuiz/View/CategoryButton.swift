import UIKit

class CategoryButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    func setupButton() {
        let buttonColor = UIColor(red: 209/255, green: 81/255, blue: 45/255, alpha: 1)
        setTitleColor(.white, for: .normal)
        backgroundColor = Constants.categoryButtonColor
        titleLabel?.font = UIFont(name: "AvenirNext-DemiBoldItalic", size: 20)
        titleLabel?.numberOfLines = 0
        setTitleColor(.systemMint, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.textAlignment = .center
        layer.cornerRadius = 10
    }
}
