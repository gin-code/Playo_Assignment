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
    
    var articles : [Article] = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        addRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getNews()
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
        getNews()
    }
    
    
    func displayAlert(message: String) {
        let alertController = UIAlertController(title: "Playo - NewsApp", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            print("You've pressed OK Button")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
}


// MARK: - TABLE VIEW DELGATES

extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !articles.isEmpty {
            return articles.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        
        if !articles.isEmpty {
            
            cell.authorLabel.text = "Authored by - \(articles[indexPath.row].author!)"
            cell.descriptionTextview.text = articles[indexPath.row].description
            cell.titleLabel.text = articles[indexPath.row].title
            
            Extensions.downloadImageFromURl(UrlString: articles[indexPath.row].urlToImage ?? "", image: cell.newsImage)
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "WebViewVC") as! WebViewVC
        vc.urlString = articles[indexPath.row].url ?? ""
        navigationController?.pushViewController(vc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230.0
    }
    
}

// MARK: - API INTEGRATION

extension HomeVC {
    
    func getNews() {
        
        self.refreshControl.endRefreshing()
        self.showHUD()
        
        NetworkClass.shared.apiRequest(url: NetworkClass.shared.newsUrl, params:[:], method: "GET", responseObject: DataModel.self, callBack: Callback(onSuccess: { (responce) in
            
            self.dismissHUD()
            
            if responce.status == "ok" {
                
                DispatchQueue.main.async { [weak self] in
                    
                    self?.articles.removeAll()
                    self?.articles = responce.articles
                    self?.tableView.reloadData()
                    
                }
                
            } else {
                DispatchQueue.main.async {
                    self.displayAlert(message: "Plese refresh or retry later.")
                }
                
            }
            
        }, onFailure: { (error) in
            print("Error")
            self.dismissHUD()
            DispatchQueue.main.async {
                self.displayAlert(message: "Some went worng, please try after some time")
            }
        }))
        
    }
    
}

