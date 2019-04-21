//
//  HuffmanCoding.swift
//  HuffmamCoding
//
//  Created by Roman Haiduk on 3/26/19.
//  Copyright © 2019 Roman Haiduk. All rights reserved.
//


public class HuffmanCoding  {

    ///Compresses data with Huffman algorithm. Returns copmressed data and Huffamn tree object.
    open func Encrypt(data : Data)
                            throws -> (encryptedData : Data, huffmanTree : BinaryTree)  {
        
            // Create priority queue, where element has data byte and it`s frequency in the file
        if let priorityArray = PriorityArray(elements: data).frequencyQueue {
            // Сreate a tree from the priority queue
            guard let tree = BinaryTreeHandler(priorityArray: priorityArray).getTree()
                                                            else { throw fatalError("HuffmanCoding Error! Binary Tree didn`t handle.") }
            // Get a Huffman table from the tree, where element has data byte and it`s encrypted valuse
            let table = HuffmanTable(tree: tree).getTable()
            // Create resulting encrypted data bit by bit
            let resultEncrypring = createEncryptedSequencyWithTable(table: table, data: data)
            // Extra bit shows how many bits need ignore from end when decrypt this data
            tree.extraBitsCount = resultEncrypring.extraBits
            
            return (resultEncrypring.encryptedData, tree)
        }
        throw fatalError("HuffmanCoding Error! Priority array didn`t create.")
    }
    

    ///Decompresses data with Huffman algorithm. Get compressed data and Huffman tree object and returns source data
    open func Decrypt(data : Data, tree : BinaryTree) -> Data {

        var sourceData = Data()
        
        var tempTree = tree
        
        //Handle main encrypted data
        for index in 0..<(data.count-1) {
            
            var byte = data[index]
            
            var counter = 0         // Counter shows how many bits was read
            
            while counter != 8 {    // If 8 bits was wrote to Data, reset this variable
                
                bitHandlerWithTree(&tempTree, &byte, tree, &counter, &sourceData)
            }
        }
        
        //Handle last byte with possible having extra bits
        var byte = data[data.count - 1]
        var counter = 0
        
        while counter != (8 - tree.extraBitsCount) || !tempTree.isNode() {
            
            bitHandlerWithTree(&tempTree, &byte, tree, &counter, &sourceData)
        }
        
        return sourceData       // Return source data
    }
    
    ///Method which compares first bit in current byte with mask and get result from tree
    fileprivate func bitHandlerWithTree(_ tempTree: inout BinaryTree, _ byte: inout UInt8, _ tree: BinaryTree, _ counter: inout Int, _ sourceData: inout Data) {
        if tempTree.isNode() {
            let b = byte & 0b10000000       // Comparing byte`s current value with mask
            byte <<= 1                      // Do offset on the future
            if b == 0 { tempTree = tempTree.getLeftIndex() ?? tree } // if result of comparing is equal '0'
            else { tempTree = tempTree.getRightIndex() ?? tree }     //we are going to Left Node of tree else to Right
            counter += 1
        }
        else {
            sourceData.append(tempTree.getKey())        // Add decrypted byte
            tempTree = tree                             // return to main tree Node
        }
    }
    
    ///Return encrypted data and extra bits in result Data
    fileprivate func createEncryptedSequencyWithTable(table : [UInt8 : [Bool]], data : Data)
        -> (encryptedData : Data, extraBits : Int) {
            
            var encryptedData = Data()    // Create array for encrypted bytes
            
            var tempByte : UInt8 = 0    //Variable store encrypted byte, created bit by bit
            var offsetCounter = 0       //Variable shows offset to know how many bits wrote
            for byte in data {
                
                if let bits = table[byte] { // Get array of bool, where false is '0' and true is '1'
                    
                    for flag in bits {      // Iterate every array`s bool value
                        
                        tempByte <<= 1      // Do offset to write necessary bit
                        if flag {
                            tempByte |= 1   // Write '1' if flag equale 'true'
                        }
                        
                        offsetCounter += 1
                        
                        if offsetCounter == 8 {             // Add prepared byte to encrypted Data, reset variables
                            encryptedData.append(tempByte)
                            tempByte = 0
                            offsetCounter = 0
                        }
                    }
                } else { print("Call Fixikov") }
            }
            return (encryptedData, offsetCounter) // Return encrypted data and extra bits in result Data
            
            
            
    }
}
