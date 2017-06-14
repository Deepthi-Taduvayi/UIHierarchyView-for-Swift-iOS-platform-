//
//  TreeViewer.swift
//  Tree
//
//  Created by Dee on 19/05/17.
//  Copyright © 2017 Dee. All rights reserved.
//

import UIKit

class TreeViewer: UIView {
    var root: TreeViewerDelegate?
    var numOfNodes: CGFloat = 0
    
    let gap = CGSize(width: 20, height: 50)
    // Gap between cells in rows, also gap between rows
    let viewShift = CGPoint(x: 30,y :0)
    
//    // return the tree size.
//    private func calculateTreeSize(_ root: TreeViewerDelegate?) -> CGSize {
//    }
//    
//    //recursive method for updating the weights of tree nodes
//    //the weight value of a node = number of leaf nodes in this subtree.
//    private func updateWeights(forTree root: TreeViewerDelegate?) -> Int {
//    }

    // MARK: - drawing tree
    func drawArc(from node: TreeViewerDelegate?, withLevel row: CGFloat) {
        
        let thickness: CGFloat = 3.0
        //lines color
        let colorHex: Int = 0x939598
        let color = UIColor(red: CGFloat((Float((colorHex & 0xff0000) >> 16)) / 255.0), green: CGFloat((Float((colorHex & 0x00ff00) >> 8)) / 255.0), blue: CGFloat((Float((colorHex & 0x0000ff) >> 0)) / 255.0), alpha: CGFloat(1.0))
        let startX: CGFloat = node!.startX + viewShift.x
        // upper line
        // down from the node
        if row != 0 {
            let startEndX: CGFloat = startX + node!.nodeView!.bounds.size.width / 2
            let height: CGFloat = node!.nodeView!.bounds.size.height
            let startY: CGFloat = row * (gap.height + height) + 1.0 * height + 0.5 * gap.height + viewShift.y
            let start1 = CGPoint(x: startEndX, y: startY)
            
            let endY: CGFloat = row * (gap.height + height) + 1.0 * height + 1.0 * gap.height + viewShift.y
            let end1 = CGPoint(x: startEndX, y: endY)
            let line1 = UIBezierPath()
            line1.move(to: start1)
            line1.addLine(to: end1)
            line1.lineWidth = thickness
            color.setStroke()
            line1.stroke()
        }
        
        //Lower lines
        //T shape lines
        if node?.children.count != 0 {
            //vertical line
            //the vertical lines in the T shape lines
            let startEndX: CGFloat = startX + node!.nodeView!.bounds.size.width / 2
            let height: CGFloat = node!.nodeView!.bounds.size.height
            let startY: CGFloat = (row + 1) * (gap.height + height) + 1.0 * height + viewShift.y
            let start2 = CGPoint(x: startEndX, y: startY)
            
            let endY: CGFloat = (row + 1) * (gap.height + height) + 1.0 * height + 0.5 * gap.height + viewShift.y
            let end2 = CGPoint(x: startEndX, y: endY)
            let line2 = UIBezierPath()
            line2.move(to: start2)
            line2.addLine(to: end2)
            line2.lineWidth = thickness
            color.setStroke()
            line2.stroke()
            let firstChildX: CGFloat? = ((node?.children.first)?.startX)! + viewShift.x + (node?.nodeView?.bounds.size.width)! / 2
            let lastChildX: CGFloat? = ((node?.children.last)?.startX)! + viewShift.x + (node?.nodeView?.bounds.size.width)! / 2
            // horizontal line
            //the horizontal line in the T shape lines
            let start3 = CGPoint(x: CGFloat(firstChildX!), y: CGFloat((row + 1) * (gap.height + height) + 1.0 * height + 0.5 * gap.height + viewShift.y))
            let end3 = CGPoint(x: CGFloat(lastChildX!), y: CGFloat((row + 1) * (gap.height + height) + 1.0 * height + 0.5 * gap.height + viewShift.y))
            let line3 = UIBezierPath()
            line3.move(to: start3)
            line3.addLine(to: end3)
            line3.lineWidth = thickness
            color.setStroke()
            line3.stroke()
        }
    }
    
    // add the given view at the pre_calculated position
    func drawView(withStartX node: TreeViewerDelegate?, andRowWidth rowWidth: CGFloat, andRowNumber row: CGFloat) {
        let startX: CGFloat = (node?.startX)! + viewShift.x
        let startY: CGFloat = (row + 1) * (gap.height + (node?.nodeView?.bounds.size.height)!) + viewShift.y
        //TODO: remove this
        //    startX-= node.nodeView.bounds.size.width/2;
        //    startY-= node.nodeView.bounds.size.height/2;
        //
        node?.nodeView?.frame = CGRect(x: startX, y: startY, width: (node?.nodeView?.bounds.size.width)!, height: (node?.nodeView?.bounds.size.height)!)
        //[node.nodeView removeFromSuperview];
        self.addSubview((node?.nodeView)!)
        //add tapgesture to the view in the node
        addTapGesture(toView: node)
    }
    
    //add tapgesture to the view in the node and you should implement the handler in TreeViewerDelegate
        func addTapGesture(toView node: TreeViewerDelegate?) {
        let singleFingerTap = UITapGestureRecognizer(target: node, action: #selector(Node.viewTapped(_:)))
        node?.nodeView?.addGestureRecognizer(singleFingerTap)
    }
    
    //  Converted with Swiftify v1.0.6341 - https://objectivec2swift.com/
    // Return number of nodes in the tree.
    // BFS traversal for all nodes in the tree to count number of nodes in the tree.
    func getNumberOfNodes(inTree root: TreeViewerDelegate?) -> CGFloat {
        var count: CGFloat = 1
        var visited = [Any]()
        // a queue to insert visited nodes in.
        var queue = [Any]()
        queue.append(root)
        visited.append(root)
        while queue.count > 0 {
            let node: TreeViewerDelegate? = (queue[0] as? TreeViewerDelegate)
            queue.remove(at: 0)
            
            print(node?.children)
            
            if(node?.children != nil) {
                for child: Any in (node?.children)! {
                    do {
                        let value: Bool = try !visited.contains(where: child as! (Any) throws -> Bool)
                        if value {
                            queue.append(child)
                            visited.append(root)
                            count += 1
                        }
                    } catch {
                        print(error)
                    }
                }
            }
        }
        return count
    }
    
    //return max number in the array
    func getMax(_ values: [CGFloat]) -> CGFloat {
        var max: CGFloat = 0
        for num: CGFloat in values {
            if max < num {
                max = num
            }
        }
        return max
    }
    
    //return the tree height
    func getTreeHeight(_ root: TreeViewerDelegate?) -> CGFloat {
        if root?.children.count == 0 {
            return 1
        }
        var array = [Any]()
        for child: TreeViewerDelegate? in (root?.children)! {
            array.append(value: getTreeHeight(child))
        }
        return getMax(array as! [CGFloat]) + 1
    }
    
    //return struct that contains width and height of the tree
    func calculateTreeSize(_ root: TreeViewerDelegate?) -> CGSize {
        let levelsNum: CGFloat = getTreeHeight(root)
        let width: CGFloat = ((root?.weight)! * (root?.nodeView?.bounds.size.width)!) + (((root?.weight)! + 1) * gap.width) + viewShift.x
        return CGSize(width: width, height: CGFloat((levelsNum + 1) * (gap.height + (root?.nodeView?.bounds.size.height)!) + viewShift.y))
    }
    
    // Second Path:
    // A second dfs path to center internal nodes (parent) between it's children.
    
    func postOrderTraverse( node: TreeViewerDelegate, inRow row: CGFloat) {
        
        var node = node
        if node != nil {
            for child: TreeViewerDelegate in node.children {
                self.postOrderTraverse(node: child, inRow: row + 1)
            }
            // update internal node (parent) position
            if node.children.count != 0 {
                var firstNodeX = (node.children.first! as TreeViewerDelegate).startX
                var lastNodeX = (node.children.last! as TreeViewerDelegate).startX
                let value: CGFloat = firstNodeX + (lastNodeX - firstNodeX) / 2
                node.startX = value
                print("parent start X: \(node.startX)")
                var rowWidth = node.weight * ((node.nodeView?.bounds.size.width)! + gap.width) - gap.width + (gap.width)
                self.drawView(withStartX: node, andRowWidth: rowWidth, andRowNumber: row)
                print("Node # \(node.identifier): first child start X: \(firstNodeX), last child start X: \(lastNodeX), num of children : \(node.children.count)")
            }
            // draw outgoing lines for the node
            self.drawArc(from: node, withLevel: row)
        }
    }
    
    
    func dfSearchForNode( root: TreeViewerDelegate, withRowNumber row: Int, withRows rowsStart: [CGFloat]) {
        // visit and draw node
        var rowsStart = rowsStart
        var root = root
        var rowWidth = root.weight * ((root.nodeView?.bounds.size.width)! + gap.width) - gap.width + (gap.width)
        if root.children.count == 0 {
            self.drawView(withStartX:root , andRowWidth: rowWidth, andRowNumber: CGFloat(row))
        }
        for var child: TreeViewerDelegate in root.children {
            // if the node is starting node in the row then initialize the row with the parents padding.
            if row + 1 > CInt(rowsStart.count) {
                rowsStart.append(root.startX)
            }
            if root.startX > rowsStart[row] {
                child.startX = root.startX
                rowsStart[row] = root.startX
            }
            else {
                child.startX = rowsStart[row]
            }
            var rowWidth = child.weight * ((child.nodeView?.bounds.size.width)! + gap.width) - gap.width + (gap.width)
            var rowStartX = rowsStart[row] + rowWidth
            rowsStart[row] = CGFloat(rowStartX)
            //traverse other nodes
            self.dfSearchForNode(root: child, withRowNumber: row + 1, withRows: rowsStart)
        }
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        var visited = [Any]() /* capacity: numOfNodes */
        for i in stride(from: 0 as CGFloat, to: numOfNodes, by: +1 as CGFloat) {
            visited.append(0)
        }
        //two paths for calculating the node start position and size and for drawing the view in the node
        self.dfSearchForNode(root: root!, withRowNumber: 0, withRows: [CGFloat]())
        postOrderTraverse(node: root!, inRow: 0)
    }
    
    //recursive method for updating the weights of tree nodes
    //the weight value of a node = number of leaf nodes in this subtree
    func updateWeights(forTree root: TreeViewerDelegate?) -> CGFloat {
        var value = root
        if value?.children.count == 0 {
            value?.weight = 1
            return 1
        }
        for child: Any in (value?.children)! {
            value?.weight += updateWeights(forTree: child as? TreeViewerDelegate)
        }
        return (value?.weight)!
    }

    // MARK: - initialization
    init(frame: CGRect, andWithRoot root: TreeViewerDelegate?) {
        self.root = root
        super.init(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(0), height: CGFloat(0)))
        let numOfNodes: CGFloat = getNumberOfNodes(inTree: root)
        self.numOfNodes = numOfNodes
        updateWeights(forTree: root)
        let treeSize: CGSize = calculateTreeSize(root)
        self.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(treeSize.width), height: CGFloat(treeSize.height))
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
