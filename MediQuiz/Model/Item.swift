import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var question: String = ""
    @objc dynamic var firstAnswer: String = ""
    @objc dynamic var secondAnswer: String = ""
    @objc dynamic var thirdAnswer: String = ""
    @objc dynamic var fourthAnswer: String = ""
    @objc dynamic var fifthAnswer: String = ""
    @objc dynamic var correctAnswer: Int = 0
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
