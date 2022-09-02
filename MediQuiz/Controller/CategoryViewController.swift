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
        //                print(Realm.Configuration.defaultConfiguration)
        self.setupNavigationAttributs()
        self.categoryView.setupUI()
        loadData()
        addButtons()
    }
    
    private func setupNavigationAttributs() {
            navigationController?.setNavigationBarHidden(true, animated: true)
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
    
    private func createButton() -> CategoryButton {
        let button = CategoryButton()
        button.tag = 1
        button.addTarget(self, action: #selector(self.startQuiz(sender:)), for: .touchUpInside)
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
                let button = createButton()
                button.tag = iteration
                button.setTitle("\(categories[iteration])", for: .normal)
                buttons.append(button)
                horizontalStackView.addArrangedSubview(button)
                iteration += 1
            }
        }
    }
    
    @objc func startQuiz(sender: CategoryButton) {
        QuizBrain.shared.chosenCategory = sender.currentTitle!
        let questionVC = QuestionViewController()
        if let questionSet = questions {
            let passingResults = questionSet.filter("category CONTAINS[cd] %@", sender.currentTitle!)
            QuizBrain.shared.filterQuestionsFromCategory(category: sender.currentTitle!)
            QuizBrain.shared.drawRandomQuestions()
            //            let passingResults = questionSet.filter({ $0.category.contains(sender.currentTitle!) })
        }
        sender.backgroundColor = Constants.categoryButtonPressedColor
        let delayInSeconds = 0.5
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            sender.backgroundColor = Constants.categoryButtonColor
            self.navigationController?.pushViewController(questionVC, animated: true)
        }
    }
}

