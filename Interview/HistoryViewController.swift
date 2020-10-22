//
//  HistoryViewController.swift
//  Interview
//
//  Created by Wang on 2020/10/22.
//  Copyright © 2020 if-ls. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var tv: UITableView!
    
    var ds: [History] = []
    var refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        refresh.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        tv.addSubview(refresh)
        
        ds = History.fetch()
        tv.reloadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(canRefresh), name: NSNotification.Name("CanRefresh"), object: nil)
    }
    
    @objc func fetchData() {
        ds = History.fetch()
        tv.reloadData()
        refresh.endRefreshing()
        self.title = "历史记录"
    }
    
    @objc func canRefresh() {
        self.title = "可下拉刷新"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell")!
        
        let his = self.ds[indexPath.row]
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        cell.textLabel?.text = df.string(from: Date(timeIntervalSince1970: his.timestamp))
        cell.detailTextLabel?.text = his.url
        
        if his.status {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        if indexPath.row == 0 {
            cell.backgroundColor = UIColor.lightGray
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
}
