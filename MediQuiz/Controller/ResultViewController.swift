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
        configureBackButton()
    }
    
    private func setupNavigationAttributes() {
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    private func configureBackButton() {
        resultView.backToCategoriesButton.addTarget(self, action: #selector(onPressBacktoCategories(_:)), for: .touchUpInside)
    }
    
    @objc private func onPressBacktoCategories(_ sender: UIButton) {
        QuizBrain.shared.resetValues()
        navigationController?.popToRootViewController(animated: true)
    }
    
}
