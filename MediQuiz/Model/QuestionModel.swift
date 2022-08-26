import Foundation

struct QuestionModel: Codable {
    let answers: [Answers]
    let question: String
    let category: String
}

struct Answers: Codable {
    let id: Int
    let title: String
}
