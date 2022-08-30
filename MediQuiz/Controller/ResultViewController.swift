import UIKit

class ResultViewController: UIViewController {

    var scoreCalculation : [Int] = [] {
        didSet {
            calculateScore()
        }
    }
    var score: Int = 0
    var totalNumberOfQuestions: Int = 0
    var finalScore: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.darkBlueColor
    }
    
    func calculateScore() {
        score = scoreCalculation[0]
        totalNumberOfQuestions = scoreCalculation[1]

        finalScore = Float(score)/Float(totalNumberOfQuestions)*100
        print("Your final score is \(finalScore) %")
    }
    
}
