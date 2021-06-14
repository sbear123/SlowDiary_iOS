//
//  HomeViewController.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/05/17.
//

import UIKit
import Floaty
import CoreLocation
import FSCalendar

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    let writeVM: WriteViewModel = WriteViewModel.shared
    let weatherVM: WeatherViewModel = WeatherViewModel.shared
    let uVM: UserViewModel = UserViewModel.shared
    let hVM: HomeViewModel = HomeViewModel.shared
    let pVM: PictureViewModel = PictureViewModel.shared
    var locationManager: CLLocationManager!
    var events: [String:String] = [:]
    var notFeel: [String] =  []
    let feelColor = ["happy":hexStringToUIColor(hex: "#F2B694"),"sad": hexStringToUIColor(hex: "#B4D3F0"), "angry":hexStringToUIColor(hex: "#F79183"), "soso":hexStringToUIColor(hex: "#BEE29E")]
    var selectDate: String = GetToday(format: "yyyy.MM.dd")
    
    @IBOutlet var calendar: FSCalendar!
    @IBOutlet var floatyB: Floaty!
    @IBOutlet var collectionview: UICollectionView!
    @IBOutlet var nameL: UILabel!
    @IBOutlet var wordL: UILabel!
    @IBOutlet var goalL: UILabel!
    
    var lat: Double = 35.87222
    var lon: Double = 128.60250
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        calendar.dataSource = self
        if floatyB.items.count < 2 {
            drawView()
        }
        pVM.getTodayPics(){ _ in }
        setUpWrites()
        calendar.locale = Locale(identifier: "ko_KR")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if goalL.text != uVM.goal {
            goalL.text = uVM.goal
        }
        hVM.getWord() { word in
            self.uVM.word = word
            self.wordL.text = word
        }
        setUpWrites()
    }
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()
    
    func setUpWrites() {
        
        hVM.getWrites(month: GetToday(format: "MM"), year: GetToday(format: "yyyy")){ dates in
            self.events = dates.filter({(key, value) in
                return value != ""
            })
            self.notFeel = Array(dates.filter({(key, value) in
                return value == ""
            }).keys)
            self.calendar.reloadData()
        }
    }
    
    func drawView(){
        drawWeather()
        
        floatyB.addItem(icon: UIImage(systemName: "pencil"), handler: {_ in
            self.performSegue(withIdentifier: "showWrite", sender: self.writeVM.today)
        })
        floatyB.addItem(icon: UIImage(systemName: "camera"), handler: {_ in
            self.performSegue(withIdentifier: "showPicture", sender: nil)
        })
        
        self.view.addSubview(floatyB)
        
        nameL.text = uVM.getUserData().name! + "님,"
        hVM.getWord() { word in
            self.uVM.word = word
            self.wordL.text = word
        }
        hVM.getGoal() { goal in
            self.uVM.goal = goal
            self.goalL.text = goal
        }
        nameL.adjustsFontSizeToFitWidth = true
        goalL.adjustsFontSizeToFitWidth = true
        wordL.adjustsFontSizeToFitWidth = true
    }
    
    func drawWeather() {
        //위지정보가져오기
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            let coor = locationManager.location?.coordinate
            lat = coor?.latitude ?? 35.87222
            lon = coor?.longitude ?? 128.60250
        }
        weatherVM.GetData(lat: lat, lon: lon) { h in
            self.collectionview.reloadData()
        }
    }
    
    @IBAction func showWrite(_ sender: Any) {
        print(selectDate)
        self.performSegue(withIdentifier: "readWrite", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWrite" {
            let vc = segue.destination as? WriteViewController
            if let write = sender as? Write {
                vc?.write = write
                let year = Int(GetToday(format: "yyyy"))
                let month = Int(GetToday(format: "MM"))
                let date = Int(GetToday(format: "dd"))
                vc?.date = DateModel(id: uVM.getUserData().id!, year: year, month: month, date: date)
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
            }
            else {
                vc?.pics = self.pVM.todayPic
            }
        }
        else if segue.identifier == "readWrite" {
            let vc = segue.destination as? ReadViewController
            let dateArr: [Int] = selectDate.split(separator: ".").map({Int(String($0))!})
            let date = DateModel(id: uVM.getUserData().id!, year: dateArr[0], month: dateArr[1], date: dateArr[2])
            writeVM.getWirte(date: date) { write in
                vc?.write = write
                vc?.drawView()
            }
            pVM.getPics(date: date) { picture in
                vc?.pic = picture
                vc?.PicCollectionView.reloadData()
                vc?.pager.numberOfPages = picture.count
            }
            vc?.date = selectDate
        }
    }
    
}

extension HomeViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectDate = self.dateFormatter.string(from: date)
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let key = self.dateFormatter.string(from: date)
        if self.notFeel.contains(key){
            return 1
        } else {
            return 0
        }
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let key = self.dateFormatter.string(from: date)
        if events.index(forKey: key) != nil {
            return UIColor.white
        } else {
            return nil
        }
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let key = self.dateFormatter.string(from: date)
        if events.index(forKey: key) != nil {
            return feelColor[events[key]!]
        } else {
            return  nil
        }
    }
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherVM.countOfImageList
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherViewCell", for: indexPath) as?
                WeatherViewCell else {
            return UICollectionViewCell()
        }
        let weatherData = weatherVM.GetWeather(at: indexPath.item)
        cell.update(data: weatherData)
        cell.nameLabel.adjustsFontSizeToFitWidth = true
        
        return cell
    }
}
