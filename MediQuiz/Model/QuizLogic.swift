import Foundation
import RealmSwift

struct QuizLogic {
    var questions: Results<Question>?
    var chosenCategory: String = ""
    
    var questionSet: [Question] = []
    var buttons: [UIButton] = []
    var randomNumbers = Set<Int>()
    var questionNumber = 0
    var currentScore = 0
    var testSet: [Question] = []
    
    init() {
    }
    
    private mutating func drawRandomQuestions() -> [Question]? {
        if let questions = questions {
            let questionIndexes = getRandomInts()
            for k in questionIndexes {
                questionSet.append(questions[k])
            }
            return questionSet
        }
        return nil
    }
    
    private mutating func getRandomInts() -> [Int] {
        let numberOfQuestions = 2
        while randomNumbers.count < numberOfQuestions {
            let randomInt = Int.random(in: 0...1)
            randomNumbers.insert(randomInt)
        }
        return randomNumbers.sorted()
    }
    
    func assignQuestionToLabel(label: UILabel) {
        label.text = questionSet[questionNumber].question
        print(questionSet)
    }
}
