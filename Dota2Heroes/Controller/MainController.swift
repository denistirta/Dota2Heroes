//
//  MainController.swift
//  Dota2Heroes
//
//  Created by DenisTirta on 12/08/21.
//

import UIKit

class MainController: UIViewController {

    var tableList = UITableView()
    var header = filterHeader()
    var search = SearchView()
    var footer = FooterListView()
    var collection = CollectionHerosList()
    
    var list: [ListHeros]?
    var selectedAttribure = -1
    var rolesAll = [String]()

    var searchKey = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callAPI()
        setupHeader()
        setupSearch()
        setupTable()
        setupFooter()
    }
    
    private func setupHeader(){
        header = Bundle.main.loadNibNamed(filterHeader.className, owner: nil, options: nil)?.first as! filterHeader
        header.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 20)
        header.delegate = self
        self.view.addSubview(header)

        header.translatesAutoresizingMaskIntoConstraints = false
        header.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
        header.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
        header.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0.0).isActive = true
    }
    
    private func setupSearch(){
        search = Bundle.main.loadNibNamed(SearchView.className, owner: nil, options: nil)?.first as! SearchView
        search.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 20)
        search.delegate = self
        self.view.addSubview(search)

        search.translatesAutoresizingMaskIntoConstraints = false
        search.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
        search.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
        search.topAnchor.constraint(equalTo: self.view.topAnchor, constant: header.bgView.bounds.height + 8).isActive = true
    }
    
    private func setupTable(){
        tableList.delegate = self
        tableList.dataSource = self
        tableList.separatorStyle = .none
        tableList.register(UINib(nibName: CollectionHerosList.className, bundle: nil), forCellReuseIdentifier: CollectionHerosList.className)
        self.view.addSubview(tableList)

        tableList.translatesAutoresizingMaskIntoConstraints = false
        tableList.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
        tableList.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
        tableList.topAnchor.constraint(equalTo: self.view.topAnchor, constant: header.bgView.bounds.height + 8 + search.search.bounds.height).isActive = true
        tableList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
        
        self.view.bringSubviewToFront(header)
    }
    
    private func setupFooter(){
        footer = Bundle.main.loadNibNamed(FooterListView.className, owner: nil, options: nil)?.first as! FooterListView
        footer.delegate = self
        self.view.addSubview(footer)

        footer.translatesAutoresizingMaskIntoConstraints = false
        footer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
        footer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
        footer.bottomAnchor.constraint(equalTo: self.view.safeBottomAnchor, constant: 32.0).isActive = true
    }
    
    private func callAPI(){
        AFReq(url: HerosEndPoint.list(), view: self.view) { status, JSON, statusCode in
            if status{
                print("sukses herostats = \(JSON)")
                
                do {
                    self.list = try JSONDecoder().decode([ListHeros].self, from: JSON.rawData())
                } catch {
                    print("check decode herostats = \(error)")
                }
                
                self.tableList.reloadData()
            }else{
                print("error herostats = \(JSON)")
            }
        }
    }
}

extension MainController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
            
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectionHerosList.className, for: indexPath) as! CollectionHerosList
        
        if self.list?.count ?? 0 > 0{
            cell.selectedAttribute = selectedAttribure
            cell.search = searchKey
            cell.list = self.list
            cell.setupColletion()
        }
        
        cell.delegate = self
        return cell
    }
    
}

extension MainController: filterHeaderDelegate{
    func actionAttribute(index: Int) {
        selectedAttribure = index
        header.selectedAttribute = index
        header.collectionList.reloadData()
        tableList.reloadData()
    }
}

extension MainController: CollectionHerosListDelegate{
    func actionDetail(value: ListHeros?) {
        let controller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: DetailHerosController.className) as! DetailHerosController
        controller.list = value
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension MainController: FooterListViewDelegate{
    func actionFooter() {
        
    }
}

extension MainController: SearchViewDelegate{
    func textValueDidInput(value: String) {
        print("check search = \(value)")
        searchKey = value
        tableList.reloadData()
    }
}
