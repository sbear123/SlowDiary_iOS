//
//  HomeViewController.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/05/17.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let viewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
