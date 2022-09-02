import Foundation
import RealmSwift

let realm = try! Realm()

struct QuizBrain {
    
    static var shared = QuizBrain()
    
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
    var finalResultsToPass: [Int] = []
    
    private init() {
        isAppAlreadyLaunchedOnce()
        checkIfNewQuestionsAdded()
    }
    //MARK: - QuestionViewController
    
    mutating func checkAnswer(buttonsArray: [UIButton],index: Int, button: UIButton) -> Bool {
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

    func getProgress() -> Float {
        let progress = Float(questionNumber+1)/Float(questionSet.count)
        return progress
    }
    
    func getScore() -> Float {
        let finalScore = Float(currentScore)/Float(questionSet.count) 
        return finalScore
    }
    
    mutating func nextQuestion() -> Bool {
        if questionNumber + 1 < questionSet.count {
            questionNumber += 1
            isQuizOver = false
        } else {
            finalResultsToPass.append(currentScore)
            finalResultsToPass.append(numberOfQuestions)
            isQuizOver = true
        }
        return isQuizOver
    }
    
    mutating func drawRandomQuestions() -> [Question]? {
        if let passingQuestions = passingQuestions {
            let questionIndexes = getRandomInts()
            for k in questionIndexes {
                questionSet.append(passingQuestions[k])
            }
            print(questionSet)
            return questionSet
        }
        return nil
    }
    
    private mutating func getRandomInts() -> [Int] {
        while randomNumbers.count < numberOfQuestions {
            let randomInt = Int.random(in: 0...passingQuestions!.count-1)
            randomNumbers.insert(randomInt)
        }
        print(randomNumbers)
        return randomNumbers.sorted()
    }
    
    func assignQuestionToLabel(label: UILabel) {
        label.text = questionSet[questionNumber].question
    }
    
    func assignAnswersToButtons(buttonsArray: [UIButton]) {
        for button in buttonsArray {
            button.setTitle("\(questionSet[questionNumber].answers[button.tag].title)", for: .normal)
        }
    }
    
    //MARK: - CategoryViewController
    
    func isAppAlreadyLaunchedOnce() -> Bool {
            let defaults = UserDefaults.standard
            if defaults.bool(forKey: "isAppAlreadyLaunchedOnce") {
                return true
            } else {
                defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
                loadDataFromJSON()
                return false
            }
        }
    
    mutating func checkIfNewQuestionsAdded() {
        let defaults = UserDefaults.standard
        readData()
        if isAppAlreadyLaunchedOnce() {
            if defaults.integer(forKey: "questionCount") != questions?.count {
                loadDataFromJSON()
            } else {
                defaults.set(questions?.count, forKey: "questionCount")
            }
        } else {
            print("No questions added")
        }
    }
    
    mutating func getCategoriesNames() -> [String] {
        if let objects = readData() {
            for question in objects {
                categoriesArray.append(question.category)
            }
            categories = Array(Set(categoriesArray))
        }
        return categories
    }
    
    func loadDataFromJSON() {
        let data = DataLoader().questionModel
        addDatatoRealmObject(data: data)
    }
    
    func addDatatoRealmObject(data: [QuestionModel]) {
        for object in data {
            let newQuestion = Question()
            newQuestion.question = object.question
            newQuestion.category = object.category
            newQuestion.correct_answer_id = object.correct_answer_id
            for answers in object.answers {
                let newAnswer = Answer()
                newAnswer.title = answers.title
                newAnswer.id = answers.id
                newQuestion.answers.append(newAnswer)
            }
            self.saveDataToRealm(question: newQuestion)
        }
    }
    
    func saveDataToRealm(question: Question) {
        do {
            try realm.write {
                realm.add(question)
            }
        } catch {
            print("Error saving question \(error)")
        }
    }
    
    mutating func readData() -> Results<Question>? {
        questions = realm.objects(Question.self)
        if let questions = questions {
            return questions
        }
        return nil
    }
    
    func deleteData() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("Error deleting data from Realm")
        }
    }
    
    mutating func filterQuestionsFromCategory(category: String) -> Results<Question>? {
        if let questions = questions {
            passingQuestions = questions.filter("category CONTAINS[cd] %@", category)
        }
        return passingQuestions
    }
}

