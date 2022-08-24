import Foundation
import UIKit

class HorizontalStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupStackView()
    }

    func setupStackView() {
        backgroundColor = .systemMint
        axis = .horizontal
        spacing = 2
        distribution = .fillEqually

    }
    
}
