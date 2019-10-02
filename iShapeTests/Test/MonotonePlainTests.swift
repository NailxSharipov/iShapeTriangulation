//
//  MonotonePlainTests.swift
//  iShapeTests
//
//  Created by Nail Sharipov on 28/09/2019.
//  Copyright © 2019 iShape. All rights reserved.
//

import XCTest
import iShapeTriangulation
import iGeometry

final class MonotonePlainTests: XCTestCase {

    private func triangulate(index: Int) -> [Int] {
        let iGeom = IntGeom()

        let data = MonotoneTests.data[index]
        
        let iPoints = iGeom.int(points: data)

        let iShape = IntShape(hull: iPoints, holes: [])
        let pShape = PlainShape(iShape: iShape)

        return pShape.triangulate()
    }

    func testIntPoint_0() {
        let triangles = self.triangulate(index: 0)
        
        let origin = [
                0, 1, 3,
                1, 2, 3
            ]

        XCTAssertEqual(triangles.compare(array: origin), true)
    }
    
    func testIntPoint_1() {
        let triangles = self.triangulate(index: 1)
        let origin = [
                0, 1, 3,
                3, 1, 2
            ]
            
        XCTAssertEqual(triangles.compare(array: origin), true)
    }
    
    func testIntPoint_2() {
        let triangles = self.triangulate(index: 2)
        let origin = [
                1, 2, 0,
                0, 2, 4,
                2, 3, 4
            ]
        XCTAssertEqual(triangles.compare(array: origin), true)
    }

    func testIntPoint_3() {
        let triangles = self.triangulate(index: 3)
        let origin = [
                1, 2, 0,
                0, 2, 4,
                2, 3, 4
            ]
        XCTAssertEqual(triangles.compare(array: origin), true)
    }
    
    func testIntPoint_4() {
        let triangles = self.triangulate(index: 4)
        let origin = [
                3, 0, 2,
                0, 1, 2
            ]
        XCTAssertEqual(triangles.compare(array: origin), true)
    }
    
    func testIntPoint_5() {
        let triangles = self.triangulate(index: 5)
        let origin = [
                0, 1, 2,
                0, 2, 4,
                2, 3, 4
            ]
            XCTAssertEqual(triangles.compare(array: origin), true)
        
    }
    
    func testIntPoint_6() {
        let triangles = self.triangulate(index: 6)
        let origin = [
                0, 1, 2,
                0, 2, 3,
                0, 3, 4
            ]
            XCTAssertEqual(triangles.compare(array: origin), true)
    }
    
    func testIntPoint_7() {
        let triangles = self.triangulate(index: 7)
        let origin = [
                8, 0, 1,
                8, 1, 7,
                1, 6, 7,
                1, 2, 6,
                6, 2, 3,
                6, 3, 5,
                3, 4, 5
            ]
            XCTAssertEqual(triangles.compare(array: origin), true)
    }
    
    func testIntPoint_8() {
        let triangles = self.triangulate(index: 8)
        let origin = [
                8, 0, 1,
                8, 1, 7,
                1, 6, 7,
                1, 2, 6,
                6, 2, 3,
                6, 3, 5,
                3, 4, 5
            ]
            XCTAssertEqual(triangles.compare(array: origin), true)
    }
    
    func testIntPoint_9() {
        let triangles = self.triangulate(index: 9)
        let origin = [
                8, 0, 1,
                8, 1, 7,
                1, 6, 7,
                1, 2, 6,
                6, 2, 3,
                6, 3, 5,
                3, 4, 5
            ]
            XCTAssertEqual(triangles.compare(array: origin), true)
    }
    
    func testIntPoint_10() {
        let triangles = self.triangulate(index: 10)
        let origin = [
                8, 0, 1,
                8, 1, 7,
                1, 6, 7,
                1, 2, 6,
                6, 2, 3,
                6, 3, 5,
                3, 4, 5
            ]
            XCTAssertEqual(triangles.compare(array: origin), true)
    }
    
    func testIntPoint_11() {
        let triangles = self.triangulate(index: 11)
        let origin = [
                8, 0, 7,
                0, 6, 7,
                0, 1, 6,
                6, 2, 3,
                6, 3, 5,
                3, 4, 5
            ]
            XCTAssertEqual(triangles.compare(array: origin), true)
    }
    
    
    func testIntPoint_12() {
        let triangles = self.triangulate(index: 12)
        let origin = [
                0, 13, 14,
                0, 1, 13,
                13, 1, 2,
                13, 2, 12,
                2, 11, 12,
                2, 10, 11,
                2, 3, 10,
                10, 3, 4,
                10, 4, 9,
                4, 5, 9,
                9, 5, 6,
                9, 6, 8,
                6, 7, 8
            ]
            XCTAssertEqual(triangles.compare(array: origin), true)
    }
    
    
    func testIntPoint_13() {
        let triangles = self.triangulate(index: 13)
        let origin = [
                0, 13, 14,
                0, 1, 13,
                13, 1, 12,
                1, 2, 12,
                12, 2, 11,
                2, 10, 11,
                2, 3, 10,
                10, 3, 4,
                10, 4, 9,
                4, 5, 9,
                9, 5, 6,
                9, 6, 8,
                6, 7, 8
            ]
            XCTAssertEqual(triangles.compare(array: origin), true)
    }
    
    
    func testIntPoint_14() {
        let triangles = self.triangulate(index: 14)
        let origin = [
                0, 4, 9,
                4, 8, 9,
                4, 7, 8,
                4, 6, 7,
                4, 5, 6
            ]
            XCTAssertEqual(triangles.compare(array: origin), true)
    }
    
    
    func testIntPoint_15() {
        let triangles = self.triangulate(index: 15)
        let origin = [
                0, 1, 15,
                1, 2, 15,
                15, 2, 14,
                2, 3, 14,
                14, 3, 13,
                3, 4, 13,
                13, 4, 12,
                4, 5, 12,
                12, 5, 11,
                5, 6, 11,
                11, 6, 10,
                6, 7, 10,
                10, 7, 9,
                7, 8, 9
            ]
            XCTAssertEqual(triangles.compare(array: origin), true)
    }
    
    func testIntPoint_16() {
        let triangles = self.triangulate(index: 16)
        let origin = [
                0, 11, 12,
                0, 1, 11,
                11, 1, 2,
                11, 2, 10,
                2, 3, 10,
                10, 3, 9,
                3, 4, 9,
                9, 4, 5,
                9, 5, 8,
                5, 6, 8,
                8, 6, 7
            ]
            XCTAssertEqual(triangles.compare(array: origin), true)
    }
    
    func testIntPoint_17() {
        let triangles = self.triangulate(index: 17)
        let origin = [
                0, 1, 13,
                13, 1, 12,
                1, 2, 12,
                2, 3, 12,
                12, 10, 11,
                12, 9, 10,
                12, 3, 9,
                9, 3, 4,
                9, 4, 5,
                9, 5, 8,
                5, 6, 8,
                8, 6, 7
            ]
            XCTAssertEqual(triangles.compare(array: origin), true)
    }
    
    private func printA(triangles: [Int]) {
        var j = 0
        print("[")
        for i in 0..<triangles.count {
            j += 1
            if j == 3 {
                print("\(triangles[i - 2]), \(triangles[i - 1]), \(triangles[i]),")
                j = 0
            }
        }
        print("]")
    }
   
}


