//
//  HomeViewController.swift
//  TodayNews
//
//  Created by 星空浩 on 2016/10/26.
//  Copyright © 2016年 DFYG_YF3. All rights reserved.
//

import UIKit
import MJRefresh

let topicSmallCellID = "HomeSmallCell"
let topicMiddleCellID = "HomeMiddleCell"
let topicLargeCellID = "HomeLargeCell"
let topicNoImageCellID = "HomeNoImageCell"
let stockCellID = "StockCell"
class HomeViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{

    private var pullRefreshTime: TimeInterval?

    var category:String?
    var newTopics:[NewsItem] = [NewsItem]()
    private lazy var tipsView:TipsView = {
        let tipsView:TipsView = TipsView(frame: CGRect(x: 0, y: 0, width: SCREENW, height: 40))
        tipsView.backgroundColor = UIColor.lightGray
        tipsView.isHidden = true
        return tipsView
    }()
    override func viewDidLoad(){
        super.viewDidLoad()
//        self.automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.white
        self.setupUI()
        self.tabView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.showTipsView()
            self.requestData()
        })
        self.tabView.mj_footer = MJRefreshAutoFooter.init(refreshingBlock: { 
            self.requestLoadMoreNews()
        })
        self.tabView.mj_header.beginRefreshing()
    }
    func setupUI(){
        view.addSubview(tabView)
        view.addSubview(tipsView)
    }
    private lazy var tabView:UITableView = {
       print( self.navigationController?.navigationBar.height ?? "")
        let tab = UITableView(frame: CGRect(x:0,y:0,width:SCREENW,height:SCREENH-NavBarHeight-TabBarHeight+20), style: .plain)
        tab.delegate = self
        tab.dataSource = self
        tab.tableFooterView = UIView()
        tab.register(HomeSmallCell.self, forCellReuseIdentifier: topicSmallCellID)
        tab.register(HomeMiddleCell.self, forCellReuseIdentifier: topicMiddleCellID)
        tab.register(HomeLargeCell.self, forCellReuseIdentifier: topicLargeCellID)
        tab.register(HomeNoImageCell.self, forCellReuseIdentifier: topicNoImageCellID)
        tab.register(UINib.init(nibName: stockCellID, bundle: nil), forCellReuseIdentifier: stockCellID)
        return tab
    }()
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.tableViewNoDataOrNewworkFail(rowCount: newTopics.count)
        return newTopics.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let newsTopic = newTopics[indexPath.row]
        return newsTopic.cellHeight
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsTopic = newTopics[indexPath.row]
        if newsTopic.cell_type == 0 {
            if newsTopic.image_list.count != 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: topicSmallCellID) as! HomeSmallCell
                cell.newsTopic = newsTopic
                //            cell.closeButtonClick(closure: { [weak self] (filterWords) in
                // closeButton 相对于 tableView 的坐标
                //                let point = self!.view.convert(cell.frame.origin, from: tableView)
                //                let convertPoint = CGPoint(x:point.x,y: point.y + cell.closeButton.y)
                //                self!.showPopView(filterWords, point: convertPoint)
                //                })
                return cell
            } else {
                if newsTopic.middle_image?.height != nil {
                    if newsTopic.video_detail_info?.video_id != nil || newsTopic.large_image_list.count != 0 {
                        let cell = tableView.dequeueReusableCell(withIdentifier: topicLargeCellID) as! HomeLargeCell
                        cell.newsTopic = newsTopic
                        //                    cell.closeButtonClick(closure: { [weak self] (filterWords) in
                        // closeButton 相对于 tableView 的坐标
                        
                        //                        let point = self!.view.convert(cell.frame.origin, to: tableView)
                        //                        let convertPoint = CGPoint(x:point.x,y: point.y + cell.closeButton.y)
                        //                        self!.showPopView(filterWords, point: convertPoint)
                        //                        })
                        return cell
                    } else {
                        let cell = tableView.dequeueReusableCell(withIdentifier: topicMiddleCellID) as! HomeMiddleCell
                        cell.newsTopic = newsTopic
                        //                    cell.closeButtonClick(closure: { [weak self] (filterWords) in
                        // closeButton 相对于 tableView 的坐标
                        //                        let point = self!.view.convert(cell.frame.origin, from: tableView)
                        //                        let convertPoint = CGPoint(x:point.x,y: point.y + cell.closeButton.y)
                        //                        self!.showPopView(filterWords, point: convertPoint)
                        //                        })
                        return cell
                    }
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: topicNoImageCellID) as! HomeNoImageCell
                    cell.newsTopic = newsTopic
                    //                cell.closeButtonClick(closure: { [weak self] (filterWords) in
                    // closeButton 相对于 tableView 的坐标
                    //                    let point = self!.view.convert(cell.frame.origin, from: tableView)
                    //                    let convertPoint = CGPoint(x:point.x, y:point.y + cell.closeButton.y)
                    //                    self!.showPopView(filterWords, point: convertPoint)
                    //                    })
                    return cell
                }
            }
        }else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: stockCellID, for: indexPath)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    func changeTabViewFrame(){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*servers*/
    func requestData(){
        let backend:HomeBackend = HomeBackend()
//        print(category)
        backend.loadCatogoryContent(tableView:self.tabView,category: category!) { (nowTime,topics) in
            self.pullRefreshTime = nowTime
            self.newTopics = topics
            self.tabView.reloadData()
            self.tabView.mj_header.endRefreshing()
        }
    }
    
    func requestLoadMoreNews(){
        let backend:HomeBackend = HomeBackend()
        backend.loadHomeCategoryMoreNewsFeed(category: category!, lastRefreshTime: self.pullRefreshTime!, tableView: self.tabView) { (moreItems) in
            self.newTopics += moreItems
            self.tabView.reloadData()
        }
    }
    func showTipsView(){
        let backend:HomeBackend = HomeBackend()
        backend.loadArticleRefreshTip { (newsNum) in
            self.tipsView.isHidden = false
            self.tipsView.textLab.text = newsNum==0 ? "暂无更新请休息会" : "今日头条推荐引擎有\(newsNum)条刷新"
            UIView.animate(withDuration: kAnimationDuration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue:0), animations: {
                self.tipsView.textLab.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                }, completion: { (_) in
                    self.tipsView.textLab.transform  = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    let delayTime = DispatchTime.now() + DispatchTimeInterval.seconds(1)
                    let queue = DispatchQueue.main
                    queue.asyncAfter(deadline: delayTime, execute: {
                        self.tipsView.isHidden = true
                    })
            })
        }
    }
}
