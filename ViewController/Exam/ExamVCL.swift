//
//  ExamVCL.swift
//  AppTracNhiem
//
//  Created by V000315 on 16/08/2022.
//

import UIKit

class ExamVCL: UIViewController {
    @IBOutlet weak var lbSTTQuestion: UILabel!
    @IBOutlet weak var lbTitleExam: UILabel!
    @IBOutlet weak var btnOkExam: UIButton!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var clvListQuestion: UICollectionView!
    @IBOutlet weak var lbChoice4: UILabel!
    @IBOutlet weak var lbChoice2: UILabel!
    @IBOutlet weak var lbChoice1: UILabel!
    @IBOutlet weak var lbInforQuestion: UILabel!
    @IBOutlet weak var lbChoice3: UILabel!
    
    @IBOutlet weak var viewStop: UIView!
    var numberQuestion: Int = 1{
        didSet{
            setUpQuetions(number: numberQuestion)
            setChoiseAnswer(listAnswerNumber[numberQuestion])
            clvListQuestion.reloadData()
        }
    }
    var countStop = 0
    var count = 600
    var listAnswerNumber : [Int] = []
    var listAnswerText : [String] = []
    var exam: Exam = Exam(title: "", listQuestion: [])
    var titleView : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        lbChoice1.addActionClick(self, action: #selector(clickChoice1(tapGestureRecognizer:)))
        lbChoice2.addActionClick(self, action: #selector(clickChoice2(tapGestureRecognizer:)))
        lbChoice3.addActionClick(self, action: #selector(clickChoice3(tapGestureRecognizer:)))
        lbChoice4.addActionClick(self, action: #selector(clickChoice4(tapGestureRecognizer:)))
        viewStop.isHidden = true
        
        for _ in 1...exam.listQuestion.count {
            listAnswerNumber.append(0)
            listAnswerText.append("")
        }
        lbTitleExam.text = exam.title
        numberQuestion = 0
        
        clvListQuestion.register(UINib(nibName: "QuestionCTVCell", bundle: nil), forCellWithReuseIdentifier: "QuestionCTVCell")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)
        clvListQuestion.collectionViewLayout = layout
        clvListQuestion.delegate = self
        clvListQuestion.dataSource = self
        
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ExamVCL.update), userInfo: nil, repeats: true)

        
    }
    @objc func update() {
        if countStop == 0 {
            if(count > 0) {
                count -= 1
                let min = count / 60
                let secon = count%60
                lbTime.text = "Thời gian thi : \(min):\(secon)"
            } else{
                self.showAlert(title: "Hết giờ !!! Điểm của bạn là ", infor: " \(self.finishExam()) / \(self.exam.listQuestion.count)") {
                    self.dismiss(animated: true)
                }
                
            }
        }
        
    }
    @objc func clickChoice1(tapGestureRecognizer: UITapGestureRecognizer) {
        setChoiseAnswer(1)
    }
    @objc func clickChoice2(tapGestureRecognizer: UITapGestureRecognizer) {
        setChoiseAnswer(2)
    }
    @objc func clickChoice3(tapGestureRecognizer: UITapGestureRecognizer) {
        setChoiseAnswer(3)
    }
    @objc func clickChoice4(tapGestureRecognizer: UITapGestureRecognizer) {
        setChoiseAnswer(4)
    }
    func setUpQuetions(number: Int){
        let question = exam.listQuestion[numberQuestion]
        lbSTTQuestion.text = "Câu hỏi \(numberQuestion + 1) : "
        lbInforQuestion.text = question.question
        lbChoice1.text = question.choise1
        lbChoice2.text = question.choise2
        lbChoice3.text = question.choise3
        lbChoice4.text = question.choise4
    }
    func setChoiseAnswer(_ answer: Int){
        lbChoice4.backgroundColor = .lightGray
        lbChoice2.backgroundColor = .lightGray
        lbChoice3.backgroundColor = .lightGray
        lbChoice1.backgroundColor = .lightGray
        switch (answer){
        case 1 :
            lbChoice1.backgroundColor = .link
            listAnswerNumber[numberQuestion] = 1
            listAnswerText[numberQuestion] = lbChoice1.text!
            break
        case 2 :
            lbChoice2.backgroundColor = .link
            listAnswerNumber[numberQuestion] = 2
            listAnswerText[numberQuestion] = lbChoice2.text!
            break
        case 3 :
            lbChoice3.backgroundColor = .link
            listAnswerNumber[numberQuestion] = 3
            listAnswerText[numberQuestion] = lbChoice3.text!
            break
        case 4 :
            lbChoice4.backgroundColor = .link
            listAnswerNumber[numberQuestion] = 4
            listAnswerText[numberQuestion] = lbChoice4.text!
            break
        default :
            
            break
        }
    }
    
    @IBAction func clickNextQuestion(_ sender: Any) {
        if numberQuestion < exam.listQuestion.count - 1{
            numberQuestion += 1
        }
       
    }
    @IBAction func clickFontQuestion(_ sender: Any) {
        if numberQuestion > 0 {
            numberQuestion -= 1
        }
        
    }
    @IBAction func clickBack(_ sender: Any) {
        self.showAlert(title: "Chú ý", infor: "Bạn có muốn chấm điểm luôn không ?") {
            self.showAlert(title: "Điểm của bạn là ", infor: " \(self.finishExam()) / \(self.exam.listQuestion.count)") {
                self.dismiss(animated: true)
            }
        }
    }
    @IBAction func clickCountinue(_ sender: Any) {
        viewStop.isHidden = true
        count = countStop
        countStop = 0
    }
    @IBAction func clickStop(_ sender: Any) {
        viewStop.isHidden = false
        countStop = count
    }
    func finishExam() -> Int{
        var score = 0
        for i in 0...exam.listQuestion.count - 1{
            if listAnswerText[i] == exam.listQuestion[i].answer {
                score += 1
            }
        }
        return score
    }
    @IBAction func clickOkExam(_ sender: Any) {
        self.showAlert(title: "Chú ý", infor: "Bạn có muốn chấm điểm luôn không ?") {
            self.showAlert(title: "Điểm của bạn là ", infor: " \(self.finishExam()) / \(self.exam.listQuestion.count)") {
                self.dismiss(animated: true)
            }
        }
    }
}

extension ExamVCL : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exam.listQuestion.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = clvListQuestion.dequeueReusableCell(withReuseIdentifier: "QuestionCTVCell", for: indexPath) as? QuestionCTVCell
        cell!.btnNumber.setTitle("\(indexPath.row +  1 )", for: .normal)
        cell?.callback = {
            self.numberQuestion = indexPath.row
        }
        if listAnswerNumber[indexPath.row] != 0 {
            cell?.btnNumber.backgroundColor = .cyan
        } else{
            cell?.btnNumber.backgroundColor = .systemBrown
        }
        return cell!
    }
    
    
}
