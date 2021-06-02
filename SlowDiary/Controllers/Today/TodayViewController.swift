//
//  TodayViewController.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/05/17.
//

import UIKit

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
    @IBOutlet var complimentL: UILabel!
    @IBOutlet var regretL: UILabel!
    @IBOutlet var PicCollectionView: UICollectionView!
    @IBOutlet var pager: UIPageControl!
    
    @IBAction func pageChanged(_ sender: UIPageControl) {
        let indexPath = IndexPath(item: sender.currentPage, section: 0)
        PicCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func morePic(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showPicture", sender: self)
    }
    
    @IBAction func moreWrite(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showContent", sender: self)
    }
    
    let pVM: PictureViewModel = PictureViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PicCollectionView.decelerationRate = .normal
        PicCollectionView.dataSource = self
        PicCollectionView.delegate = self
        PicCollectionView.isPagingEnabled = true
        
        pager.numberOfPages = pVM.cntData()
        pager.currentPage = 0
        
        drawView()
    }
    
    func drawView() {
        let now = Date()
        let date = DateFormatter()
        date.locale = Locale(identifier: "ko_kr")
        date.timeZone = TimeZone(abbreviation: "KST")
        date.dateFormat = "MM/dd"

        dateL.text = date.string(from: now)
    }
    
    
}

extension TodayViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //총 page 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pVM.cntData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PicCell", for: indexPath) as?
                PicViewCell else {
            return UICollectionViewCell()
        }
        let data = pVM.getData(indexPath.item)
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

extension TodayViewController: UIScrollViewDelegate {
    
    //수동으로 넘을 때 page를 인식
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let w = scrollView.bounds.size.width
        pager.currentPage = Int(ceil(x/w))
    }
    
}
