import Foundation
import RealmSwift

class QuizBrain {
    
    static let shared = QuizBrain()
    
    var questions: Results<Question>?
    var categoriesArray: [String] = []
    var categories: [String] = []
    
    var passingQuestions: Results<Question>?
    var questionSet: [Question] = []
    var buttons: [UIButton] = []
    var chosenCategory: String = ""
    var randomNumbers = Set<Int>()
    var questionNumber = 0
    var currentScore = 0
    var numberOfQuestions = 5
    var isQuizOver: Bool = false
    
    private init() {}
    
    //MARK: - QuestionViewController
    
    func checkAnswer(buttonsArray: [UIButton],index: Int, button: UIButton) -> Bool {
        let correctAnswerId = questionSet[questionNumber].correct_answer_id
        button.setTitleColor(Constants.answerButtonCheckFontColor, for: .normal)
        if index == correctAnswerId {
            button.backgroundColor = Constants.correctAnswerButtonColor
            currentScore += 1
            return true
        } else {
            buttonsArray[correctAnswerId].backgroundColor = Constants.correctAnswerButtonColor
            button.backgroundColor = Constants.wrongAnswerButtonColor
            buttonsArray[correctAnswerId].setTitleColor(Constants.answerButtonCheckFontColor, for: .normal)
            return false
        }
    }
    
    func resetHighlightedAnswers(buttonsArray: [UIButton], completion: @escaping () -> ()) {
        buttonsArray.forEach { button in
            button.isEnabled = false
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.5) {
            buttonsArray.forEach { button in
                button.backgroundColor = Constants.answerButtonColor
                button.setTitleColor(Constants.answerButtonFontColor, for: .normal)
            }
            completion()
        }
    }
    
    func resetValues() {
        questionSet = []
        questionNumber = 0
        currentScore = 0
    }
    
    func getProgress() -> Float {
        guard questionSet.count != 0 else { return 0 }
        return Float(questionNumber+1)/Float(questionSet.count)
    }
    
    func getFloatScore() -> Float {
        guard questionSet.count != 0 else { return 0 }
        return Float(currentScore)/Float(questionSet.count)*100
    }
    
    func returnScoreString() -> String {
        "\(currentScore) z \(numberOfQuestions)"
    }
    
    func nextQuestion() -> Bool {
        if questionNumber + 1 < questionSet.count {
            questionNumber += 1
            isQuizOver = false
        } else {
            isQuizOver = true
        }
        return isQuizOver
    }
    
    private func filterQuestionsFromCategory() -> Results<Question>? {
        if let questions = questions {
            passingQuestions = questions.filter("category CONTAINS[cd] %@", chosenCategory)
        }
        return passingQuestions
    }
    
    func drawRandomQuestions() -> [Question]? {
        filterQuestionsFromCategory()
        if let passingQuestions = passingQuestions {
            let questionIndexes = getRandomInts()
            for k in questionIndexes {
                questionSet.append(passingQuestions[k])
            }
            return questionSet
        }
        return nil
    }
    
    private func getRandomInts() -> [Int] {
        while randomNumbers.count < numberOfQuestions {
            let randomInt = Int.random(in: 0...passingQuestions!.count-1)
            randomNumbers.insert(randomInt)
        }
        return Array(randomNumbers)
    }
    
    //MARK: - CategoryViewController
    
    func getCategoriesNames() -> [String] {
        if let objects = DatabaseManager.shared.readData() {
            for question in objects {
                categoriesArray.append(question.category)
            }
            categories = Array(Set(categoriesArray))
        }
        return categories.sorted()
    }   
}

