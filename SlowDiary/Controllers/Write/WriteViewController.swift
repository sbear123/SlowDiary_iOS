//
//  WriteViewController.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/06/01.
//

import UIKit

class WriteViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var dateL: UILabel!
    @IBOutlet weak var feelB: UIButton!
    @IBOutlet weak var feelImg: UIImageView!
    @IBOutlet weak var titleF: UITextField!
    @IBOutlet var content1: UILabel!
    @IBOutlet var content2: UILabel!
    @IBOutlet var content3: UILabel!
    @IBOutlet var content4: UILabel!
    @IBOutlet var content5: UILabel!
    @IBOutlet var content6: UILabel!
    @IBOutlet var content7: UILabel!
    @IBOutlet var content8: UILabel!
    @IBOutlet var content9: UILabel!
    @IBOutlet var content10: UILabel!
    @IBOutlet var content11: UILabel!
    @IBOutlet var content12: UILabel!
    @IBOutlet weak var updateWriteB: UIButton!
    @IBOutlet weak var satisS: UISlider!
    @IBOutlet weak var satisL: UILabel!
    @IBOutlet weak var goalF: UITextField!
    @IBOutlet weak var praiseF: UITextField!
    @IBOutlet weak var refleF: UITextField!
    @IBOutlet weak var PicCollectionView: UICollectionView!
    @IBOutlet weak var pager: UIPageControl!
    
    @IBAction func pageChanged(_ sender: UIPageControl) {
        let indexPath = IndexPath(item: sender.currentPage, section: 0)
        PicCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func finishWrite(_ sender: Any) {
        if titleF.text == "" {
            let alert = UIAlertController(title: "제목이 없습니다.", message: "제목을 입력하세요.", preferredStyle: .alert)
            var okAction : UIAlertAction
            okAction = UIAlertAction(title: "OK", style: .default, handler : nil)
            alert.addAction(okAction)
            present(alert, animated: false, completion: nil)
            return
        }
        write.title = titleF.text
        write.feel = feel
        write.praise = praiseF.text
        write.reflection = refleF.text
        write.satisfaction = satisfaction
        write.goal = goalF.text
        if isUpdate {
            writeVM.updateWrite(write: write){
                if self.bottomView != nil {
                    self.bottomView?.drawView()
                }
            }
        } else {
            writeVM.createWrite(write: write)
        }
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func updateContent(_ sender: Any) {
        self.performSegue(withIdentifier: "showContent", sender: write)
    }
    
    @IBAction func updatePic(_ sender: Any) {
        self.performSegue(withIdentifier: "showPic", sender: self)
    }
    @IBAction func updateFeel(_ sender: Any) {
        makeAlert(title: "기분을 선택해주세요!", msg: "")
    }
    
    let pVM: PictureViewModel = PictureViewModel.shared
    let writeVM: WriteViewModel = WriteViewModel.shared
    let uVM: UserViewModel = UserViewModel.shared
    var write: Write = Write()
    var feel: String = ""
    var satisfaction: Int = 0
    var date: DateModel = DateModel()
    var pics: [Picture] = []
    var bottomView: TodayViewController?
    var isUpdate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PicCollectionView.decelerationRate = .normal
        PicCollectionView.dataSource = self
        PicCollectionView.delegate = self
        PicCollectionView.isPagingEnabled = true
        
        pager.numberOfPages = pics.count
        pager.currentPage = 0
        if write.id != nil {
            drawView(w: write)
        }
        else {
            writeVM.getWirte(date: date) { wr in
                if wr.id == nil { return }
                self.write = wr
                self.drawView(w: wr)
                self.feel = wr.feel!
                self.satisfaction = wr.satisfaction!
                self.isUpdate = true
            }
        }
        isUpdate = write.id != nil
        goalF.delegate = self
        titleF.delegate = self
        praiseF.delegate = self
        refleF.delegate = self
        dateL.text = "\(date.month!)/\(date.date!)"
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.touch))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        scrollView.addGestureRecognizer(recognizer)
        
    }
    
    @objc func touch() {
        self.view.endEditing(true)
    }
    
    func reloadPics() {
        PicCollectionView.reloadData()
        pager.numberOfPages = pics.count
    }
    
    func drawView(w:Write) {
        self.feelImg.image = UIImage(named: w.feel!+".png")
        self.titleF.text = w.title!
        self.satisS.value = Float(w.satisfaction!)
        self.satisL.text = "\(w.satisfaction!)%"
        self.goalF.text = w.goal
        self.refleF.text = w.reflection
        self.praiseF.text = w.praise
        self.updateContent(arr: self.writeVM.getContents(text: w.content ?? ""))
    }
    
    func updateContent(arr: [String]) {
        content1.text = arr[0]
        content2.text = arr[1]
        content3.text = arr[2]
        content4.text = arr[3]
        content5.text = arr[4]
        content6.text = arr[5]
        content7.text = arr[6]
        content8.text = arr[7]
        content9.text = arr[8]
        content10.text = arr[9]
        content11.text = arr[10]
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let current = Int(sender.value)
        satisL.text = "\(current)%"
        satisfaction = current
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showContent" {
            let vc = segue.destination as? UpdateContentViewController
            if let w = sender as? Write {
                vc?.write = w
                vc?.bottomWriteView = self
            }
        }
        else if segue.identifier == "showPic" {
            let vc = segue.destination as? UpdatePictureViewController
            vc?.bottomWriteView = self
            vc?.pics = self.pics
        }
    }
    
    func makeAlert(title: String, msg: String) -> Void {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.actionSheet)
        var happy: UIAlertAction
        var sad: UIAlertAction
        var soso: UIAlertAction
        var angry: UIAlertAction
        var cancel: UIAlertAction
        happy = UIAlertAction(title: "행복", style: .default, handler : {_ in
            self.feel = "happy"
            self.feelImg.image = UIImage(named: "\(self.feel).png")
        })
        sad = UIAlertAction(title: "슬픔", style: .default, handler : {_ in
            self.feel = "sad"
            self.feelImg.image = UIImage(named: "\(self.feel).png")
        })
        soso = UIAlertAction(title: "그저그럼", style: .default, handler : {_ in
            self.feel = "soso"
            self.feelImg.image = UIImage(named: "\(self.feel).png")
        })
        angry = UIAlertAction(title: "화남", style: .default, handler : {_ in
            self.feel = "angry"
            self.feelImg.image = UIImage(named: "\(self.feel).png")
        })
        cancel = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        alert.addAction(happy)
        alert.addAction(sad)
        alert.addAction(soso)
        alert.addAction(angry)
        alert.addAction(cancel)
        present(alert, animated: false, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}

extension WriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //총 page 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PicCell", for: indexPath) as?
                PicViewCell else {
            return UICollectionViewCell()
        }
        let data = pics[indexPath.item]
        cell.update(data: data)
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
}

extension WriteViewController: UIScrollViewDelegate {
    
    //수동으로 넘을 때 page를 인식
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let w = scrollView.bounds.size.width
        pager.currentPage = Int(ceil(x/w))
    }
    
}
