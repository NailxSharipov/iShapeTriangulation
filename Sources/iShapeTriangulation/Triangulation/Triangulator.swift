//
//  Triangulator.swift
//  iShapeTriangulation
//
//  Created by Nail Sharipov on 28/09/2019.
//  Copyright © 2019 iShape. All rights reserved.
//

import iGeometry

public struct Triangulator {
    
    public let iGeom: IntGeom
    
    /// Creates a new triangulator with the specified precision
    /// - Parameter precision: The minimum required precision. It's a minimum linear distance after which points will be recognized as the same.
    /// For example with precision = 0.1 points (1; 1), (1; 0.05) will be equal
    /// Keep in mind that your maximum point length depend on this value by the formula: precision * 10^9
    /// For example:
    /// with precision = 0.1 your maximum allowed point is (100kk, 100kk)
    /// with precision = 0.0001 your maximum allowed point is (100k, 100k)
    /// with precision = 0.0000001 your maximum allowed point is (100, 100)
    /// If your broke this rule, the calculation will be undefinied
    public init(precision: Float = 0.0001) {
        self.iGeom = IntGeom(scale: Float(1 / precision))
    }
    
    /// Makes plain triangulation for polygon
    /// - Parameter points: Linear array of your polygon vertices listed in a clockwise direction.
    /// - Returns: Indices of triples which form triangles in clockwise direction
    public func triangulate(points: [Point]) -> [Int] {
        let iPoints = iGeom.int(points: points)
        let shape = PlainShape(points: iPoints)
        return shape.triangulate(extraPoints: nil)
    }
    
    /// Makes plain triangulation for polygon
    /// - Parameter points: Linear array of all your polygon vertices. All hull's vertices must be list in clockwise order. All holes vertices must be list in counterclockwise order.
    /// - Parameter hull: range of the hull vertices in points array
    /// - Parameter holes: array of ranges for all holes
    /// - Parameter extraPoints: extra points for triangulation
    /// - Returns: Indices of triples which form triangles in clockwise direction
    public func triangulate(points: [Point], hull: ArraySlice<Point>, holes: [ArraySlice<Point>]?, extraPoints: [Point]?) -> [Int] {
        let shape = PlainShape(iGeom: iGeom, points: points, hull: hull, holes: holes)
        if let ePoints = extraPoints {
            let iPoints = iGeom.int(points: ePoints)
            return shape.triangulate(extraPoints: iPoints)
        }  else {
            return shape.triangulate(extraPoints: nil)
        }
    }
    
    /// Makes Delaunay triangulation for polygon
    /// - Parameter points: Linear array of your polygon vertices listed in a clockwise direction.
    /// - Returns: Indices of triples which form triangles in clockwise direction
    public func triangulateDelaunay(points: [Point]) -> [Int] {
        let iPoints = iGeom.int(points: points)
        let shape = PlainShape(points: iPoints)
        return shape.delaunay(extraPoints: nil).trianglesIndices
    }
    
    /// Makes Delaunay triangulation for polygon
    /// - Parameter points: Linear array of all your polygon vertices. All hull's vertices must be list in clockwise order. All holes vertices must be list in counterclockwise order.
    /// - Parameter hull: range of the hull vertices in points array
    /// - Parameter holes: array of ranges for all holes
    /// - Parameter extraPoints: extra points for tessellation
    /// - Returns: Indices of triples which form triangles in clockwise direction
    public func triangulateDelaunay(points: [Point], hull: ArraySlice<Point>, holes: [ArraySlice<Point>]?, extraPoints: [Point]?) -> [Int] {
        let shape = PlainShape(iGeom: iGeom, points: points, hull: hull, holes: holes)
        if let ePoints = extraPoints {
            let iPoints = iGeom.int(points: ePoints)
            return shape.delaunay(extraPoints: iPoints).trianglesIndices
        }  else {
            return shape.delaunay(extraPoints: nil).trianglesIndices
        }
    }
    
    /// Break into convex polygons
    /// - Parameters:
    ///   - points: Linear array of all your polygon vertices. All hull's vertices must be list in clockwise order. All holes vertices must be list in counterclockwise order.
    ///   - hull: range of the hull vertices in points array
    ///   - holes: array of ranges for all holes
    ///   - extraPoints: extra points for tessellation
    /// - Returns: Indices of arrays which form polygons in clockwise direction. Example: n0, i0, i1, ... i(n0-1), n1, j0, j1, ... j(n1-1), ...
    public func polygonate(points: [Point], hull: ArraySlice<Point>, holes: [ArraySlice<Point>]?, extraPoints: [Point]?) -> [Int] {
        let shape = PlainShape(iGeom: iGeom, points: points, hull: hull, holes: holes)
        if let ePoints = extraPoints {
            let iPoints = iGeom.int(points: ePoints)
            return shape.delaunay(extraPoints: iPoints).convexPolygonsIndices
        }  else {
            return shape.delaunay(extraPoints: nil).convexPolygonsIndices
        }
    }

}
