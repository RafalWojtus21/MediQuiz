import UIKit
import SwiftUI
import RealmSwift

class QuestionViewController: UIViewController {
    
    let realm = try! Realm()
    
    private var questionView: QuestionView { return view as! QuestionView }
    private var buttons: [UIButton] = []
    
    override func loadView() {
        view = QuestionView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        title = QuizBrain.shared.chosenCategory
        self.questionView.setupUI()
        setupNavigationAttributes()
        configureAnswerButtons()
    }
    
    private func setupNavigationAttributes() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    private func updateQuestionData() {
        updateQuestionLabel()
        updateButtonLabels()
    }
    
    private func configureAnswerButtons() {
        questionView.buttons.enumerated().forEach { index, button in
            button.addTarget(self, action: #selector(self.onPressAnswerChosen(sender:)), for: .touchUpInside)
            button.tag = index + 1
            buttons = questionView.buttons
        }
    }
    
    private func updateQuestionLabel() {
        questionView.questionLabel.text = QuizBrain.shared.questionSet[QuizBrain.shared.questionNumber].question
    }
    
    private func updateButtonLabels() {
        questionView.buttons.enumerated().forEach { index, button in
            button.setTitle(QuizBrain.shared.questionSet[QuizBrain.shared.questionNumber].answers[index].title, for: .normal)
            buttons = questionView.buttons
        }
    }
    
    private func updateUI() {
        if QuizBrain.shared.isQuizOver {
            let resultVC = ResultViewController()
            self.navigationController?.pushViewController(resultVC, animated: true)
        } else {
            buttons.forEach { button in
                button.isEnabled = true
            }
            self.updateQuestionData()
        }
    }
    
    @objc func onPressAnswerChosen(sender: AnswerButton) {
        QuizBrain.shared.checkAnswer(buttonsArray: buttons ,index: sender.tag, button: sender)
        QuizBrain.shared.resetHighlightedAnswers(buttonsArray: self.buttons) { [weak self] in
            guard let self = self else { return }
            QuizBrain.shared.nextQuestion()
            self.updateUI()
        }
    }
}
