//
//  PerlinNoise.swift
//  ProceduralKit
//
//  Created by Rachel Brindle on 3/11/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import Foundation

public class PerlinNoise {
    let grid : [[(x: CGFloat, y: CGFloat)]]

    public class func generateGrid(length: Int, width: Int) -> [[(x: CGFloat, y: CGFloat)]] {
        var ret : [[(x: CGFloat, y: CGFloat)]] = []
        for x in 0..<length {
            var g : [(x: CGFloat, y: CGFloat)] = []
            for y in 0..<width {
                let a = CGFloat(arc4random_uniform(500000)) / 500000.0
                let b = sqrt(a*a)
                g.append((x: a, y: b))
            }
            ret.append(g)
        }
        return ret
    }

    public init(grid: [[(x: CGFloat, y: CGFloat)]]) {
        self.grid = grid
    }

    func linearInterpolation(a: CGFloat, _ b: CGFloat, weight: CGFloat) -> CGFloat {
        return ((1.0 - weight) * a) + (weight * b)
    }

    func dotProductGradient(ix: Int, iy: Int, x: CGFloat, y: CGFloat) -> CGFloat {
        let dx = x - CGFloat(ix)
        let dy = y - CGFloat(iy)

        return (dx*grid[ix][iy].x + dy*grid[ix][iy].y)
    }

    public func at(x: CGFloat, _ y: CGFloat) -> CGFloat {
        let x0 = x > 0.0 ? Int(x) : Int(x - 1)
        let x1 = x0 + 1
        let y0 = y > 0.0 ? Int(y) : Int(y - 1)
        let y1 = y0 + 1

        let weightX = x - CGFloat(x0)
        let weightY = y - CGFloat(y0)

        var n0 = dotProductGradient(x0, iy: y0, x: x, y: y)
        var n1 = dotProductGradient(x1, iy: y0, x: x, y: y)

        let ix0 = linearInterpolation(n0, n1, weight: weightX)

        n0 = dotProductGradient(x0, iy: y1, x: x, y: y)
        n1 = dotProductGradient(x1, iy: y1, x: x, y: y)

        let ix1 = linearInterpolation(n0, n1, weight: weightX)

        return linearInterpolation(ix0, ix1, weight: weightY)
    }
}
