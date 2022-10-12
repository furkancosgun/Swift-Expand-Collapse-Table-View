//
//  ViewController.swift
//  MVVM-DovizApp
//
//  Created by Furkan on 12.10.2022.
//

import UIKit

class ViewController: UIViewController {

    let parser = Parser()
    var currencies = [[String]]()
    var currency = [Currency]()
    var hiddenSections = Set<String>()
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        parser.parse(comp: { data in
            self.currency = data
            for i in data {
                let cur : [String] = ["Alış: \(i.buying!)","Satış: \(i.selling!)","Degisim: %\(i.rate!)"]
                self.currencies.append(cur)
            }
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
        })
        tblView.dataSource = self
        tblView.delegate = self
    }
  
    @objc
    private func hideSection(sender: UIButton) {
        let section = sender.tag
        
        func indexPathsForSection() -> [IndexPath] {
            var indexPaths = [IndexPath]()
            
            for row in 0..<self.currencies[section].count {
                indexPaths.append(IndexPath(row: row,
                                            section: section))
            }
            
            return indexPaths
        }
        
     
        if self.hiddenSections.contains(String(section)) {
            self.hiddenSections.remove(String(section))
              self.tblView.insertRows(at: indexPathsForSection(),
                                        with: .fade)
        } else {
              self.hiddenSections.insert(String(section))
              self.tblView.deleteRows(at: indexPathsForSection(),
                                        with: .fade)
        }
       
    }

}
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(self.currencies[indexPath.section][indexPath.row])"
        cell.tintColor = .systemIndigo
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.hiddenSections.contains(String(section)) {
            return 0
        }
        return self.currencies[section].count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionButton = UIButton()
        sectionButton.setTitle(currency[section].name,
                               for: .normal)
        sectionButton.backgroundColor = .systemIndigo
        sectionButton.tag = section
        sectionButton.addTarget(self,
                                action: #selector(self.hideSection(sender:)),
                                for: .touchUpInside)
        return sectionButton
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return currencies.count
    }
}

