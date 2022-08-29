import UIKit
import Foundation
import SwiftUI
import RealmSwift

class QuestionViewController: UIViewController {

    let realm = try! Realm()
    
    var questionView = QuestionView()
    var questions: Results<Question>?
//    var questionSet: Results<Question>?
    var questionSet: [Question] = []
    var randomNumbers = Set<Int>()
    var questionNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addButtons()
        view = questionView
        drawRandomQuestions()
        assignQuestionToLabel()

//        getButton1Label()
    }
    
    private func nextQuestion() {
        if questionNumber + 1 < questionSet.count {
            questionNumber += 1
        } else {
            print("koniec quizu")
        }
    }
    
    private func assignQuestionToLabel() {
        questionView.questionLabel.text = questionSet[questionNumber].question
    }
    
    private func getButton1Label() -> String {
        let data = questionSet[questionNumber].answers[0].title
        print(data)
        return data
    }
    
//    private func getButton1Label(button: UIButton) -> String {
//        let buttonLabel = questionSet[questionNumber].answers[0].title
//        return buttonLabel
//    }
    

    
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
        let numberOfQuestions = 10
        while randomNumbers.count < numberOfQuestions {
            let randomInt = Int.random(in: 0...19)
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
        for i in 1...numberOfAnswers {
            let button = createButton()
            button.tag = i
//            let buttonLabel = getButton1Label()
//            print(buttonLabel)
//            button.setTitle("\(getButton1Label())", for: .normal)
            button.setTitle("\(i)", for: .normal)
            questionView.questionStackView.addArrangedSubview(button)
        }
    }
    
    @objc func buttonClicked(sender: AnswerButton) {
        print("\(sender.currentTitle) button clicked")
//        nextQuestion()
    }
    
}
