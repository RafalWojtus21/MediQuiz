import UIKit
import Foundation
import SwiftUI

class QuestionViewController: UIViewController {

    var questionView = QuestionView()
    override func viewDidLoad() {
        super.viewDidLoad()

        addButtons()
        view = questionView
    }

    private func createButton() -> AnswerButton {
        let button = AnswerButton()
        button.tag = 1
        button.addTarget(self, action: #selector(self.buttonClicked(sender:)), for: .touchUpInside)
        return button
    }
    
    private func addButtons() {
        let numberOfAnswers = 5
        for i in 1...numberOfAnswers {
            let button = createButton()
            button.tag = i
            button.setTitle("\(i)", for: .normal)
            questionView.questionStackView.addArrangedSubview(button)
        }
    }
    
    @objc func buttonClicked(sender: AnswerButton) {
        print("\(sender.tag) button clicked")
    }
    
}
