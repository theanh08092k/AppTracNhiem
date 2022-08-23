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
    @IBOutlet weak var lbInforQuestion: UILabel!
    
    @IBOutlet weak var btnChoise4: UIButton!
    @IBOutlet weak var btnChoise3: UIButton!
    @IBOutlet weak var btnChoise2: UIButton!
    @IBOutlet weak var btnChoise1: UIButton!
    @IBOutlet weak var viewStop: UIView!
    var numberQuestion: Int = 0{
        didSet{
            setUpQuetions(number: numberQuestion)
            setChoiseAnswer(listAnswerNumber[numberQuestion])
            clvListQuestion.reloadData()
        }
    }
    var countStop = 0
    var count = 600
    var listAnswerNumber : [Int] = []{
        didSet{
            clvListQuestion.reloadData()
        }
    }
    var listAnswerText : [String] = []
    var exam: Exam = Exam(title: "", listQuestion: [])
    var user: User = User(userName: "", uid: "")
    var titleView : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        viewStop.isHidden = true
        
        for _ in 1...exam.listQuestion.count {
            listAnswerNumber.append(0)
            listAnswerText.append("")
        }
        lbTitleExam.text = exam.title
        numberQuestion = 0
        
        clvListQuestion.register(UINib(nibName: "QuestionCTVCell", bundle: nil), forCellWithReuseIdentifier: "QuestionCTVCell")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.scrollDirection = .horizontal
        clvListQuestion.collectionViewLayout = layout
        clvListQuestion.delegate = self
        clvListQuestion.dataSource = self
        
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ExamVCL.update), userInfo: nil, repeats: true)
        
        btnChoise1.setContrainLabel(-10, 10, 20, 10)
        btnChoise2.setContrainLabel(-10, 10, 20, 10)
        btnChoise3.setContrainLabel(-10, 10, 20, 10)
        btnChoise4.setContrainLabel(-10, 10, 20, 10)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeRight.direction = .right
            self.view.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeLeft.direction = .left
            self.view.addGestureRecognizer(swipeLeft)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                if numberQuestion > 0 {
                    numberQuestion -= 1
                }
            case .left:
                if numberQuestion < exam.listQuestion.count - 1{
                    numberQuestion += 1
                }
            default:
                break
            }
        }
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
                    self.navigationController?.popViewController(animated: true)
                }
                
            }
        }
        
    }
    
    @IBAction func clickD(_ sender: Any) {
        setChoiseAnswer(4)
    }
    @IBAction func clickC(_ sender: Any) {
        setChoiseAnswer(3)
    }
    @IBAction func clickB(_ sender: Any) {
        setChoiseAnswer(2)
    }
    @IBAction func clickA(_ sender: Any) {
        setChoiseAnswer(1)
    }
    func setUpQuetions(number: Int){
        let question = exam.listQuestion[numberQuestion]
        lbSTTQuestion.text = "Câu hỏi \(numberQuestion + 1) : "
        lbInforQuestion.text = question.question
        btnChoise1.setTitle(question.choise1, for: .normal)
        btnChoise2.setTitle(question.choise2, for: .normal)
        btnChoise3.setTitle(question.choise3, for: .normal)
        btnChoise4.setTitle(question.choise4, for: .normal)
        
        
    }
    func setChoiseAnswer(_ answer: Int){
        let image = UIImage(named: "unchoisAns.png")
        btnChoise1.setBackgroundImage(image, for:  UIControl.State.normal)
        btnChoise2.setBackgroundImage(image, for:  UIControl.State.normal)
        btnChoise3.setBackgroundImage(image, for:  UIControl.State.normal)
        btnChoise4.setBackgroundImage(image, for:  UIControl.State.normal)
    
        switch (answer){
        case 1 :
            btnChoise1.setBackgroundImage(UIImage(named: "choiceAns" ), for: .normal)
            listAnswerNumber[numberQuestion] = 1
            listAnswerText[numberQuestion] = btnChoise1.title(for: .normal) ?? ""
        case 2 :
            btnChoise2.setBackgroundImage(UIImage(named: "choiceAns"), for: .normal)
            listAnswerNumber[numberQuestion] = 2
            listAnswerText[numberQuestion] = btnChoise2.title(for: .normal) ?? ""
        case 3 :
            btnChoise3.setBackgroundImage(UIImage(named: "choiceAns"), for: .normal)
            listAnswerNumber[numberQuestion] = 3
            listAnswerText[numberQuestion] = btnChoise3.title(for: .normal) ?? ""
        case 4 :
            btnChoise4.setBackgroundImage(UIImage(named: "choiceAns"), for: .normal)
            listAnswerNumber[numberQuestion] = 4
            listAnswerText[numberQuestion] = btnChoise4.title(for: .normal) ?? ""
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
                self.navigationController?.popViewController(animated: true)
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
        FireBase.firebase.addHistory(user: user, history: History(topic: exam.title, playDate: self.getTimeNow(), score: score, time: 600 - count))
        return score
    }
    @IBAction func clickOkExam(_ sender: Any) {
        self.showAlert(title: "Chú ý", infor: "Bạn có muốn chấm điểm luôn không ?") {
            self.showAlert(title: "Điểm của bạn là ", infor: " \(self.finishExam()) / \(self.exam.listQuestion.count)") {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

extension ExamVCL : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exam.listQuestion.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = clvListQuestion.dequeueReusableCell(withReuseIdentifier: "QuestionCTVCell", for: indexPath) as? QuestionCTVCell {
            if indexPath.row == numberQuestion {
                cell.btnNumber.setTitleColor(.link, for: .normal)
            } else {
                cell.btnNumber.setTitleColor(.white, for: .normal)
            }
            cell.btnNumber.setTitle("\(indexPath.row +  1 )", for: .normal)
            cell.callback = {
                self.numberQuestion = indexPath.row
            }
            if listAnswerNumber[indexPath.row] != 0 {
                cell.btnNumber.backgroundColor = .systemRed
            } else{
                cell.btnNumber.backgroundColor = .darkGray
            }
            return cell
        }
        return UICollectionViewCell()
        
    }
    
    
}
