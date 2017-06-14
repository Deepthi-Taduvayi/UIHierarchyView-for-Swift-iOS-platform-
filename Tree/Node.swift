//
//  Node.swift
//  Tree
//
//  Created by Dee on 15/05/17.
//  Copyright © 2017 Dee. All rights reserved.
//

import UIKit

class Node: NSObject, TreeViewerDelegate {
    var children: [Node]
    var identifier: String
    var backgroundColor: UIColor?
    var startX: CGFloat
    var weight: CGFloat
    var nodeView: UIView?
    var name: String
    
    func viewTapped(_ recognizer: UITapGestureRecognizer) {
        print("\(identifier)")
    }
    
    init(identifier: String, andInfo info: [AnyHashable: Any], weight: CGFloat, startX: CGFloat, nodeView: UIView, backgroundColor: UIColor, children: [Node]) {
        name = info["orgName"] as! String
        self.identifier = identifier
        self.children = children
        self.startX = startX
        self.backgroundColor = backgroundColor
        self.nodeView = nodeView
        self.weight = weight
        super.init()
    }
    
    init(identifier: String, info: [AnyHashable: Any]) {
        name = info["orgName"] as! String
        self.identifier = identifier
        self.children = []
        self.startX = 0
        self.backgroundColor = UIColor.white
        self.weight = 0
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(children: [Any], andIdentifier identifier: String, andInfo info: [AnyHashable: Any], weight: CGFloat, startX: CGFloat, nodeView: UIView, backgroundColor: UIColor) {
        name = info["orgName"] as! String
        self.identifier = identifier
        self.children = [Any]() as! [Node] /* capacity: children.count */
        self.startX = startX
        self.backgroundColor = backgroundColor
        self.nodeView = nodeView
        self.weight = weight
        for child: Any in children {
            if (child is Node) {
                self.children.append(child as! Node)
            }
        }
        super.init()
    }
}



