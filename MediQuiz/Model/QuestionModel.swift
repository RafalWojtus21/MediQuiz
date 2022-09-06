import Foundation

struct QuestionModel: Codable {
    let answers: [Answers]
    let question: String
    let category: String
    let correct_answer_id: Int
}

struct Answers: Codable {
    let id: Int
    let title: String
}
