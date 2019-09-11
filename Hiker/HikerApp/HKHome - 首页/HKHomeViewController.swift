//
//  HKHomeViewController.swift
//  Hiker
//
//  Created by 张驰 on 2019/9/9.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import SnapKit

class HKHomeViewController: UIViewController {
    
    // 标签栏中间
    lazy var centerView:UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor.clear
        return vi
    }()
    // 标签栏中间按钮
    lazy var notesBtn : UIButton = {
        let btn = UIButton()
        //btn.setImage(UIImage(named: "add_tab"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "add_tab"), for: .normal)
        //btn.imageView?.image = UIImage(named: "add_tab")
        btn.addTarget(self, action: #selector(add), for: .touchUpInside)
        return btn
    }()
    
    // MARK - 右边功能按钮
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
       // button.frame = CGRect(x:10, y:100, width:40, height: 40)
        button.addTarget(self, action: #selector(tip), for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(named: "home_icon_tip"), for: .normal)
        //button.backgroundColor = UIColor.red
        return button
    }()
    
    
    private let HKHomeSearchViewID = "HomeSearchView"
    private let HKRecommendCityID = "RecommendCityView"
    private let HKStoryID = "StoryView"
    private let HeaderViewID = "HomeHeaderReusableView"
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = backColor
        
        // 注册头部视图
        collection.register(HomeHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderViewID)
        
        collection.register(HomeSearchView.self, forCellWithReuseIdentifier: HKHomeSearchViewID)
        collection.register(RecommendCityView.self, forCellWithReuseIdentifier: HKRecommendCityID)
        collection.register(StoryView.self, forCellWithReuseIdentifier: HKStoryID)
        collection.showsHorizontalScrollIndicator  = false
        collection.showsVerticalScrollIndicator = false
        
        return collection
    }()
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNav()

    }
    
    func configUI(){
        view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
         view.backgroundColor = backColor
        
    }

    func configNav(){
        if #available(iOS 11.0, *) {
//            navigation.bar.largeTitleTextAttributes = [
//                .font: UIFont.systemFont(ofSize: 50),
//                .foregroundColor: UIColor.orange]
            self.navigation.bar.prefersLargeTitles = true
            
        }
        // if you want change navigation bar position
        navigation.bar.automaticallyAdjustsPosition = false
        
        self.navigation.item.title = "发现"
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.addSubview(rightBarButton)
        rightBarButton.snp.makeConstraints { (make) in
            make.right.equalTo(navigation.bar.snp.right).offset(-15)
            make.bottom.equalTo(navigation.bar.snp.bottom).offset(-10)
            make.width.height.equalTo(40)
        }
    }

    @objc func add() {
        print("中间按钮")
    }
    @objc func tip(){
        let tipsVC = NextViewController()
        navigationController?.pushViewController(tipsVC, animated: true)
    }
}


extension HKHomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let statusBarMaxY = UIApplication.shared.statusBarFrame.maxY
//        let originY = -scrollView.contentOffset.y + statusBarMaxY
//        let alpha = 1 - (scrollView.contentOffset.y) / navigation.bar.frame.height
//        navigation.bar.setTintAlpha(alpha)
//        navigation.bar.setTitleAlpha(alpha)
//        if #available(iOS 11.0, *) {
//            navigation.bar.setLargeTitleAlpha(alpha)
//        }
//        if originY <= statusBarMaxY {
//            let minY = statusBarMaxY - navigation.bar.frame.height
//            navigation.bar.frame.origin.y = originY > minY ? originY : minY
//        } else {
//            if #available(iOS 11.0, *) { navigation.bar.setLargeTitleAlpha(1) }
//            navigation.bar.setTitleAlpha(1)
//            navigation.bar.setTintAlpha(1)
//            navigation.bar.frame.origin.y = statusBarMaxY
//        }
    }

}
extension HKHomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section <= 1 {
            return 1
        }else {
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HKHomeSearchViewID, for: indexPath) as! HomeSearchView
        return cell
        }
        else if indexPath.section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HKRecommendCityID, for: indexPath) as! RecommendCityView
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HKStoryID, for: indexPath) as! StoryView
            return cell
        }
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return  UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
        }
        if section == 1 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 2 {
            return 30
        }
        return 0
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: 374, height: 50)
        }else if indexPath.section == 1{
            return CGSize(width: 414, height: 220)
        }else {
            return CGSize(width: 374, height: 350)
        }
    }
    
    // 头部
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderViewID, for: indexPath) as? HomeHeaderReusableView else {
            return UICollectionReusableView()
        }
        if indexPath.section == 2{
            headerView.titleLabel.text = "故事"
        }
        return headerView
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
        return CGSize(width: 414, height: 30)
        }
        if section == 2 {
            return CGSize(width: 414, height: 30)
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
//            let searchVC = SearchViewController()
//            self.navigationController?.pushViewController(searchVC, animated: true)
        }else {
        var model = StoryBannerModel()
        model.title = "魔都上海两日"
        let vc = StoryViewController(model: model)
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}
