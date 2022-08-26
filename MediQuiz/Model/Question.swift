import Foundation
import RealmSwift

class Question: Object {
    @objc dynamic var category: String = ""
    @objc dynamic var question: String = ""
    let answers = List<Answer>()
}
