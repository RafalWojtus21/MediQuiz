import UIKit

class QuestionView: UIView {
    
    lazy var questionStackView: UIStackView = configureStackView()
    lazy var questionLabel: UILabel = configureTitleLabel()
    var buttons: [UIButton] = []
    
    let currentQuestion = QuizBrain.shared.questionSet[QuizBrain.shared.questionNumber]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addViews()
        addConstaints()
        self.backgroundColor = Constants.darkBlueColor
    }
    
    private func configureStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        stackView.backgroundColor = Constants.backgroundPurpleColor
        return stackView
    }
    
    private func configureTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.text = "Pytanie"
        label.textColor = Constants.mainLabelsColor
        return label
    }
    
    private func setQuestionTitle() {
        questionLabel.text = currentQuestion.question
    }
    
    private func configureButtons() {
        let numberOfAnswers = 5
        for i in 0..<numberOfAnswers {
            let button = AnswerButton()
            button.setTitle(currentQuestion.answers[i].title, for: .normal)
            buttons.append(button)
            questionStackView.addArrangedSubview(button)
        }
    }
    
    private func addViews() {
        setQuestionTitle()
        addSubview(questionLabel)
        addSubview(questionStackView)
        configureButtons()
    }
    
    private func addConstaints() {
        layoutQuestionStackView()
        layoutQuestionLabel()
    }
    
    private func layoutQuestionStackView() {
        questionStackView.translatesAutoresizingMaskIntoConstraints = false
        questionStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20).isActive = true
        questionStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        questionStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        questionStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
    }
    
    private func layoutQuestionLabel() {
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        questionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        questionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
}
