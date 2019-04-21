//
//  priorityQueue.swift
//  HuffmamCoding
//
//  Created by Roman Haiduk on 3/26/19.
//  Copyright © 2019 Roman Haiduk. All rights reserved.
//

struct PriorityArray {
    
    
    private var elements : Data
    private var dictionaryElemWithFreq : [UInt8 : UInt64]
    public var frequencyQueue : [(key: UInt8, value: UInt64)]?
    
    
    init(elements: Data) { // 1 // 2
        self.elements = elements
        dictionaryElemWithFreq = [UInt8 : UInt64]()
        createDictionary()
        sort()
    }
    
    
    private mutating func createDictionary() {
        if !elements.isEmpty {
            for element in elements {
                if let result = dictionaryElemWithFreq[element] {
                    dictionaryElemWithFreq[element] = result + 1
                }
                else { dictionaryElemWithFreq[element] = 1 }
            }
        }
        else {
            print("Data array is empty")
            return
        }
    }
    
    private mutating func sort(){
        frequencyQueue = dictionaryElemWithFreq.sorted { $0.1 < $1.1 }
        if frequencyQueue == nil {
            print("Unfortunatly cast dictionary to array(UInt8, UInt64)")
        }
    }
}
