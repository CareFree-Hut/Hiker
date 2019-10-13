//
//  Extension + color.swift
//  Hiker
//
//  Created by 张驰 on 2019/9/9.
//  Copyright © 2019 张驰. All rights reserved.
//

import Foundation
import UIKit
import MJRefresh
import SnapKit

class URefreshHeader: MJRefreshGifHeader {
    override func prepare() {
        super.prepare()
        setImages([UIImage(named: "pullToRefresh_0_80x60_")!], for: .idle)
        setImages([UIImage(named: "pullToRefresh_0_80x60_")!], for: .pulling)
        setImages([UIImage(named: "pullToRefresh_0_80x60_")!,
                   UIImage(named: "pullToRefresh_1_80x60_")!,
                   UIImage(named: "pullToRefresh_2_80x60_")!,
                   UIImage(named: "pullToRefresh_3_80x60_")!,
                   UIImage(named: "pullToRefresh_4_80x60_")!,
                   UIImage(named: "pullToRefresh_5_80x60_")!,
                   UIImage(named: "pullToRefresh_6_80x60_")!,
                   UIImage(named: "pullToRefresh_7_80x60_")!,
                   UIImage(named: "pullToRefresh_8_80x60_")!,
                   UIImage(named: "pullToRefresh_9_80x60_")!], for: .refreshing)
        
        lastUpdatedTimeLabel.isHidden = true
        stateLabel.isHidden = true
    }
}

extension UIScrollView {
    var uHead: MJRefreshHeader {
        get { return mj_header }
        set { mj_header = newValue }
    }

    var uFoot: MJRefreshFooter {
        get { return mj_footer }
        set { mj_footer = newValue }
    }
}

public extension Double {
    var fitWidth_Double: Double {
        return self/414.0 * Double(TKWidth)
    }
    var fitHeight_Double: Double {
        return self/896.0 * Double(TKHeight)
    }
    var fitWidth_CGFloat: CGFloat {
        return CGFloat(self)/414.0 * CGFloat(TKWidth)
    }
    var fitHeight_CGFloat: CGFloat {
        return CGFloat(self)/896.0 * CGFloat(TKHeight)
    }
    var fitWidth_Int: Int{
        return Int(self/414.0 * Double(TKWidth))
    }
    var fitHeight_Int: Int{
        return Int(self/896.0 * Double(TKHeight))
    }
}

extension UIColor {
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat,alpha: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
    
    class func globalCyanColor() -> UIColor{
        return UIColor(r: 7, g: 216, b: 243)
    }
}



extension UIScreen {
    var titleY: CGFloat {
        if safeAreaInsets.top == 0 {
            return 20.0
        } else {
            return safeAreaInsets.top
        }
    }
    
    var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return  UIApplication.shared.keyWindow?.safeAreaInsets ?? .zero
        } else {
            return .zero
            // Fallback on earlier versions
        }
    }
    
    func widthOfSafeArea() -> CGFloat {
        guard let rootView = UIApplication.shared.keyWindow else { return 0 }
        if #available(iOS 11.0, *) {
            let leftInset = rootView.safeAreaInsets.left
            let rightInset = rootView.safeAreaInsets.right
            return rootView.bounds.width - leftInset - rightInset
        } else {
            return rootView.bounds.width
        }
    }
    
    func heightOfSafeArea() -> CGFloat {
        
        guard let rootView = UIApplication.shared.keyWindow else { return 0 }
        
        if #available(iOS 11.0, *) {
            
            let topInset = rootView.safeAreaInsets.top
            
            let bottomInset = rootView.safeAreaInsets.bottom
            
            return rootView.bounds.height - topInset - bottomInset
            
        } else {
            
            return rootView.bounds.height
            
        }
        
    }
    
}
extension UIView{
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
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
    var shadowOpacity:Float{
        get{
            return layer.shadowOpacity
        }
        set{
            layer.shadowOpacity = newValue
        }
    }
    @IBInspectable
    var shadowColor:UIColor{
        get{
            return (layer.shadowColor != nil ? UIColor(cgColor: layer.shadowColor!) :nil)!
        }
        set{
            layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable
    var borderColor: UIColor {
        get {
            return (layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!) :nil)!
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
}

extension UIView {
    
    /// 部分圆角
    ///
    /// - Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radii: 圆角半径
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        
    }
}
extension UIImage
{
    /**
     根据传入的宽度生成一张图片
     按照图片的宽高比来压缩以前的图片
     :param: width 制定宽度
     */
    func imageWithScale(width: CGFloat) -> UIImage
    {
        // 1.根据宽度计算高度
        let height = width *  size.height / size.width
        // 2.按照宽高比绘制一张新的图片
        let currentSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContext(currentSize)
        draw(in: CGRect(origin: CGPoint.zero, size: currentSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

public extension Array {
    
    /**
     Returns a random element from the array. Can be used to create a playful
     message that cycles randomly through a set of emoji icons, for example.
     */
    public func sm_random() -> Iterator.Element? {
        guard count > 0 else { return nil }
        return self[Int(arc4random_uniform(UInt32(count)))]
    }
}


extension UIView {
    //返回该view所在的父view
    func superView<T: UIView>(of: T.Type) -> T? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let father = view as? T {
                return father
            }
        }
        return nil
    }
}

extension UIView {
    
    /// 快速创建 View 并使用 SnapKit 布局
    ///
    /// - Parameters:
    ///   - bgClor: View 的背景颜色
    ///   - supView: 父视图
    ///   - closure: 约束
    /// - Returns:  View
    class func tk_createView(bgClor : UIColor , supView : UIView? ,closure:(_ make:ConstraintMaker) ->()) -> UIView {
        let view = UIView()
        view.backgroundColor = bgClor
        if supView != nil {
            supView?.addSubview(view)
            view.snp.makeConstraints { (make) in
                closure(make)
            }
        }
        return view
    }
    
    /// 快速创建一个 UIImageView,可以设置 imageName,contentMode,父视图,约束
    ///
    /// - Parameters:
    ///   - imageName: 图片名称
    ///   - contentMode: 填充模式
    ///   - supView: 父视图
    ///   - closure: 约束
    /// - Returns:  UIImageView
    class func tk_createImageView(imageName : String? , contentMode : UIView.ContentMode? = nil,supView : UIView? ,closure:(_ make : ConstraintMaker) ->()) -> UIImageView {
        
        let imageV = UIImageView()
        
        if imageName != nil {
            imageV.image = UIImage(named: imageName!)
        }
        
        if contentMode != nil {
            imageV.contentMode = contentMode!
        }
        
        if supView != nil {
            supView?.addSubview(imageV)
            imageV.snp.makeConstraints { (make) in
                closure(make)
            }
        }
        return imageV
    }
    
    
    /// 快速创建 Label,设置文本, 文本颜色,Font,文本位置,父视图,约束
    ///
    /// - Parameters:
    ///   - text: 文本
    ///   - textColor: 文本颜色
    ///   - font: 字体大小
    ///   - textAlignment: 文本位置
    ///   - supView: 父视图
    ///   - closure: 越是
    /// - Returns:  UILabel
    class func tk_createLabel(text : String? , textColor : UIColor?, font : UIFont?, textAlignment : NSTextAlignment = .left,supView : UIView? ,closure:(_ make : ConstraintMaker) ->()) -> UILabel {
        
        let label = UILabel()
        label.text = text
        if (textColor != nil) { label.textColor = textColor }
        if (font != nil) { label.font = font }
        label.textAlignment = textAlignment
        
        if supView != nil {
            supView?.addSubview(label)
            label.snp.makeConstraints { (make) in
                closure(make)
            }
        }
        return label
    }
    
    /// 快速创建 UIButton,设置标题,图片,父视图,约束
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - titleStatu: 标题状态模式
    ///   - imageName: 图片名
    ///   - imageStatu: 图片状态模式
    ///   - supView: 父视图
    ///   - closure: 约束
    /// - Returns:  UIButton
    class func tk_createButton(title : String?,titleStatu : UIControl.State?,titleColor: UIColor? = nil,imageName : String?,imageStatu : UIControl.State?, font : UIFont? = FontSize(14),supView : UIView? ,closure:(_ make : ConstraintMaker) ->()) -> UIButton{
        let btn = UIButton()
        
        if title != nil {
            btn.setTitle(title, for: .normal)
        }
        
        if title != nil && titleStatu != nil {
            btn.setTitle(title, for: titleStatu!)
        }
        
        if imageName != nil {
            btn.setImage(UIImage(named: imageName!), for: .normal)
        }
        
        if imageName != nil && imageStatu != nil {
            btn.setImage(UIImage(named: imageName!), for: imageStatu!)
        }
        
        if titleColor != nil {
            btn.setTitleColor(titleColor, for: .normal)
        }
        btn.titleLabel?.font = font
        if supView != nil {
            supView?.addSubview(btn)
            btn.snp.makeConstraints { (make) in
                closure(make)
            }
        }
        return btn
    }
    
    /// 快速创建 UITextField,设置文本,文本颜色,placeholder,字体大小,文本位置,边框样式, 自动布局
    ///
    /// - Parameters:
    ///   - text: 文本
    ///   - textColor: 文本颜色
    ///   - placeholder: placeholder
    ///   - font: 字体大小
    ///   - textAlignment: 文本位置
    ///   - borderStyle: 边框样式
    ///   - supView: 父视图
    ///   - closure:  make
    /// - Returns: UITextField
    class func tk_createTextField(text : String? , textColor : UIColor?, placeholder: String, font : UIFont?, textAlignment : NSTextAlignment = .left, borderStyle :UITextField.BorderStyle = .none,supView : UIView? ,closure:(_ make : ConstraintMaker) ->()) -> UITextField {
        
        let textField = UITextField()
        textField.text = text
        textField.placeholder = placeholder
        textField.borderStyle = borderStyle
        if (textColor != nil) { textField.textColor = textColor }
        if (font != nil) { textField.font = font }
        
        textField.textAlignment = textAlignment
        
        if supView != nil {
            supView?.addSubview(textField)
            textField.snp.makeConstraints { (make) in
                closure(make)
            }
        }
        return textField
    }
    
    
}
