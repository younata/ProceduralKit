//
//  FBMTests.swift
//  ProceduralKit
//
//  Created by Rachel Brindle on 3/11/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import XCTest

class FBMTests: XCTestCase {

    var subject : FractalBrownianMotion! = nil

    override func setUp() {
        super.setUp()

        subject = FractalBrownianMotion()
    }

    func testLacunarity() {
        XCTAssertEqualWithAccuracy(subject.at(0,0), 0.875, 1e-6, "Lacunarity of 2")
        subject.lacunarity = 1
        XCTAssertEqualWithAccuracy(subject.at(0,0), 3.0, 1e-6, "Lacunarity of 2")
        subject.lacunarity = 4
        XCTAssertEqualWithAccuracy(subject.at(0,0), 0.328125, 1e-6, "Lacunarity of 2")
    }

    func testOctaves() {
        XCTAssertEqualWithAccuracy(subject.at(0,0), 0.875, 1e-6, "3 Octaves")

        subject.octaves = 1
        XCTAssertEqualWithAccuracy(subject.at(0,0), 0.5, 1e-6, "1 Octave")

        subject.octaves = 6
        XCTAssertEqualWithAccuracy(subject.at(0,0), 0.984375, 1e-6, "6 Octaves")
    }

    func testNoise() {
        XCTAssertEqualWithAccuracy(subject.at(0,0), 0.875, 1e-6, "return 1")

        subject.noise = {(x, y) in x*y}
        XCTAssertEqualWithAccuracy(subject.at(2,2), 0.0014, 1e-6, "return x*y")

        let noise = PerlinNoise(grid: [
            [(x: 1, y: 0), (x: 0, y: 1)],
            [(x: 1, y: 0), (x: 0, y: 1)],
            [(x: 1, y: 0), (x: 0, y: 1)]
            ])
        subject.noise = {(x, y) in noise.at(x, y)}

        XCTAssertEqualWithAccuracy(subject.at(2,2), -0.0286, 1e-6, "return noise")
    }

    func testPerformance() {
        let noise = PerlinNoise(grid: PerlinNoise.generateGrid(100, width: 100))
        subject.noise = {(x, y) in noise.at(x, y)}

        self.measureBlock() {
            for i in 0..<1000 {
                var x = (CGFloat(arc4random_uniform(500000)) / 500000.0) * 99
                var y = (CGFloat(arc4random_uniform(500000)) / 500000.0) * 99
                self.subject.at(x, y)
            }
        }
    }

}
