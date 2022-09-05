import UIKit
import RealmSwift
import SwiftUI

class CategoryViewController: UIViewController {
    
    private var categoryView: CategoryView { return view as! CategoryView }
    
    override func loadView() {
        view = CategoryView(frame: UIScreen.main.bounds)
    }
    
    let realm = try! Realm()
    
    var questions: Results<Question>?
    var categories: [String] = []
    var buttons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        self.setupNavigationAttributs()
        self.categoryView.setupUI()
        addButtons()
    }
    
    private func setupNavigationAttributs() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func loadData() {
        categories = QuizBrain.shared.getCategoriesNames()
        questions = QuizBrain.shared.questions
    }
    
    func configureHorizontalStackView() -> UIStackView {
        let horizontalStackView = UIStackView()
        let purpleColor = UIColor(red: 120/255, green: 88/255, blue: 166/255, alpha: 1)
        horizontalStackView.backgroundColor = purpleColor
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 2
        horizontalStackView.distribution = .fillEqually
        return horizontalStackView
    }
    
    private func createButton(with index: Int) -> CategoryButton {
        let button = CategoryButton()
        button.tag = index
        button.addTarget(self, action: #selector(self.onPressStartQuiz(sender:)), for: .touchUpInside)
        button.setTitle("\(categories[index])", for: .normal)
        return button
    }
    
    private func addButtons() {
        let numberOfRows = 5
        let numberOfColumns = 2
        var iteration = 0
        for i in 1...numberOfRows {
            let horizontalStackView = configureHorizontalStackView()
            categoryView.categoryStackView.addArrangedSubview(horizontalStackView)
            for k in 1...numberOfColumns {
                let button = createButton(with: iteration)
                buttons.append(button)
                horizontalStackView.addArrangedSubview(button)
                iteration += 1
            }
        }
    }
    
    @objc func onPressStartQuiz(sender: CategoryButton) {
        let chosenCategory = sender.currentTitle!
        QuizBrain.shared.chosenCategory = chosenCategory
        QuizBrain.shared.filterQuestionsFromCategory(category: chosenCategory)
        QuizBrain.shared.drawRandomQuestions()
        sender.backgroundColor = Constants.categoryButtonPressedColor
        let questionVC = QuestionViewController()
        let delayInSeconds = 0.5
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            sender.backgroundColor = Constants.categoryButtonColor
            self.navigationController?.pushViewController(questionVC, animated: true)
        }
    }
}

