import UIKit
import RealmSwift
import SwiftUI

class CategoryViewController: UIViewController {
    
    private var categoryView: CategoryView { return view as! CategoryView }
    
    override func loadView() {
        view = CategoryView(frame: UIScreen.main.bounds)
    }
    
    let realm = try! Realm()
    
    var categories: [String] = []
    var buttons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        self.setupNavigationAttributs()
        self.categoryView.setupUI()
        configureCategoryButtons()
    }
    
    private func setupNavigationAttributs() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func loadData() {
        categories = QuizBrain.shared.getCategoriesNames()
    }
    
    private func configureCategoryButtons() {
        categoryView.buttons.enumerated().forEach { index, button in
            button.addTarget(self, action: #selector(self.onPressStartQuiz(sender:)), for: .touchUpInside)
            button.setTitle("\(categories[index])", for: .normal)
            button.tag = index
        }
    }
    
    @objc func onPressStartQuiz(sender: CategoryButton) {
        let chosenCategory = sender.currentTitle!
        QuizBrain.shared.chosenCategory = chosenCategory
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

