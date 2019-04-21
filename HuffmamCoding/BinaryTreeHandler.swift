//
//  BinaryTree.swift
//  HuffmamCoding
//
//  Created by Roman Haiduk on 3/26/19.
//  Copyright © 2019 Roman Haiduk. All rights reserved.
//

struct BinaryTreeHandler {
    
    private var saplingOfTree : [BinaryTree]
    private var array : [(el : UInt8, freq:  UInt64)]
    private var tree : BinaryTree?
    
    init(priorityArray array : [(UInt8, UInt64)]) {
        self.array = array
        saplingOfTree = [BinaryTree]()
        initialTree()
        self.array.removeAll()
        buildTree()
        tree = saplingOfTree[0]
    }
    
    func getTree() -> BinaryTree? {
        if let tree = tree {
            return tree
        }
        else { return nil}
    }
    
    private mutating func initialTree(){
        for element in array {
            saplingOfTree.append(BinaryTree(element: element.el, frequency: element.freq))
        }
    }
    
    private mutating func buildTree() {
        
        while saplingOfTree.count != 1 {
            let summaryFrequency = saplingOfTree[0].getValue() + saplingOfTree[1].getValue()
            let createdNode = BinaryTree(summaryFrequency: summaryFrequency, leftNode: saplingOfTree[0], rightNode: saplingOfTree[1])
            
            if let indexToInsert = saplingOfTree.firstIndex(where:
                { $0.getValue() >= summaryFrequency}) {
                saplingOfTree.insert(createdNode, at: indexToInsert)
                
            } else {
                saplingOfTree.insert(createdNode, at: saplingOfTree.endIndex)
            }
            if saplingOfTree.count >= 3 {
                saplingOfTree.removeSubrange(0...1)
            } else {
                saplingOfTree.removeFirst()
            }
            
        }
    }
}

open class  BinaryTree : Codable {
    
    var extraBitsCount = 0 ///The property shows the number of extra bits in the last byte when decrypting
    
    private var key : UInt8?
    private var value : UInt64
    private var leftNode : BinaryTree?
    private var rightNode : BinaryTree?
    
    init(element : UInt8, frequency : UInt64) {
        key = element
        value = frequency
    }
    init(summaryFrequency : UInt64, leftNode : BinaryTree, rightNode : BinaryTree) {
        self.leftNode = leftNode
        self.rightNode = rightNode
        value = summaryFrequency
    }
    
    func isNode () -> Bool {
        return key == nil
    }
    
    
    func getKey() -> UInt8 {
        return self.key!
    }
    
    
    func getValue() -> UInt64 {
        return value
    }
    
    func getLeftIndex() -> BinaryTree? {
        return leftNode
    }
    
    func getRightIndex() -> BinaryTree? {
        return rightNode
    }
}
