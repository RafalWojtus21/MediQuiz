import UIKit
import RealmSwift
import SwiftUI

class ViewController: UIViewController {
    
    let realm = try! Realm()
    var categories: Results<Category>?
    var selectedCategory: Category?
    var titleLabel = UILabel()
    var categoryStackView = UIStackView()
    var helpCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration)
        view.backgroundColor = .systemRed
        title = "Siemanochuj"
        navigationController?.navigationBar.prefersLargeTitles = true
        configureTitleLabel()
        configureStackView()
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
            sender.tag
            buttonID = getButtonID(text: text)
            let results = realm.objects(Category.self).filter("name = '\(text)'")
            //            print("Button id is \(buttonID)")
            for index in getRandomNumbers(n: 5) {
                //                print("Random results \(results[0].items[index])")
            }
        }
        
        let questionVC = QuestionViewController()
        //        questionVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(questionVC, animated: true)
        //        self.present(questionVC, animated: true)
        print("BUTTON ID IS HEJ \(buttonID)")
        questionVC.selectedCategory = categories?[0]
        
    }
    
    func getRandomNumbers(n:Int) -> [Int] {
        var randomNumbers: [Int] = []
        
        for _ in 0...n-1 {
            let randomInt = Int.random(in: 0...1)
            randomNumbers.append(randomInt)
        }
        return randomNumbers
    }
    
    func getButtonID(text: String) -> Int {
        var buttonID = 0
        if text.contains("Pediatria") {
            buttonID = 0
        } else if text.contains("Chirurgia") {
            buttonID = 1
        } else if text.contains("Położnictwo") {
            buttonID = 2
        } else if text.contains("Medycyna rodzinna") {
            buttonID = 3
        } else if text.contains("Psychiatria") {
            buttonID = 4
        } else if text.contains("Medycyna ratunkowa") {
            buttonID = 5
        } else if text.contains("Bioetyka") {
            buttonID = 6
        } else if text.contains("Orzecnictwo") {
            buttonID = 7
        } else if text.contains("Zdrowie publiczne") {
            buttonID = 8
        } else if text.contains("Choroby wewnętrzne") {
            buttonID = 9
        } else {
            print("Wrong buttonID")
        }
        return buttonID
    }
    
    private func configureStackView(){
        view.addSubview(categoryStackView)
        setStackViewConstraints()
        categoryStackView.axis = .vertical
        categoryStackView.distribution = .fillEqually
        categoryStackView.spacing = 2
        addStackViewsToStackView()
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

