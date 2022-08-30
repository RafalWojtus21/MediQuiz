import Foundation
import RealmSwift

class Question: Object {
    @objc dynamic var category: String = ""
    @objc dynamic var question: String = ""
    @objc dynamic var correct_answer_id: Int = 0
    let answers = List<Answer>()
}
