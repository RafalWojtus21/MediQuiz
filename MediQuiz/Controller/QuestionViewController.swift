import UIKit
import Foundation
import SwiftUI
import RealmSwift

class QuestionViewController: UIViewController {
    
    let realm = try! Realm()
    var quizBrain: QuizBrain?
    var quizLogic = QuizLogic()
    
    var questionView = QuestionView()
    var questions: Results<Question>? {
        didSet {
            loadData()
        }
    }
    var chosenCategory: String = ""
    
    var questionSet: [Question] = []
    let numberOfQuestions = 2
    var randomNumbers = Set<Int>()
    var questionNumber = 0
    var currentScore = 0
    var buttons: [UIButton] = []
    var testSet: [Question] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = chosenCategory
        navigationController?.navigationBar.tintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        view = questionView
        
        drawRandomQuestions()
        addButtons()
        configureView()
    }
    
    func loadData() {
        quizLogic.questions = questions
        quizLogic.chosenCategory = chosenCategory
    }
    
    private func configureView() {
        assignQuestionToLabel()
        assignAnswersToButtons()
    }
    private func nextQuestion() {
        if questionNumber + 1 < questionSet.count {
            questionNumber += 1
        } else {
            print("koniec quizu")
            let resultVC = ResultViewController()
            self.navigationController?.pushViewController(resultVC, animated: true)
            var dataToPass: [Int] = []
            dataToPass.append(currentScore)
            dataToPass.append(numberOfQuestions)
            resultVC.scoreCalculation = dataToPass
        }
    }
    
    private func checkAnswer(index: Int, button: UIButton) -> Bool{
        let correctAnswerId = questionSet[questionNumber].correct_answer_id
        button.setTitleColor(Constants.answerButtonCheckFontColor, for: .normal)
        if index == correctAnswerId {
            button.backgroundColor = Constants.correctAnswerButtonColor
            currentScore += 1
            return true
        } else {
            buttons[correctAnswerId].backgroundColor = Constants.correctAnswerButtonColor
            button.backgroundColor = Constants.wrongAnswerButtonColor
            buttons[correctAnswerId].setTitleColor(Constants.answerButtonCheckFontColor, for: .normal)
            return false
        }
    }
    
    func getProgress() -> Float {
        let progress = Float(questionNumber+1)/Float(questionSet.count)
        return progress
    }
    
    private func updateUI() {
        assignQuestionToLabel()
        assignAnswersToButtons()
    }
    private func assignQuestionToLabel() {
        questionView.questionLabel.text = questionSet[questionNumber].question
    }
    
    private func assignAnswersToButtons() {
        for button in buttons {
            button.setTitle("\(questionSet[questionNumber].answers[button.tag].title)", for: .normal)
        }
    }
    
    private func configureButtonLabel(index: Int) -> String {
        let data = questionSet[questionNumber].answers[index].title
        return data
    }
    
    private func drawRandomQuestions() -> [Question]? {
        if let questions = questions {
            let questionIndexes = getRandomInts()
            for k in questionIndexes {
                questionSet.append(questions[k])
            }
            return questionSet
        }
        return nil
    }
    
    private func getRandomInts() -> [Int] {
        while randomNumbers.count < numberOfQuestions {
            let randomInt = Int.random(in: 0...1)
            randomNumbers.insert(randomInt)
        }
        return randomNumbers.sorted()
    }
    
    private func createButton() -> AnswerButton {
        let button = AnswerButton()
        button.tag = 1
        button.addTarget(self, action: #selector(self.buttonClicked(sender:)), for: .touchUpInside)
        return button
    }
    
    private func addButtons() {
        let numberOfAnswers = 5
        for i in 0..<numberOfAnswers {
            let button = createButton()
            button.tag = i
            buttons.append(button)
            questionView.questionStackView.addArrangedSubview(button)
        }
    }
    
    @objc func buttonClicked(sender: AnswerButton) {
        checkAnswer(index: sender.tag, button: sender)
        let delayInSeconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            self.buttons.forEach { button in
                button.backgroundColor = Constants.answerButtonColor
                button.setTitleColor(Constants.answerButtonFontColor, for: .normal)
            }
            self.nextQuestion()
            self.updateUI()
        }
    }
}
