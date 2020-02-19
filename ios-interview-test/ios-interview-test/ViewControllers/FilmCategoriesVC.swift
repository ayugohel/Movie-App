//
//  FilmCategoriesVC.swift
//  ios-interview-test
//

import UIKit

class FilmCategoriesVC : UIViewController {
    
    // MARK: UI Variables

    private let tableView: UITableView = UITableView()
    
    // MARK: Variables

    private let cellId = "categoryCell"
    private let categories: [FilmCategory] = FilmCategory.allCategories()

    // MARK: Custom Methods
    
    func createUI() {
        
        title = "Film Category"
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        func setupTableView() {
            
            let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
            let displayWidth: CGFloat = view.frame.width
            let displayHeight: CGFloat = view.frame.height
            
            tableView.frame = CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight - barHeight)
            tableView.separatorColor = .lightGray
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
            
            tableView.dataSource = self
            tableView.delegate = self
            view.addSubview(tableView)
        }
        
        setupTableView()
    }
    
    // MARK: View Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createUI()

    }

}

// MARK: UITableViewDelegate, UITableViewDataSource Methods

extension FilmCategoriesVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].category.rawValue
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let filmVC = FilmsVC.init(category: categories[indexPath.row]) else {
            return
        }

        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(filmVC, animated: true)
    }
    
}
