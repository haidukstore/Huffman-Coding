//
//  HuffmamCodingTests.swift
//  HuffmamCodingTests
//
//  Created by Roman Haiduk on 3/26/19.
//  Copyright © 2019 Roman Haiduk. All rights reserved.
//

import XCTest
@testable import HuffmamCoding

class HuffmamCodingTests: XCTestCase {

    var huffman : HuffmanCoding!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        huffman = HuffmanCoding()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        huffman = nil
    }

    func testExample() {
       let bundle = Bundle(for: type(of: self))
        
        guard let path = bundle.path(forResource: "1", ofType: "txt") else { XCTFail("Path is Empty"); return }
        if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            let enc = try? huffman.Encrypt(data: data)
            print(enc?.encryptedData)
            XCTAssertFalse(enc?.encryptedData.count == 0)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
