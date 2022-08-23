//
//  HomeVCL.swift
//  AppTracNhiem
//
//  Created by V000315 on 16/08/2022.
//

import UIKit

class HomeVCL: UIViewController {
    
    @IBOutlet weak var btnExam: UIButton!
    @IBOutlet weak var tbvListExam: UITableView!
    @IBOutlet weak var lbTenNguoiDung: UILabel!
    
    var numberChoise = -1
    var user : User = User(userName: "", uid: "")
    var listExam: [Exam] = []
    var didSelectExam: Exam = Exam(title: "", listQuestion: [])
    override func viewDidLoad() {
        super.viewDidLoad()
        tbvListExam.register(UINib(nibName: String(describing: DeThiTBVCell.self), bundle: nil),
                             forCellReuseIdentifier: String(describing: DeThiTBVCell.self))
        tbvListExam.delegate = self
        tbvListExam.dataSource = self
        lbTenNguoiDung.text = user.userName
        // Get data exam
        FireBase.firebase.getQuestions { [weak self] data in
            DispatchQueue.main.async {
                if let data = data {
                    self?.listExam = data
                    self?.tbvListExam.reloadData()
                }
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    @IBAction func clickExam(_ sender: Any) {
        if numberChoise > 0  {
            self.pushView(storybard: UIStoryboard(name: "Main", bundle: nil), nextView: ExamVCL.self) { view  in
                view.exam = self.didSelectExam
                view.user = self.user
            }
        }
        
    }
    
    
}
extension HomeVCL : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listExam.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbvListExam.dequeueReusableCell(withIdentifier: "DeThiTBVCell", for: indexPath) as! DeThiTBVCell
        if indexPath.row == numberChoise {
            cell.imageback.isHighlighted = true
        } else {
            cell.imageback.isHighlighted = false
        }
        cell.lbTileExam.text = listExam[indexPath.row].title
        cell.lbTime.text = "10:00"
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectExam = listExam[indexPath.row]
        numberChoise = indexPath.row
        tbvListExam.reloadData()
    }
    
}
