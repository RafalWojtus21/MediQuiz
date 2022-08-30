//import Foundation
//import UIKit
//
//struct QuizBrain {
//
//    var questionNumber = 0
//    var currentScore = 0
//    var questionSet: [Question] = []
//
//
//    mutating func nextQuestion(controller: UIViewController) {
//        if questionNumber + 1 < questionSet.count {
//            questionNumber += 1
//            updateUI()
//        } else {
//            print("koniec quizu")
//            let resultVC = ResultViewController()
//            controller.navigationController?.pushViewController(resultVC, animated: true)
//        }
//    }
//
//    func updateUI() {
//        assignQuestionToLabel()
//        getButton1Label()
//    }
//    func assignQuestionToLabel() {
//        questionView.questionLabel.text = questionSet[questionNumber].question
//    }
//
//    func getButton1Label() -> String {
//        let data = questionSet[questionNumber].answers[0].title
//        return data
//    }
//
//    func drawRandomQuestions() -> [Question]? {
//        if let questions = questions {
//            let questionIndexes = getRandomInts()
//            for k in questionIndexes {
//                questionSet.append(questions[k])
//            }
//            return questionSet
//        }
//        return nil
//    }
//
//    func getRandomInts() -> [Int] {
//        let numberOfQuestions = 7
//        while randomNumbers.count < numberOfQuestions {
//            let randomInt = Int.random(in: 0...19)
//            randomNumbers.insert(randomInt)
//        }
//        return randomNumbers.sorted()
//    }
//
//
//
//}
