//
//  SchoolSearchViewController.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 6/24/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//

import UIKit

class SchoolSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
