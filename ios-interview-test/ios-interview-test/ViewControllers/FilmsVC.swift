//
//  Films.swift
//  ios-interview-test
//

import UIKit

class FilmsVC: UIViewController {
    
    // MARK: Variables
    
    private let cellId = "filmCell"
    private let tableView: UITableView = UITableView()
    private let filmCategory: FilmCategory
    
    // MARK: init Methods
        
    init? (category: FilmCategory) {
        self.filmCategory = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Model Declaration
    
    lazy var viewModel: FilmViewModel = {
        return FilmViewModel(uid: filmCategory.uid)
    }()
    
    // MARK: Custom Methods

    func createUI() {
        
        title = filmCategory.category.rawValue
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        func setupTableView() {
            
            let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
            let displayWidth: CGFloat = view.frame.width
            let displayHeight: CGFloat = view.frame.height
            
            tableView.frame = CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight)
            tableView.separatorColor = .lightGray
            tableView.register(FilmCell.self, forCellReuseIdentifier: cellId)
            
            tableView.dataSource = self
            tableView.delegate = self
            view.addSubview(tableView)
        }
        
        setupTableView()
    }
    
    func fetchViewModel() {
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
//        viewModel.initFetch()
    }
    
    // MARK: View Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.createUI()
        self.fetchViewModel()
 
    }
    
}

extension FilmsVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FilmCell
        
        let cellVM = viewModel.getCellViewModel( at: indexPath )
        cell.update(film: cellVM)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellVM = viewModel.getCellViewModel( at: indexPath )
        guard let filmDetailVC = FilmDetailVC.init(film: cellVM) else {
            return
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(filmDetailVC, animated: true)
    }
    
}
