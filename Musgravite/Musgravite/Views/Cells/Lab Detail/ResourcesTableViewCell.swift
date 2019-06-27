//
//  ResourcesTableViewCell.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 26/06/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit
import QuickLook

class ResourcesTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource, QLPreviewControllerDelegate, QLPreviewControllerDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var documents:[String]?
    private var slsfile:NSURL?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib.init(nibName: "ResourcesModifiedTableViewCell", bundle: nil), forCellReuseIdentifier: "ResourcesMTVC")
        // Sections
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResourcesMTVC", for: indexPath) as! ResourcesModifiedTableViewCell
        let cellname = SchoolSearchVM.extractAndBreakFilenameInComponents(fileURL: URL(string: self.documents![indexPath.item])!)
        cell.documentTitle.text = cellname.0
        cell.documentExtension.text = "\(cellname.1.uppercased()) file"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filetd:URL = URL(string: self.documents![indexPath.item])!
        NetworkActionsController.downloadFile(filetd, completionBlock: ({(fileURL) in
            if fileURL == nil {
                fatalError()
            } else {
                let quickLookController = QLPreviewController()
                quickLookController.dataSource = self
                quickLookController.delegate = self
                self.slsfile = fileURL
                UIApplication.shared.keyWindow?.rootViewController!.present(quickLookController, animated: true)
            }
        }))
    }
    
    //MARK: Quick Look Data Source
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return slsfile!
    }
}
