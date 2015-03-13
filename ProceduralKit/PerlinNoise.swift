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
                let b = sqrt(1 - a*a)
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
        let (x0, x1) = nearestValidXIntegers(x)
        let (y0, y1) = nearestValidYIntegers(x0, y: y)

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

    private func nearestValidXIntegers(var x: CGFloat) -> (Int, Int) {
        if grid.count < 2 {
            return (0,0)
        }
        if x < 0.0 {
            x = 0
        }
        if grid.count >= Int(x+1) {
            x = CGFloat(grid.count - 2)
        }

        return (Int(x), Int(x+1))
    }

    private func nearestValidYIntegers(x: Int, var y: CGFloat) -> (Int, Int) {
        let g = grid[x]

        if g.count < 2 {
            return (0,0)
        }
        if y < 0.0 {
            y = 0
        }
        if g.count >= Int(y+1) {
            y = CGFloat(g.count - 2)
        }

        return (Int(y), Int(y+1))
    }
}
