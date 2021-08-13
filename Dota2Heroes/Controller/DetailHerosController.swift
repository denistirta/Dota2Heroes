//
//  DetailHerosController.swift
//  Dota2Heroes
//
//  Created by DenisTirta on 13/08/21.
//

import UIKit
import SDWebImage

class DetailHerosController: UIViewController {

    var tableList = UITableView()
    var header = HeaderDetailView()
    var footer = FooterListView()
    
    var list: ListHeros?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHeader()
        setupTable()
        setupFooter()
    }
    
    private func setupHeader(){
        header = Bundle.main.loadNibNamed(HeaderDetailView.className, owner: nil, options: nil)?.first as! HeaderDetailView
        
        header.bgImg?.sd_imageIndicator = SDWebImageActivityIndicator.gray
        print("check hero = \(BaseImg)\(self.list?.getBackgraundHero() ?? "").jpg")
        header.bgImg.sd_setImage(with: URL(string: "\(BaseURL)\(self.list?.img ?? "")"), placeholderImage: UIImage(named: "bgImg"), options: .refreshCached)

        switch self.list?.primaryAttr {
        case "str":
            header.icAttribute.image = UIImage(named: "hero_strength")
            header.valueAttribute.text = "strength".uppercased()
        case "agi":
            header.icAttribute.image = UIImage(named: "hero_agility")
            header.valueAttribute.text = "agility".uppercased()
        case "int":
            header.icAttribute.image = UIImage(named: "hero_intelligence")
            header.valueAttribute.text = "intelligence".uppercased()
        default:
            header.icAttribute.image = UIImage(named: "")
        }
        
        header.nameHero.text = self.list?.localizedName ?? ""
        header.valueType.text = self.list?.attackType?.uppercased()
        
        header.imgHero?.sd_imageIndicator = SDWebImageActivityIndicator.gray
        header.imgHero.sd_setImage(with: URL(string: "\(BaseURL)\(self.list?.img ?? "")"), placeholderImage: UIImage(named: "icDefault"), options: .refreshCached)
        
        header.delegate = self
        self.view.addSubview(header)

        header.translatesAutoresizingMaskIntoConstraints = false
        header.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
        header.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
        header.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0.0).isActive = true
    }
    
    private func setupTable(){
        tableList.delegate = self
        tableList.dataSource = self
        tableList.separatorStyle = .none
        tableList.isScrollEnabled = false
        tableList.register(UINib(nibName: listDetailCell.className, bundle: nil), forCellReuseIdentifier: listDetailCell.className)
        self.view.addSubview(tableList)

        tableList.translatesAutoresizingMaskIntoConstraints = false
        tableList.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
        tableList.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
        tableList.topAnchor.constraint(equalTo: self.view.topAnchor, constant: header.bgView.bounds.height).isActive = true
        tableList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
    }
    
    private func setupFooter(){
        footer = Bundle.main.loadNibNamed(FooterListView.className, owner: nil, options: nil)?.first as! FooterListView
        footer.btnFooter.setTitle("Save Favorite", for: .normal)
        footer.delegate = self
        self.view.addSubview(footer)

        footer.translatesAutoresizingMaskIntoConstraints = false
        footer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
        footer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
        footer.bottomAnchor.constraint(equalTo: self.view.safeBottomAnchor, constant: 32.0).isActive = true
    }
    
}

extension DetailHerosController: HeaderDetailViewDelegate{
    func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension DetailHerosController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
            
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: listDetailCell.className, for: indexPath) as! listDetailCell
        
        switch indexPath.row {
        case 0:
            var roles = ""
            let count = self.list?.roles?.count ?? 0
            for i in 0..<count{
                if i == count-1{
                    roles.append("\(self.list?.roles?[i] ?? "")")
                }else{
                    roles.append("\(self.list?.roles?[i] ?? ""), ")
                }
            }
            
            cell.label.text = "ROLES"
            cell.value.text = roles
        case 1:
            cell.label.text = "BASE HEALTH"
            cell.value.text = "\(self.list?.baseHealth ?? 0)"
        case 2:
            cell.label.text = "BASE ATTACK"
            cell.value.text = "\(self.list?.baseAttackMax ?? 0)"
        case 3:
            cell.label.text = "BASE MANA"
            cell.value.text = "\(self.list?.baseMana ?? 0)"
        case 4:
            cell.label.text = "BASE SPEED"
            cell.value.text = "\(self.list?.moveSpeed ?? 0)"
        default:
            cell.label.text = ""
            cell.value.text = ""
        }

        cell.selectionStyle = .none
        return cell
    }
}

extension DetailHerosController: FooterListViewDelegate{
    func actionFooter() {
        
    }
}
