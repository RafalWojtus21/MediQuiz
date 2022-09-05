import UIKit
import Foundation
import SwiftUI
import RealmSwift

class QuestionViewController: UIViewController {
    
    private var questionView: QuestionView { return view as! QuestionView }
    
    override func loadView() {
        view = QuestionView(frame: UIScreen.main.bounds)
    }
    
    let realm = try! Realm()
    
    var questionNumber = QuizBrain.shared.questionNumber
    var buttons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        title = QuizBrain.shared.chosenCategory
        self.questionView.setupUI()
        setupNavigationAttributes()
        configureView()
    }
    
    private func setupNavigationAttributes() {

        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    private func configureView() {
        addButtons()
        QuizBrain.shared.assignQuestionToLabel(label: questionView.questionLabel)
        QuizBrain.shared.assignAnswersToButtons(buttonsArray: buttons)
    }
    
    private func updateUI() {
        QuizBrain.shared.assignQuestionToLabel(label: questionView.questionLabel)
        QuizBrain.shared.assignAnswersToButtons(buttonsArray: buttons)
    }
    
    private func configureButtonLabel(index: Int) -> String {
        let data = QuizBrain.shared.questionSet[questionNumber].answers[index].title
        return data
    }
    
    private func createButton(with index: Int) -> AnswerButton {
        let button = AnswerButton()
        button.tag = index
        button.addTarget(self, action: #selector(self.onPressAnswerChosen(sender:)), for: .touchUpInside)
        return button
    }
    
    private func addButtons() {
        let numberOfAnswers = 5
        for i in 0..<numberOfAnswers {
            let button = createButton(with: i)
            buttons.append(button)
            questionView.questionStackView.addArrangedSubview(button)
        }
    }
    
    @objc func onPressAnswerChosen(sender: AnswerButton) {
        QuizBrain.shared.checkAnswer(buttonsArray: buttons ,index: sender.tag, button: sender)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            self.buttons.forEach { button in
                button.backgroundColor = Constants.answerButtonColor
                button.setTitleColor(Constants.answerButtonFontColor, for: .normal)
            }
            QuizBrain.shared.nextQuestion()
            if QuizBrain.shared.isQuizOver == true {
                let resultVC = ResultViewController()
                self.navigationController?.pushViewController(resultVC, animated: true)
            } else {
                self.updateUI()
            }
        }
    }
}
