//
//  RoomsTableViewCell.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/24/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit

class RoomsTableViewCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var salones:[Salon]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //Register NIB
        self.tableView.register(UINib.init(nibName: "RoomsPrototypeTableViewCell", bundle: nil), forCellReuseIdentifier: "RoomsPTVC")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Table View Cell
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return salones?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomsPTVC",for: indexPath as IndexPath) as! RoomsPrototypeTableViewCell
        cell.labName.text = salones![indexPath.item].edificio
        cell.roomName.text = "\(salones![indexPath.item].edificio)-\(salones![indexPath.item].numero)"
        return cell
    }
    
}
