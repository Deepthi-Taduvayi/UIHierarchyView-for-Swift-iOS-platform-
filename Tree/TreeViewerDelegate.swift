//
//  TreeViewerDelegate.swift
//  Tree
//
//  Created by Dee on 19/05/17.
//  Copyright © 2017 Dee. All rights reserved.
//

import UIKit


protocol TreeViewerDelegate {
    // MARK: - view parameters:
    // a custom view that user want for each node.
    var nodeView: UIView? { get set }
    // the weight of the node (number of leaf children).
    var weight: CGFloat { get set }
    // start x position of node.
    var startX: CGFloat { get set }
    // background of the container view of nodes
    var backgroundColor: UIColor? { get set }
    // MARK: - data parameters:
    // this is a unique identifier for the node
    var identifier: String { get }
    // array of node children
    var children: [Node] { get }
    // MARK: - listners:
    // here we handle tapping the view
    func viewTapped(_ recognizer: UITapGestureRecognizer)
}


