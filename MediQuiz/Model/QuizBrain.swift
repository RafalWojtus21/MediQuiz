import Foundation
import RealmSwift

let realm = try! Realm()

struct QuizBrain {
    
    var questions: Results<Question>?
    var categoriesArray: [String] = []
    var categories: [String] = []
    
    
    var questionSet: [Question] = []
    var buttons: [UIButton] = []
    var chosenCategory: String = ""
    var randomNumbers = Set<Int>()
    var questionNumber = 0
    var currentScore = 0
    
    init() {
        deleteData()
        loadDataFromJSON()
    }
    
    //MARK: - ViewController
    
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
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    //MARK: - QuestionViewController
    
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
    }
    
    func assignAnswersToButtons() {
        for button in buttons {
            button.setTitle("\(questionSet[questionNumber].answers[button.tag].title)", for: .normal)
        }
    }
    
    
    
    
    
}
