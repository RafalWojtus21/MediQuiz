import UIKit
import RealmSwift

class QuestionViewController: UIViewController {
    
    var questionLabel = UILabel()
    var answerStackView = UIStackView()
    
    var questionItems: Results<Item>?
    let realm = try! Realm()
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

    }

    func loadItems() {
        if let questionItems = selectedCategory?.items.sorted(byKeyPath: "question", ascending: true) {
            print(questionItems)
            print("HEJO")
            print(questionItems.randomElement())
            
        }
        configureTitleLabel()
        configureStackView()
    }
    
    func getQuestionText() -> String {
        if let questionItems = selectedCategory?.items.sorted(byKeyPath: "question", ascending: true) {
            return questionItems[0].question
//            print(questionItems[0].question)
        }
        return "jiji"
    }
    
    private func configureStackView(){
        view.addSubview(answerStackView)
        setStackViewConstraints()
        addButtonsToStackView()
        answerStackView.axis = .vertical
        answerStackView.distribution = .fillEqually
        answerStackView.spacing = 2
        answerStackView.backgroundColor = .yellow
    }
    
    func addButtonsToStackView() {
        let numberOfButtons = 5
        
        for i in 1...numberOfButtons {
            let button = AnswerButton()
            button.setTitle("\(i)", for: .normal)
            answerStackView.addArrangedSubview(button)
        }
    }
    
    private func setStackViewConstraints() {
        answerStackView.backgroundColor = .systemMint
        answerStackView.translatesAutoresizingMaskIntoConstraints = false
        answerStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20).isActive = true
        answerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        answerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        answerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    
    private func configureTitleLabel() {
        view.addSubview(questionLabel)
        questionLabel.text = getQuestionText()
        questionLabel.font = UIFont.boldSystemFont(ofSize: 40)
        questionLabel.textAlignment = .center
        questionLabel.numberOfLines = 1
        questionLabel.adjustsFontSizeToFitWidth = true
        questionLabel.textColor = .black
        
        setTitleLabelConstraints()
    }
    
    private func setTitleLabelConstraints() {
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        questionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        questionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
}
