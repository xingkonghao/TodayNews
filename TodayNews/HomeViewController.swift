//
//  HomeViewController.swift
//  TodayNews
//
//  Created by 星空浩 on 2016/10/26.
//  Copyright © 2016年 DFYG_YF3. All rights reserved.
//

import UIKit
let topicSmallCellID = "HomeSmallCell"
let topicMiddleCellID = "HomeMiddleCell"
let topicLargeCellID = "HomeLargeCell"
let topicNoImageCellID = "HomeNoImageCell"
class HomeViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{

    var category:String?
    var newTopics:[NewsItem] = [NewsItem]()
    override func viewDidLoad(){
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.white
        self.setupUI()
        self.requestData()
    }
    func setupUI(){
        view.addSubview(tabView)
    }
    private lazy var tabView:UITableView = {
        let tab = UITableView(frame: CGRect(x:0,y:0,width:SCREENW,height:SCREENH-NavBarHeight-TabBarHeight), style: .plain)
        tab.delegate = self
        tab.dataSource = self
        tab.register(HomeSmallCell.self, forCellReuseIdentifier: topicSmallCellID)
        tab.register(HomeMiddleCell.self, forCellReuseIdentifier: topicMiddleCellID)
        tab.register(HomeLargeCell.self, forCellReuseIdentifier: topicLargeCellID)
        tab.register(HomeNoImageCell.self, forCellReuseIdentifier: topicNoImageCellID)
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
        
        if newsTopic.image_list.count != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: topicSmallCellID) as! HomeSmallCell
            cell.newsTopic = newsTopic
            cell.closeButtonClick(closure: { [weak self] (filterWords) in
                // closeButton 相对于 tableView 的坐标
                let point = self!.view.convert(cell.frame.origin, from: tableView)
                let convertPoint = CGPoint(x:point.x,y: point.y + cell.closeButton.y)
//                self!.showPopView(filterWords, point: convertPoint)
                })
            return cell
        } else {
            if newsTopic.middle_image?.height != nil {
                if newsTopic.video_detail_info?.video_id != nil || newsTopic.large_image_list.count != 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: topicLargeCellID) as! HomeLargeCell
                    cell.newsTopic = newsTopic
                    cell.closeButtonClick(closure: { [weak self] (filterWords) in
                        // closeButton 相对于 tableView 的坐标
                        
                        let point = self!.view.convert(cell.frame.origin, to: tableView)
                        let convertPoint = CGPoint(x:point.x,y: point.y + cell.closeButton.y)
//                        self!.showPopView(filterWords, point: convertPoint)
                        })
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: topicMiddleCellID) as! HomeMiddleCell
                    cell.newsTopic = newsTopic
                    cell.closeButtonClick(closure: { [weak self] (filterWords) in
                        // closeButton 相对于 tableView 的坐标
                        let point = self!.view.convert(cell.frame.origin, from: tableView)
                        let convertPoint = CGPoint(x:point.x,y: point.y + cell.closeButton.y)
//                        self!.showPopView(filterWords, point: convertPoint)
                        })
                    return cell
                }
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: topicNoImageCellID) as! HomeNoImageCell
                cell.newsTopic = newsTopic
                cell.closeButtonClick(closure: { [weak self] (filterWords) in
                    // closeButton 相对于 tableView 的坐标
                    let point = self!.view.convert(cell.frame.origin, from: tableView)
                    let convertPoint = CGPoint(x:point.x, y:point.y + cell.closeButton.y)
//                    self!.showPopView(filterWords, point: convertPoint)
                    })
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*servers*/
    func requestData(){
        let backend:HomeBackend = HomeBackend()
        print(category)
        backend.loadCatogoryContent(category: category!) { (topics) in
            self.newTopics = topics
            self.tabView.reloadData()
        }
    }
}
