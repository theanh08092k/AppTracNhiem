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
    
    var textNameUser: String = ""
    var listExam: [Exam] = []
    var didSelectExam: Exam = Exam(title: "", listQuestion: [])
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbvListExam.register(UINib(nibName: String(describing: DeThiTBVCell.self), bundle: nil),
                             forCellReuseIdentifier: String(describing: DeThiTBVCell.self))
        tbvListExam.delegate = self
        tbvListExam.dataSource = self
        lbTenNguoiDung.text = textNameUser
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
    
    @IBAction func clickExam(_ sender: Any) {
        let nextView = ExamVCL(nibName: "ExamVCL", bundle: nil)
        nextView.exam = didSelectExam
        nextView.modalPresentationStyle = .fullScreen
        present(nextView, animated: true)
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
        cell.lbTileExam.text = listExam[indexPath.row].title
        cell.lbTime.text = "10:00"
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectExam = listExam[indexPath.row]
    }
    
}
