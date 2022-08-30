import UIKit
import RealmSwift
import SwiftUI

class ViewController: UIViewController {
    
    var mainView = MainView()
    
    let realm = try! Realm()
    var questions: Results<Question>?
    
    var categoriesArray: [String] = []
    var categories: [String] = []
    var buttons: [UIButton] = []
    override func viewDidLoad() {
        super.viewDidLoad()
//                print(Realm.Configuration.defaultConfiguration)
//                title = "Wybór kategorii"
        //        navigationController?.navigationBar.prefersLargeTitles = true
        deleteData()
        loadDataFromJSON()
        readData()
//        print(readData())
        addButtons()
        view = mainView
    }
    
    private func readData() -> Results<Question>? {
        questions = realm.objects(Question.self)
        if let questions = questions {
            return questions
            }
        return nil
        }
        
    private func getCategoriesNames() -> [String] {
        if let objects = readData() {
            for question in objects {
                categoriesArray.append(question.category)
            }
            categories = Array(Set(categoriesArray))
        }
        return categories
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
        button.addTarget(self, action: #selector(self.buttonClicked(sender:)), for: .touchUpInside)
        return button
    }
    
    private func addButtons() {
        let numberOfRows = 5
        let numberOfColumns = 2
        var iteration = 0
        getCategoriesNames()
        for i in 1...numberOfRows {
            let horizontalStackView = configureHorizontalStackView()
            mainView.categoryStackView.addArrangedSubview(horizontalStackView)
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
    
    @objc func buttonClicked(sender: CategoryButton) {
        let questionVC = QuestionViewController()
        self.navigationController?.pushViewController(questionVC, animated: true)
        print(sender.currentTitle!)
        if let questionSet = questions {
            let passingResults = questionSet.filter("category CONTAINS[cd] %@", sender.currentTitle!)
//            let passingResults = questionSet.filter({ $0.category.contains(sender.currentTitle!) })
            questionVC.questions = passingResults
            questionVC.chosenCategory = sender.currentTitle!
        }
        
    }
    
    private func deleteData() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    private func saveData(question: Question) {
        do {
            try realm.write {
                realm.add(question)
            }
        } catch {
            print("Error saving question \(error)")
        }
    }
        
    func loadDataFromJSON() {
        let data = DataLoader().questionModel
        addDatatoRealm(data: data)
    }
    
    func addDatatoRealm(data: [QuestionModel]) {
        for object in data {
            let newQuestion = Question()
            newQuestion.question = object.question
            newQuestion.category = object.category
            newQuestion.correct_answer_id = object.correct_answer_id
            for answers in object.answers {
                let newAnswer = Answer()
                newAnswer.title = answers.title
                newAnswer.id = answers.id
                newQuestion.answers.append(newAnswer)
            }
            self.saveData(question: newQuestion)
        }
    }
}

