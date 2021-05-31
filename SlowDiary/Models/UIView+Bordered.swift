//
//  UIView+Bordered.swift
//  SlowDiary
//
//  Created by 박지현 on 2021/05/27.
//

import UIKit

private var bottomLineColorAssociatedKey : UIColor = .black
private var topLineColorAssociatedKey : UIColor = .black
private var rightLineColorAssociatedKey : UIColor = .black
private var leftLineColorAssociatedKey : UIColor = .black

@IBDesignable extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var bottomLineColor: UIColor {
        get {
            if let color = objc_getAssociatedObject(self, &bottomLineColorAssociatedKey) as? UIColor {
                return color
            } else {
                return .black
            }
        } set {
            objc_setAssociatedObject(self, &bottomLineColorAssociatedKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    @IBInspectable var bottomLineWidth: CGFloat {
        get {
            return self.bottomLineWidth
        }
        set {
            DispatchQueue.main.async {
                self.addBottomBorderWithColor(color: self.bottomLineColor, width: newValue)
            }
        }
    }
    @IBInspectable var topLineColor: UIColor {
        get {
            if let color = objc_getAssociatedObject(self, &topLineColorAssociatedKey) as? UIColor {
                return color
            } else {
                return .black
            }
        } set {
            objc_setAssociatedObject(self, &topLineColorAssociatedKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    @IBInspectable var topLineWidth: CGFloat {
        get {
            return self.topLineWidth
        }
        set {
            DispatchQueue.main.async {
                self.addTopBorderWithColor(color: self.topLineColor, width: newValue)
            }
        }
    }
    @IBInspectable var rightLineColor: UIColor {
        get {
            if let color = objc_getAssociatedObject(self, &rightLineColorAssociatedKey) as? UIColor {
                return color
            } else {
                return .black
            }
        } set {
            objc_setAssociatedObject(self, &rightLineColorAssociatedKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    @IBInspectable var rightLineWidth: CGFloat {
        get {
            return self.rightLineWidth
        }
        set {
            DispatchQueue.main.async {
                self.addRightBorderWithColor(color: self.rightLineColor, width: newValue)
            }
        }
    }
    @IBInspectable var leftLineColor: UIColor {
        get {
            if let color = objc_getAssociatedObject(self, &leftLineColorAssociatedKey) as? UIColor {
                return color
            } else {
                return .black
            }
        } set {
            objc_setAssociatedObject(self, &leftLineColorAssociatedKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    @IBInspectable var leftLineWidth: CGFloat {
        get {
            return self.leftLineWidth
        }
        set {
            DispatchQueue.main.async {
                self.addLeftBorderWithColor(color: self.leftLineColor, width: newValue)
            }
        }
    }
    
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.name = "topBorderLayer"
        removePreviouslyAddedLayer(name: border.name ?? "")
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y : 0,width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
        self.addObserver(self, forKeyPath: #keyPath(UIView.bounds), options: .new, context: UnsafeMutableRawPointer(bitPattern: 1111) )
    }

    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.name = "rightBorderLayer"
        removePreviouslyAddedLayer(name: border.name ?? "")
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width, y: 0, width : width, height :self.frame.size.height)
        self.layer.addSublayer(border)
         self.addObserver(self, forKeyPath: #keyPath(UIView.bounds), options: .new, context: UnsafeMutableRawPointer(bitPattern: 2222) )
    }

    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.name = "bottomBorderLayer"
        removePreviouslyAddedLayer(name: border.name ?? "")
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,width : self.frame.size.width,height: width)
        self.layer.addSublayer(border)
        self.addObserver(self, forKeyPath: #keyPath(UIView.bounds), options: .new, context: UnsafeMutableRawPointer(bitPattern: 3333) )
    }
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.name = "leftBorderLayer"
        removePreviouslyAddedLayer(name: border.name ?? "")
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:0, y:0,width : width, height : self.frame.size.height)
        self.layer.addSublayer(border)
        self.addObserver(self, forKeyPath: #keyPath(UIView.bounds), options: .new, context: UnsafeMutableRawPointer(bitPattern: 4444) )
    }

    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

        if let objectView = object as? UIView,
            objectView === self,
            keyPath == #keyPath(UIView.bounds) {
            switch context {
            case UnsafeMutableRawPointer(bitPattern: 1111):
                for border in self.layer.sublayers ?? [] {
                    if border.name == "topBorderLayer" {
                        border.frame = CGRect(x: 0, y : 0,width: self.frame.size.width, height: border.frame.height)
                    }
                }
            case UnsafeMutableRawPointer(bitPattern: 2222):
                for border in self.layer.sublayers ?? [] {
                    if border.name == "rightBorderLayer" {
                         border.frame = CGRect(x: self.frame.size.width - border.frame.width, y: 0, width : border.frame.width, height :self.frame.size.height)
                    }
                }
            case UnsafeMutableRawPointer(bitPattern: 3333):
                for border in self.layer.sublayers ?? [] {
                    if border.name == "bottomBorderLayer" {
                        border.frame = CGRect(x: 0, y: self.frame.size.height - border.frame.height,width : self.frame.size.width,height: border.frame.height)
                    }
                }
            case UnsafeMutableRawPointer(bitPattern: 4444):
                for border in self.layer.sublayers ?? [] {
                    if border.name == "leftBorderLayer" {
                       border.frame = CGRect(x:0, y:0,width : border.frame.width, height : self.frame.size.height)
                    }
                }
            default:
                break
            }
        }
    }
    func removePreviouslyAddedLayer(name : String) {
        if self.layer.sublayers?.count ?? 0 > 0 {
            self.layer.sublayers?.forEach {
                if $0.name == name {
                    $0.removeFromSuperlayer()
                }
            }
        }
    }
    
    @IBInspectable
        var shadowRadius: CGFloat {
            get {
                return layer.shadowRadius
            }
            set {

                layer.shadowRadius = newValue
            }
        }
        @IBInspectable
        var shadowOffset : CGSize{

            get{
                return layer.shadowOffset
            }set{

                layer.shadowOffset = newValue
            }
        }

        @IBInspectable
        var shadowColor : UIColor{
            get{
                return UIColor.init(cgColor: layer.shadowColor!)
            }
            set {
                layer.shadowColor = newValue.cgColor
            }
        }
        @IBInspectable
        var shadowOpacity : Float {

            get{
                return layer.shadowOpacity
            }
            set {

                layer.shadowOpacity = newValue

            }
        }        
}
