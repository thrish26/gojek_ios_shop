//
//  CustomTextField.swift
//  TextFieldsDemo
//
//  Created by Rajes on 22/02/19.
//

import UIKit

enum FieldCornerType {
    case Full
    case Left
    case Right
}
enum AnimationType: Int {
    case textEntry
    case textDisplay
}

open class CustomTextField : UITextField {
    
    
    
    //MARK: Properties
    private let borderSize: (active: CGFloat, inactive: CGFloat) = (1, 2)
    private let borderLayer = CAShapeLayer()
    private let textFieldInsets = CGPoint(x: 0, y: -5)
    private let placeholderInsets = CGPoint(x: 0, y: -6)
    private var isFocus:Bool = false
    typealias AnimationCompletionHandler = (_ type: AnimationType)->()
    var animationCompletionHandler: AnimationCompletionHandler?
    public let placeholderLabel = UILabel()
    
    var fieldShapeType:FieldCornerType = .Full
    
    
    var fieldBorderColor: UIColor = .lightGray {
        didSet {
            updateBorder()
        }
    }
    
    var placeholderColor: UIColor = .darkGray {
        didSet {
            updatePlaceholder()
        }
    }
    
    
    var placeholderFontScale: CGFloat = 0.9 {
        didSet {
            updatePlaceholder()
        }
    }
    
    override open var placeholder: String? {
        didSet {
            updatePlaceholder()
        }
    }
    
    override open var bounds: CGRect {
        didSet {
            updateBorder()
        }
    }
    
    // MARK:- TextField Life Cycles
    override open func draw(_ rect: CGRect) {
        
        guard isFirstResponder == false else { return }
        drawViewsForRect(rect)
    }
    
    override open var text: String? {
        didSet {
            if let text = text, text.isNotEmpty || isFirstResponder {
                animateViewsForTextEntry()
            } else {
                animateViewsForTextDisplay()
            }
        }
    }
    
    //MARK:- Override PlaceHolder
    override open func drawPlaceholder(in rect: CGRect) {
        // Don't draw any placeholders
    }
    
    override open func prepareForInterfaceBuilder() {
        drawViewsForRect(frame)
    }
    
    //MARK:- Register TextField Observers
    override open func willMove(toSuperview newSuperview: UIView!) {
        if newSuperview != nil {
            NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidEndEditing), name: UITextField.textDidEndEditingNotification, object: self)
            
            NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidBeginEditing), name: UITextField.textDidBeginEditingNotification, object: self)
        } else {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    //MARK:- TextField Obserser Methods
    @objc open func textFieldDidBeginEditing() {
        isFocus = true
        animateViewsForTextEntry()
    }
    
    /**
     The textfield has ended an editing session.
     */
    @objc open func textFieldDidEndEditing() {
        isFocus = false
        animateViewsForTextDisplay()
    }
    
    
    
    
    //MARK:- PlaceHolder Initial Setup
    func drawViewsForRect(_ rect: CGRect) {
        updateBorder()
        updatePlaceholder()
        addSubview(placeholderLabel)
        layer.addSublayer(borderLayer)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        updateBorder()
        updatePlaceholder()
    }
    
    
    
    //MARK:- BecomeResponder And Resign Animations
    open func animateViewsForTextEntry() {
        UIView.animate(withDuration: 0.3, animations: {
            self.updateBorder()
            self.updatePlaceholder()
        }, completion: { _ in
            self.animationCompletionHandler?(.textEntry)
        })
    }
    
    open func animateViewsForTextDisplay() {
        UIView.animate(withDuration: 0.3, animations: {
            self.updateBorder()
            self.updatePlaceholder()
        }, completion: { _ in
            self.animationCompletionHandler?(.textDisplay)
        })
    }
    
    
    
    
    
    
    // MARK:- Draw Views Methods
    
    private func updatePlaceholder() {
        placeholderLabel.frame = placeholderRect(forBounds: bounds)
        placeholderLabel.text = placeholder
        placeholderLabel.font = placeholderFontFromFont(font!)
        placeholderLabel.textColor = placeholderColor
        if checkisRTL() {
            self.textAlignment = .right
            self.contentHorizontalAlignment =  .right
        } else {
            self.contentHorizontalAlignment =  .left
            self.textAlignment = .left
        }
        
        
    }
    
    private func updateBorder() {
        for sLayer in self.layer.sublayers ?? [CAShapeLayer]() {
            if sLayer.name == "BorderLayer" {
                sLayer.removeAllAnimations()
            }
        }
        
        var path = UIBezierPath()
        switch fieldShapeType {
        case .Full:
            path =  fullCornerRadius(frame: self.bounds, cornerRadius: self.frame.size.height/2)
        case .Left:
            if !checkisRTL() {
                path =  semiLeft(frame: self.bounds, cornerRadius: self.frame.size.height/2)
            } else {
                path =  semiRight(frame: self.bounds, cornerRadius: self.frame.size.height/2)
            }
            
        case .Right:
            if !checkisRTL() {
                path =  semiRight(frame: self.bounds, cornerRadius: self.frame.size.height/2)
            } else {
                path =  semiLeft(frame: self.bounds, cornerRadius: self.frame.size.height/2)
            }
            
            
        }
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 0.2
        // borderLayer.add(animation, forKey: "MyAnimation")
        borderLayer.name = "BorderLayer"
        borderLayer.path = path.cgPath
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.darkGray.cgColor
        borderLayer.lineWidth = 1.0
        
    }
    private func checkisRTL() -> Bool {
        if let languageStr = UserDefaults.standard.value(forKey: AccountConstant.language) as? String {
            if languageStr == "ar" {
                return true
            }
        }
        return false
    }
    
    private func fullCornerRadius(frame:CGRect,cornerRadius:CGFloat)  -> UIBezierPath{
        let path = UIBezierPath()
        print(checkisRTL())
        
        
        if isFocus || (text?.count ?? 0) > 0 {
            if checkisRTL() {
                path.move(to: CGPoint(x: self.frame.size.width - ((self.frame.size.height / 2) + 10), y: 0))
            } else {
                let fontAttributes = [NSAttributedString.Key.font: placeholderLabel.font]
                let size = placeholderLabel.text?.size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])
                path.move(to: CGPoint(x: (size?.width ?? 0) + (self.frame.size.height / 2) + 10, y: 0))
                path.addLine(to: CGPoint(x: (size?.width ?? 0) + (self.frame.size.height / 2) + 10 , y: 0))
            }
            
        } else {
            path.addLine(to: CGPoint(x: frame.width-cornerRadius, y: 0))
        }
        
        path.addArc(withCenter: CGPoint(x: frame.width-cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: CGFloat(-(Double.pi)/2), endAngle: 0, clockwise: true)
        path.addLine(to: CGPoint(x: frame.width, y: frame.height-cornerRadius))
        path.addArc(withCenter: CGPoint(x: frame.width-cornerRadius, y: frame.height-cornerRadius), radius: cornerRadius, startAngle: 0, endAngle: CGFloat(Double.pi/2), clockwise: true)
        path.addLine(to: CGPoint(x: cornerRadius, y: frame.height))
        path.addArc(withCenter: CGPoint(x: cornerRadius, y: frame.height-cornerRadius), radius: cornerRadius, startAngle:  CGFloat(Double.pi/2), endAngle: CGFloat(Double.pi), clockwise: true)
        path.addLine(to: CGPoint(x: 0, y: cornerRadius))
        path.addArc(withCenter: CGPoint(x: cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: CGFloat(Double.pi), endAngle:  CGFloat(Double.pi*3/2), clockwise: true)
        if checkisRTL() {
            let fontAttributes = [NSAttributedString.Key.font: placeholderLabel.font]
            let size = placeholderLabel.text?.size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])
            
            path.addLine(to: CGPoint(x: cornerRadius, y: 0))
            path.addLine(to: CGPoint(x: self.frame.width - (CGFloat(size?.width ?? 0) + (self.frame.size.height / 2) + 10) , y: 0))
        }
        
        if isFocus == true || (text?.trimmingCharacters(in: .whitespaces).count)! > 0{
            
        } else {
            path.close()
        }
        
        
        path.apply(CGAffineTransform(translationX: frame.origin.x, y: frame.origin.y))
        
        return path
    }
    
    private func semiLeft(frame:CGRect,cornerRadius:CGFloat)  -> UIBezierPath{
        
        let path = UIBezierPath()
        
        if isFocus || (text?.count ?? 0) > 0{
            if checkisRTL() {
                path.move(to: CGPoint(x: self.frame.size.width - ((self.frame.size.height / 2) + 10), y: 0))
            } else {
                let fontAttributes = [NSAttributedString.Key.font: placeholderLabel.font]
                let size = placeholderLabel.text?.size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])
                path.move(to: CGPoint(x: (size?.width ?? 0) + (self.frame.size.height / 2) + 10, y: 0))
                path.addLine(to: CGPoint(x: (size?.width ?? 0) + (self.frame.size.height / 2) + 10 , y: 0))
            }
        } else {
            path.move(to: CGPoint(x: frame.width/2, y: 0))
            path.addLine(to: CGPoint(x: frame.width-cornerRadius, y: 0))
        }
        
        
        path.addLine(to: CGPoint(x: frame.size.width, y: 0))
        path.addLine(to: CGPoint(x: frame.width, y: self.frame.size.height))
        
        path.addLine(to: CGPoint(x: cornerRadius, y: frame.height))
        path.addArc(withCenter: CGPoint(x: cornerRadius, y: frame.height-cornerRadius), radius: cornerRadius, startAngle:  CGFloat(Double.pi/2), endAngle: CGFloat(Double.pi), clockwise: true)
        path.addLine(to: CGPoint(x: 0, y: cornerRadius))
        path.addArc(withCenter: CGPoint(x: cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: CGFloat(Double.pi), endAngle:  CGFloat(Double.pi*3/2), clockwise: true)
        if checkisRTL() {
            let fontAttributes = [NSAttributedString.Key.font: placeholderLabel.font]
            let size = placeholderLabel.text?.size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])
            path.addLine(to: CGPoint(x: cornerRadius, y: 0))
            path.addLine(to: CGPoint(x: self.frame.width - (CGFloat(size?.width ?? 0) + (self.frame.size.height / 2) + 10) , y: 0))
        }
        
        
        
        
        if isFocus == true || (text?.trimmingCharacters(in: .whitespaces).count)! > 0{
            
        } else {
            path.close()
        }
        // path.close()
        
        path.apply(CGAffineTransform(translationX: frame.origin.x, y: frame.origin.y))
        
        return path
    }
    
    private func semiRight(frame:CGRect,cornerRadius:CGFloat)  -> UIBezierPath{
        let path = UIBezierPath()
        
        if isFocus || (text?.count ?? 0) > 0{
            if checkisRTL() {
                path.move(to: CGPoint(x: self.frame.size.width - ((self.frame.size.height / 2) + 10), y: 0))
            }else {
                let fontAttributes = [NSAttributedString.Key.font: placeholderLabel.font]
                let size = placeholderLabel.text?.size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])
                path.move(to: CGPoint(x: (size?.width ?? 0) + (self.frame.size.height / 2) + 10, y: 0))
                path.addLine(to: CGPoint(x: (size?.width ?? 0) + (self.frame.size.height / 2) + 10 , y: 0))
            }
            
        } else {
            path.addLine(to: CGPoint(x: frame.width-cornerRadius, y: 0))
        }
        
        path.addArc(withCenter: CGPoint(x: frame.width-cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: CGFloat(-(Double.pi)/2), endAngle: 0, clockwise: true)
        path.addLine(to: CGPoint(x: frame.width, y: frame.height-cornerRadius))
        path.addArc(withCenter: CGPoint(x: frame.width-cornerRadius, y: frame.height-cornerRadius), radius: cornerRadius, startAngle: 0, endAngle: CGFloat(Double.pi/2), clockwise: true)
        path.addLine(to: CGPoint(x: cornerRadius, y: frame.height))
        path.addLine(to: CGPoint(x: self.frame.size.width - cornerRadius, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: cornerRadius, y: 0))
        
        if checkisRTL() {
            let fontAttributes = [NSAttributedString.Key.font: placeholderLabel.font]
            let size = placeholderLabel.text?.size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])
            path.addLine(to: CGPoint(x: self.frame.width - (CGFloat(size?.width ?? 0) + (self.frame.size.height / 2) + 10) , y: 0))
        }else {
            
        }
        
        
        
        
        if isFocus == true || (text?.trimmingCharacters(in: .whitespaces).count)! > 0{
            
        } else {
            path.close()
        }
        
        path.apply(CGAffineTransform(translationX: frame.origin.x, y: frame.origin.y))
        
        return path
    }
    private func percentageForBottomBorder() -> CGFloat {
        let borderRect = rectForBorder(bounds)
        let sumOfSides = (borderRect.width * 2) + (borderRect.height * 2)
        return (borderRect.width * 100 / sumOfSides) / 100
    }
    private func rectForBorder(_ bounds: CGRect) -> CGRect {
        let newRect = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height - font!.lineHeight + textFieldInsets.y)
        
        return newRect
    }
    private func placeholderFontFromFont(_ font: UIFont) -> UIFont! {
        let smallerFont = UIFont(name: font.fontName, size: font.pointSize * placeholderFontScale)
        return smallerFont
    }
    
    private var placeholderHeight : CGFloat {
        return placeholderInsets.y + placeholderFontFromFont(font!).lineHeight + 5
    }
    
    private func rectForBounds(_ bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x, y: bounds.origin.y + placeholderHeight, width: bounds.size.width, height: bounds.size.height - placeholderHeight)
    }
    
    // MARK: - Overrides
    
    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        if isFirstResponder || text!.isNotEmpty {
            if checkisRTL() {
                return CGRect(x: (self.frame.size.height / 2) + 5, y: placeholderInsets.y, width: bounds.width - ((self.frame.size.height / 2) * 2 ) - 15, height: placeholderHeight)
            } else {
                return CGRect(x: (self.frame.size.height / 2) + 5, y: placeholderInsets.y, width: bounds.width - ((self.frame.size.height / 2) * 2 ), height: placeholderHeight)
            }
        } else {
            
            if checkisRTL() {
                let  rect =  textRect(forBounds: bounds)
                let  width  =  rect.size.width - (rect.size.height / 2)
                return CGRect(x: rect.origin.x - (rect.size.height / 2), y:rect.origin.y , width: width, height: rect.size.height)
            } else {
                return textRect(forBounds: bounds)
            }
            
            
        }
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var  rect =  textRect(forBounds: bounds)
        if checkisRTL() {
            let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            rect = bounds.inset(by: padding)
        }
        
        let  width  =  rect.size.width - (rect.size.height / 2)
        return CGRect(x: rect.origin.x, y:rect.origin.y , width: width, height: rect.size.height)//textRect(forBounds: bounds)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        
        if checkisRTL() && text!.isNotEmpty{
            return bounds.offsetBy(dx: -((self.frame.size.height / 2) + 5), dy: textFieldInsets.y + placeholderHeight/2)
        } else {
            return bounds.offsetBy(dx: (self.frame.size.height / 2) + 5, dy: textFieldInsets.y + placeholderHeight/2)
        }
    }
    
    func setRightImage(imageStr:String,tintColor:UIColor)  {
        
        let rightView = UIView()
        let rightImageView =  UIImageView()
        let viewHeight = self.frame.height
        let image = UIImage(named: imageStr)
        // set frame on image before adding it to the uitextfield
        rightView.frame = CGRect(x: (self.frame.size.width/2) - (viewHeight/2) , y: (self.frame.size.height/2) - (viewHeight/2), width: self.frame.height-5, height: self.frame.height-5)
        rightView.cornerRadius = 5.0
        rightImageView.image = image
        rightImageView.imageTintColor(color1: tintColor)
        rightView.backgroundColor = .clear
        rightImageView.frame = CGRect(x: (rightView.frame.width/2)-10 , y: (rightView.frame.width/2)-10, width: 20, height: 20)
        rightView.addSubview(rightImageView)
        self.rightView = rightView
        self.rightViewMode = .always
    }
}
