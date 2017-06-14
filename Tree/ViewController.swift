//
//  AppDelegate.swift
//  Tree
//
//  Created by Dee on 15/05/17.
//  Copyright © 2017 Dee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var tv: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let root: TreeViewerDelegate = setup()
        let view = HierarchyScrollView(frame: self.view.bounds, andWithRoot: root)
        self.view.addSubview(view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Read Json:
    func readJson() -> [String: Any] {
        do {
            if let file = Bundle.main.url(forResource: "Sample", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    // json is a dictionary
                    print(object)
                    return object
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
        return [:]
    }

    func setup() -> TreeViewerDelegate {
        do {
            var rootInfo = readJson()
            //traverse the tree from plist and create node.
            var count: Int = 0
            var visited = [Any]()
            // a queue to insert visited nodes in.
            var root = Node(identifier: "i_\(count)", info: rootInfo)
            var queue = [Any]()
            var nodeQueue = [Any]()
            var nodes = [Any]()
        
            nodeQueue.append(root)
            queue.append(rootInfo)
            visited.append(rootInfo)
        
            while queue.count > 0 {
                var nodeInfo: [AnyHashable: Any]? = (queue[0] as? [AnyHashable: Any])
                var parent: Node? = (nodeQueue[0] as? Node)
                nodes.append(parent)
                queue.remove(at: 0)
                nodeQueue.remove(at: 0)
                for childInfo: Any in nodeInfo?["children"] as! [Any] {
                    do {
                        //if let value: Bool = try !visited.contains(where: childInfo as! (Any) throws -> Bool) {
                            count += 1
                            var node = Node(identifier: "i_\(count)", info: childInfo as! [AnyHashable : Any])
                            parent?.children.append(node)
                            nodeQueue.append(node)
                            queue.append(childInfo)
                            visited.append(childInfo)
                        //}
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        
            for i in 0..<nodes.count {
                var cell: CustomNodeView? = (tv.dequeueReusableCell(withIdentifier: "customCell") as? CustomNodeView)
                cell?.createView(with: (nodes[i] as? Node)!)
                var view: UIView? = cell?.customView
                (nodes[i] as? Node)?.nodeView = view
            }
        
            return root
        }
    }
}
