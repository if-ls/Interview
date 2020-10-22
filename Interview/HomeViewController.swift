//
//  HomeViewController.swift
//  Interview
//
//  Created by Wang on 2020/10/21.
//  Copyright © 2020 if-ls. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tv: UITableView!
    
    var ds: [String] = []
    var resp: [String: String] = [:] {
        didSet {
            self.ds = [String](self.resp.keys)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let timer = Timer(timeInterval: 5, repeats: true) { (t) in
            if let url = URL(string: "https://api.github.com") {
                
                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    
                    if let d = data {
                        if let dict = try? JSONSerialization.jsonObject(with: d, options: .mutableContainers) as? [String: String] {
                            self.resp = dict
                            DispatchQueue.main.async {
                                self.tv.reloadData()
                            }
                        }
                    } else {
                        print("error")
                    }
                }
                task.resume()
            }
        }
        
        RunLoop.current.add(timer, forMode: .common)
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell")!
        
        let key = self.ds[indexPath.row]
        cell.textLabel?.text = key
        cell.detailTextLabel?.text = self.resp[key]
        
        return cell
    }
}
