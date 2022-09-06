import Foundation
import RealmSwift

class Answer: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    var parentCategory = LinkingObjects(fromType: Question.self, property: "answers")
}
