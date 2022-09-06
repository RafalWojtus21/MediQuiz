import Charts
import Foundation

class PieSliceView: PieChartView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPieView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupPieView()
    }
    
    private func setupPieView() {
        chartDescription.enabled = false
        drawHoleEnabled = false
        rotationAngle = 0
        rotationEnabled = false
        isUserInteractionEnabled = false
        legend.enabled = false
        
        var entries: [PieChartDataEntry] = Array()
        let userScore = Double(QuizBrain.shared.getFloatScore())
        entries.append(PieChartDataEntry(value: userScore, label: "\(String(format: "%.2f", userScore))%"))
        entries.append(PieChartDataEntry(value: 100 - userScore, label: "\(String(format: "%.2f", 100-userScore))%"))
        
        let dataSet = PieChartDataSet(entries: entries, label: "")
        dataSet.entryLabelColor = .black
        dataSet.entryLabelFont = UIFont(name: "AvenirNext-DemiBoldItalic", size: 20)
        dataSet.colors = [NSUIColor(hex: Constants.hexCorrectAnswersColor), NSUIColor(hex: Constants.hexWrongAnswersColor)]
        dataSet.drawValuesEnabled = false
        data = PieChartData(dataSet: dataSet)
    }
}
