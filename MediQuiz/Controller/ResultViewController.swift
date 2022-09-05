import UIKit

class ResultViewController: UIViewController {

    let finalScore = QuizBrain.shared.getScore()
    private var resultView: ResultView { return view as! ResultView }
    
    override func loadView() {
        view = ResultView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationAttributes()
        self.resultView.setupUI()
    }
    
    private func setupNavigationAttributes() {
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
}
