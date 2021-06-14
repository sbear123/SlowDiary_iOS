//
//  TodayViewController.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/05/17.
//

import UIKit
import Floaty

class TodayViewController: UIViewController {

    @IBOutlet var dateL: UILabel!
    @IBOutlet var feelImage: UIImageView!
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var titleL: UILabel!
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
    @IBOutlet var satisP: UIProgressView!
    @IBOutlet var satisL: UILabel!
    @IBOutlet var goalL: UILabel!
    @IBOutlet var praiseL: UILabel!
    @IBOutlet var refleL: UILabel!
    @IBOutlet var PicCollectionView: UICollectionView!
    @IBOutlet var pager: UIPageControl!
    @IBOutlet var floatyB: Floaty!
    
    @IBAction func pageChanged(_ sender: UIPageControl) {
        let indexPath = IndexPath(item: sender.currentPage, section: 0)
        PicCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func morePic(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showPicture", sender: self.pVM.todayPic)
    }
    
    @IBAction func moreWrite(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showContent", sender: self.writeVM.today)
    }
    
    let pVM: PictureViewModel = PictureViewModel.shared
    let uVM: UserViewModel = UserViewModel.shared
    let writeVM: WriteViewModel = WriteViewModel.shared
    let weatherVM: WeatherViewModel = WeatherViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PicCollectionView.decelerationRate = .normal
        PicCollectionView.dataSource = self
        PicCollectionView.delegate = self
        PicCollectionView.isPagingEnabled = true
        
        pager.numberOfPages = pVM.cntData()
        pager.currentPage = 0
        
        if floatyB.items.count < 2 {
            floatyB.addItem(icon: UIImage(systemName: "pencil"), handler: {_ in
                self.performSegue(withIdentifier: "showWrite", sender: self.writeVM.today)
            })
            floatyB.addItem(icon: UIImage(systemName: "camera"), handler: {_ in
                self.performSegue(withIdentifier: "showPicture", sender: self)
            })
            
            self.view.addSubview(floatyB)
        }
        
        drawView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        drawView()
        PicCollectionView.reloadData()
        pager.numberOfPages = pVM.cntData()
    }
    
    func drawView() {
        writeVM.getTodayWrite() { today in
            if today.id == nil { return }
            self.feelImage.image = UIImage(named: today.feel!+".png")
            self.titleL.text = today.title!
            self.satisP.progress = Float(today.satisfaction!) / 100
            self.satisL.text = "\(today.satisfaction!)%"
            self.goalL.text = today.goal
            self.refleL.text = today.reflection
            self.praiseL.text = today.praise
            self.updateContent(arr: self.writeVM.getContents(text: today.content ?? ""))
        }
        weatherImage.image = UIImage(systemName: weatherVM.GetWeather(at: 1).conditionName)
        dateL.text = GetToday(format: "MM/dd")
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showContent" {
            let vc = segue.destination as? ContentViewController
            if let w = sender as? Write {
                vc?.write = w
                vc?.bottomView = self
            }
        }
        else if segue.identifier == "showWrite" {
            let vc = segue.destination as? WriteViewController
            if let write = sender as? Write {
                vc?.write = write
                let year = Int(GetToday(format: "yyyy"))
                let month = Int(GetToday(format: "MM"))
                let date = Int(GetToday(format: "dd"))
                vc?.date = DateModel(id: uVM.getUserData().id!, year: year, month: month, date: date)
                vc?.feel = write.feel ?? "happy"
                vc?.satisfaction = write.satisfaction ?? 100
                vc?.bottomView = self
                if self.pVM.todayPic.count == 0 {
                    vc?.pics = self.pVM.defaultPic
                }
                else {
                    vc?.pics = self.pVM.todayPic
                }
                
            }
        }
        else if segue.identifier == "showPicture" {
            let vc = segue.destination as? UpdatePictureViewController
            if self.pVM.todayPic.count == 0 {
                vc?.pics = self.pVM.defaultPic
                vc?.bottomTodayView = self
            }
            else {
                vc?.pics = self.pVM.todayPic
                vc?.bottomTodayView = self
            }
        }
    }
    
}

extension TodayViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //총 page 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pVM.cntData() == 0 ? 1: pVM.cntData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PicCell", for: indexPath) as?
                PicViewCell else {
            return UICollectionViewCell()
        }
        if pVM.cntData() != 0 {
            let data = pVM.getData(indexPath.item)
            cell.update(data: data)
        }
        else {
            cell.update(data: pVM.defaultPic[0])
        }
        
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

extension TodayViewController: UIScrollViewDelegate {
    
    //수동으로 넘을 때 page를 인식
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let w = scrollView.bounds.size.width
        pager.currentPage = Int(ceil(x/w))
    }
    
}
