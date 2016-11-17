//
//  XKScrollViewController.swift
//  TodayNews
//
//  Created by 星空浩 on 2016/10/31.
//  Copyright © 2016年 DFYG_YF3. All rights reserved.
//

import UIKit
import Dispatch
class XKScrollViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    public var titles = [HomeTopTitle]()
    public var titleLabW:CGFloat = SCREENW/5.0
    public var titleH:CGFloat = 40
    private var pageHeight:CGFloat = 0.0
    var startIndex:NSInteger = 0//起始的页面

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.automaticallyAdjustsScrollViewInsets = false
        navigationController?.navigationBar.barTintColor = XKColor(r: 210, g: 63, b: 66, a: 1.0)

        pageHeight = SCREENH - (NavBarHeight + TabBarHeight)
        self.setupUI()
        self.requestTitles()
    }
    
    func setupUI(){
        navigationItem.titleView = titleScroll
//        view.addSubview(titleScroll)
        view.addSubview(pageCollection)
        view.backgroundColor = UIColor.white

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        pageCollection.contentOffset = CGPoint(x: 0, y: 0)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    private lazy var titleScroll:HomeTitleView = {

        let titleScroll = HomeTitleView(frame:CGRect(x: 0, y: 0, width: SCREENW, height: self.titleH))
        titleScroll.startIndex = self.startIndex
        titleScroll.didSelectTitleClosure(closure: { (TitleButton) in
            
            let indexPath:IndexPath = IndexPath(item: Int(TitleButton.tag-100), section: 0)
            self.pageCollection.scrollToItem(at: indexPath, at: .left, animated: true)
        })
        return titleScroll
    }()
    private lazy var pageCollection:UICollectionView = {
        let pageCollection = UICollectionView(frame: self.view.bounds, collectionViewLayout: self.flowLayout)
        pageCollection.delegate = self
        pageCollection.dataSource = self
        pageCollection.isPagingEnabled = true
        pageCollection.backgroundColor = UIColor.green
        pageCollection .register(XKPageCell.self, forCellWithReuseIdentifier:"PageCell")
        
        return pageCollection
    }()
    private  var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        return flowLayout
    }()

    /*CollectionView代理*/
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREENW, height: self.pageHeight)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:XKPageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageCell", for: indexPath) as! XKPageCell
        cell.setupUI(text: "\(indexPath.item)")
      cell.backgroundColor = UIColor.red
        return cell
    }
    //点击
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
       
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if self.titles.count>indexPath.item  {
            let childVC = childViewControllers[indexPath.item]
            let r = arc4random()%255,g = arc4random()%255,b=arc4random()%255
            childVC.view.backgroundColor = XKColor(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b),a: 1)
//            childVC.view.frame = self.view.bounds
            cell.addSubview(childVC.view)
        }
    }
    /*scrollView代理*/

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.pageCollection {
            var page:Int = Int(self.pageCollection.contentOffset.x/SCREENW)
            if page<0 {
                page = 0
            }
            page = page < 0 ? 0 : page
            page = page > childViewControllers.count-1 ? childViewControllers.count-1 : page
            self.titleScroll.adjustTitleOffSetToCurrentIndex(index: page+100)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == pageCollection {
        }
    }
    func requestTitles(){
//        self.titles = NetWorkCache().unarchiveNetData(fileName: "topTitles.archive", obj: self.titles as AnyObject) as! [HomeTopTitle]
//        if titles.count != 0 {
//            self.addChildrenControllers(topTitles: (self.titles))
//            self.titleScroll.setupUI(titles: self.titles)
//            self.pageCollection.reloadData()
//            return
//        }
        let homeBackend:HomeBackend = HomeBackend()
        homeBackend.loadHomeTitlesData { [weak self] (topTitles) in
            let dict = ["category":"__all__","name":"推荐"]
            let recommend = HomeTopTitle(dict:dict as [String : AnyObject])
            self!.titles.append(recommend)
            self!.titles += topTitles
            self?.addChildrenControllers(topTitles: (self?.titles)!)
            self?.titleScroll.setupUI(titles: self!.titles)
            self?.pageCollection.reloadData()
//            NetWorkCache().archiveNetData(filelName: "topTitles.archive", obj: topTitles)
        }
    }
    func addChildrenControllers(topTitles: [HomeTopTitle]){
        for title in topTitles {
            let childVC:HomeViewController = HomeViewController()
            childVC.category = title.category!
            self.addChildViewController(childVC)
        }
    }
    
    
}
