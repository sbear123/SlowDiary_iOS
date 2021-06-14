//
//  ReadViewController.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/06/14.
//

import UIKit

class ReadViewController: UIViewController {

    @IBOutlet var dateL: UILabel!
    @IBOutlet var feelImage: UIImageView!
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
    
    let uVM: UserViewModel = UserViewModel.shared
    let wVM: WriteViewModel = WriteViewModel.shared
    let pVM: PictureViewModel = PictureViewModel.shared
    var pic: [Picture] = []
    var write: Write = Write()
    var date: String = ""
    
    @IBAction func pageChanged(_ sender: UIPageControl) {
        let indexPath = IndexPath(item: sender.currentPage, section: 0)
        PicCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PicCollectionView.decelerationRate = .normal
        PicCollectionView.dataSource = self
        PicCollectionView.delegate = self
        PicCollectionView.isPagingEnabled = true
        
        pager.numberOfPages = pic.count
        pager.currentPage = 0
        
        drawView()
    }
    
    @IBAction func back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func drawView() {
        let dateArr: [Int] = date.split(separator: ".").map({Int(String($0))!})
        dateL.text = "\(dateArr[1])/\(dateArr[2])"
        print(write)
        if write.id == nil { return }
        self.feelImage.image = UIImage(named: write.feel!+".png")
        self.titleL.text = write.title!
        self.satisP.progress = Float(write.satisfaction!) / 100
        self.satisL.text = "\(write.satisfaction!)%"
        self.goalL.text = write.goal
        self.refleL.text = write.reflection
        self.praiseL.text = write.praise
        self.updateContent(arr: self.wVM.getContents(text: write.content!))
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
    
}
extension ReadViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //총 page 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pic.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PicCell", for: indexPath) as?
                PicViewCell else {
            return UICollectionViewCell()
        }
        let data = pic[indexPath.item]
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

extension ReadViewController: UIScrollViewDelegate {
    
    //수동으로 넘을 때 page를 인식
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let w = scrollView.bounds.size.width
        pager.currentPage = Int(ceil(x/w))
    }
    
}
