//
//  HierarchyScrollView.swift
//  Tree
//
//  Created by Dee on 19/05/17.
//  Copyright © 2017 Dee. All rights reserved.
//

import UIKit

class HierarchyScrollView: UIScrollView, UIScrollViewDelegate {
    var treeView: UIView?
    
    // return the scrollable view.
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return treeView!
    }
    
    init(frame: CGRect, andWithRoot root: TreeViewerDelegate?) {
        // The scroll view that contains the tree.
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
        minimumZoomScale = 0.1
        maximumZoomScale = 2.0
        delegate = self
        contentSize = frame.size
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapScreen))
        tapGesture.numberOfTapsRequired = 2
        addGestureRecognizer(tapGesture)
        treeView = TreeViewer(frame: frame, andWithRoot: root)
        // Set scrollview background to provided background color from the user or with white color as a default color.
        treeView?.backgroundColor = UIColor.white
        addSubview(treeView!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Double tapping resize the view.
    @IBAction func tapScreen(_ sender: UITapGestureRecognizer) {
        zoomScale = 0.6
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        zoomScale = 0.6
        backgroundColor = UIColor.white
    }
}
