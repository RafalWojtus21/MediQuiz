import UIKit

struct Constants {
    static let darkBlueColor = UIColor(red: 22/255, green: 33/255, blue: 62/255, alpha: 1)
    static let backgroundPurpleColor = UIColor(red: 83/255, green: 52/255, blue: 131/255, alpha: 1)
    static let mainLabelsColor = UIColor(red: 143/255, green: 227/255, blue: 207/255, alpha: 1)
    static let categoryButtonColor = UIColor.black
    static let categoryButtonPressedColor = UIColor(red: 100/255, green: 111/255, blue: 212/255, alpha: 1)
    static let answerButtonColor = UIColor.black
    static let correctAnswerButtonColor = UIColor(red: 61/255, green: 240/255, blue: 97/255, alpha: 1)
    static let wrongAnswerButtonColor = UIColor(red: 220/255, green: 61/255, blue: 97/255, alpha: 1)
    static let answerButtonFontColor = UIColor.systemMint
    static let answerButtonCheckFontColor = UIColor.black
    static let fontName = "AvenirNext-DemiBoldItalic"
    static let hexCorrectAnswersColor = 0xe5FD068
    static let hexWrongAnswersColor = 0xF77E21
    static let backToCategoriesButtonColor = UIColor(red: 20/255, green: 30/255, blue: 150/255, alpha: 1)
    static let backToCategoriesButtonFontColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
    
    
    enum UserDefaultKeys: String {
       case questionCount
        case isAppAlreadyLaunchedOnce
    }
    
}
