//
//  ListViewController.swift
//  OnTheMap
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 19/10/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var items: [StudentLocation] = []
    
    enum ListTableCell: String {
        case listStudentTableViewCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        StudentLocationClient.getStudentsLocations { (success) in
            if success {
                self.items = MemoryStorage.shared.studentsLocations
                self.tableView.reloadData()
                
                // trick because table view is not working properly
                self.tableView.scrollToRow(at: IndexPath(row: self.items.count-1, section: 0), at: .top, animated: false)
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func jsonObject(_ data: Data?) -> AnyObject?{
        if let data = data {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                return json as AnyObject?
            } catch {
                print("error serializing JSON: \(error)")
            }
        }
        
        return nil
    }

}

// MARK: - TableView Delegate and Data Source

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ListTableCell.listStudentTableViewCell.rawValue, for: indexPath) as? ListStudentTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? ListStudentTableViewCell {
            cell.confugureCell(with: items[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presentWebPageInSafari(withURLString: items[indexPath.row].mediaURL)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}
