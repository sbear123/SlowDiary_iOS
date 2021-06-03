//
//  HomeViewController.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/05/17.
//

import UIKit
import Floaty

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let viewModel = WeatherViewModel()
    @IBOutlet var floatyB: Floaty!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if floatyB.items.count < 2 {
            floatyB.addItem(icon: UIImage(systemName: "pencil"), handler: {_ in
                self.performSegue(withIdentifier: "showWrite", sender: self)
            })
            floatyB.addItem(icon: UIImage(systemName: "camera"), handler: {_ in
                self.performSegue(withIdentifier: "showPicture", sender: self)
            })
            
            self.view.addSubview(floatyB)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.countOfImageList
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherViewCell", for: indexPath) as?
                WeatherViewCell else {
            return UICollectionViewCell()
        }
        let weatherData = viewModel.GetWeather(at: indexPath.item)
        cell.update(data: weatherData)
        
        return cell
    }
    
    
}
