//
//  HuffmanTable.swift
//  HuffmamCoding
//
//  Created by Roman Haiduk on 3/27/19.
//  Copyright © 2019 Roman Haiduk. All rights reserved.
//


/// Class presents the object, for creating dictionary, where key is data byte, value is tree path to it.
/// Left Node is 'false' value, Right Node is 'true' value
class HuffmanTable {
    
    private var tempTree : BinaryTree
    private var table : [UInt8 : [Bool]]
    
    init(tree : BinaryTree) {
        self.tempTree = tree
        table = [UInt8 : [Bool]]()
        var arrayPath = [Bool]()
        goRoundTree(node: tempTree, elementPath: &arrayPath)
    }
    
    func getTable() -> [UInt8 : [Bool]] {
        return table
    }
    
    
    ///The function for traversing the tree by elements and writing the path to the boolean array.
    ///Where the move to the left is 'false' value, and the move to the right is 'true' value.
    fileprivate func goRoundTree(node : BinaryTree, elementPath : inout [Bool]) {
        if node.isNode() {
            
            if let temp = node.getLeftIndex() {
                elementPath.append(false)
                goRoundTree(node: temp, elementPath: &elementPath)
                if elementPath.count > 0 {
                    elementPath.removeLast()
                }
            }
            
            if let temp = node.getRightIndex() {
                elementPath.append(true)
                goRoundTree(node: temp, elementPath: &elementPath)
                if elementPath.count > 0 {
                    elementPath.removeLast() }
            }
            
        } else {
            let value = node.getKey()
            table[value] = elementPath
            return
        }
    }
}
