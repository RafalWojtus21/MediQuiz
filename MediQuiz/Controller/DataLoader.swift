import Foundation

public class DataLoader {
    
    @Published var questionModel = [QuestionModel]()
    
    init() {
        load()
        sort()
    }
    
    func load() {
        if let fileLocation = Bundle.main.url(forResource: "categories_quiz", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([QuestionModel].self, from: data)
                
                self.questionModel = dataFromJson
            } catch {
                print("Error decoding! \(error)")
            }
        }
    }
    
    func sort() {
        self.questionModel = self.questionModel.sorted(by: { $0.category < $1.category })
    }
}
