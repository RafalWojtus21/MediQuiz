import Foundation
import UIKit

class CategoryButton: UIButton {

    var index: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    
    func setupButton() {
        setTitleColor(.white, for: .normal)
        backgroundColor = .black
        titleLabel?.font = UIFont(name: "AvenirNext-DemiBoldItalic", size: 20)
        titleLabel?.numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.textAlignment = .center
        layer.cornerRadius = 10
        
    }
}
