//
//  HomeVC.swift
//  playoAssignment
//
//  Created by Sparsh Singh on 04/07/22.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        addRefreshControl()
    }
    
    func addRefreshControl() {
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        }
        
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.black.withAlphaComponent(0.3)
        refreshControl.attributedTitle = NSAttributedString(string: "Updating News...", attributes: .none)
        
       
    }
    
    @objc func refreshData(_ sender: Any) {
        //UPDATE NEWS HERE
    }
    
   

}

// MARK: - TABLE VIEW DELGATES

extension HomeVC : UITableViewDelegate, UITableViewDataSource {
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230.0
    }
     
}

// MARK: - API INTEGRATION


