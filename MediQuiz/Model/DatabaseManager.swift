import Foundation
import RealmSwift

class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    var questions: Results<Question>?
    
    private init() {}
    
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
    
    private func saveDataToRealm(question: Question) {
        do {
            try realm.write {
                realm.add(question)
            }
        } catch {
            print("Error saving question \(error)")
        }
    }
    
    func readData() -> Results<Question>? {
        questions = realm.objects(Question.self)
        if let questions = questions {
            QuizBrain.shared.questions = questions
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
}
