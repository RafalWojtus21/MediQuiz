import UIKit
import RealmSwift
import SwiftUI

class ViewController: UIViewController {
    
    let realm = try! Realm()
    var categories: Results<Category>?
    var questions: Results<Question>?
    var selectedCategory: Category?
    var titleLabel = UILabel()
    var categoryStackView = UIStackView()
    var helpCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Realm.Configuration.defaultConfiguration)
        view.backgroundColor = .systemRed
        title = "Wybór kategorii"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureTitleLabel()
        configureStackView()
 
        deleteData()
        
        let data = DataLoader().questionModel
        
        for object in data {
            print(object)
            let newQuestion = Question()
            newQuestion.question = object.question
            newQuestion.category = object.category
            
            for answers in object.answers {
                let newAnswer = Answer()
                newAnswer.title = answers.title
                newAnswer.id = answers.id
                newQuestion.answers.append(newAnswer)
            }
            self.saveData(question: newQuestion)
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
    
    func loadData() {
        questions = realm.objects(Question.self)
    }
    
    private func addStackViewsToStackView() {
        let numberOfRows = 5
        let numberOfColumns = 2
        for i in 1...numberOfRows {
            let stackView = HorizontalStackView()
            categoryStackView.addArrangedSubview(stackView)
            for k in 1...numberOfColumns {
                let button = CategoryButton()
                button.tag = helpCount
                categories = realm.objects(Category.self)
                if let categories = categories {
                    button.setTitle("\(categories[helpCount].name)", for: .normal)
                    button.index = helpCount
                }
                button.addTarget(self, action: #selector(self.buttonClicked(sender:)), for: .touchUpInside)
                stackView.addArrangedSubview(button)
                helpCount += 1
            }
        }
    }
    
    @objc func buttonClicked(sender: CategoryButton) {
        var buttonID: Int = 0
        if let text = sender.titleLabel!.text {
            buttonID = sender.tag
            let results = realm.objects(Category.self).filter("name = '\(text)'")
            //            print("Button id is \(buttonID)")
            for index in getRandomNumbers(n: 5) {
                //                print("Random results \(results[0].items[index])")
            }
        }
        let questionVC = QuestionViewController()
        self.navigationController?.pushViewController(questionVC, animated: true)
        print("BUTTON ID IS HEJ \(buttonID)")
        questionVC.selectedCategory = categories?[buttonID]
        
    }
    
    func getRandomNumbers(n:Int) -> [Int] {
        var randomNumbers: [Int] = []
        
        for _ in 0...n-1 {
            let randomInt = Int.random(in: 0...1)
            randomNumbers.append(randomInt)
        }
        return randomNumbers
    }
    
    
    private func configureStackView(){
        view.addSubview(categoryStackView)
        setStackViewConstraints()
        categoryStackView.axis = .vertical
        categoryStackView.distribution = .fillEqually
        categoryStackView.spacing = 2
//        addStackViewsToStackView()
    }
    
    private func setStackViewConstraints() {
        categoryStackView.backgroundColor = .systemMint
        categoryStackView.translatesAutoresizingMaskIntoConstraints = false
        categoryStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        categoryStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        categoryStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        categoryStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
    }
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        //        titleLabel.text = "Wybierz kategorię"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 40)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textColor = .white
        setTitleLabelConstraints()
    }
    
    private func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

