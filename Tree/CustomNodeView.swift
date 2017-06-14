//
//  CustomNodeView.swift
//  Tree
//
//  Created by Dee on 19/05/17.
//  Copyright © 2017 Dee. All rights reserved.
//

import UIKit

class CustomNodeView: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var customView: UIView!
    
    func createView(with node: Node) {
        titleLabel?.text = node.name
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
}
