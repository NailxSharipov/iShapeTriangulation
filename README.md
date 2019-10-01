# iShapeTriangulation
Complex polygon triangulation. A fast O(n*log(n)) algorithm based on "Triangulation of monotone polygons". The result can be represented as a Delaunay triangulation.
<p align="center">
<img src="https://github.com/NailxSharipov/iShapeTriangulation/blob/master/logo.svg" width="500">
</p>

## Features

💡 Fast O(n*log(n)) algorithm based on "Triangulation of monotone polygons"

💡 Supports polygons with holes

💡 Supports plain and Delaunay triangulation

---

## Basic Usage

Let's imagine you have a polygon like one is shown below:

<img align="center" src="https://github.com/NailxSharipov/iShapeTriangulation/blob/master/vertices_ordering_rule_0.svg" width="500">

You should list your hull vertices in clockwise direction and your holes vertices in counterclockwise direction

```swift
let points: [CGPoint] = [

  // hule vertices list in clockwise direction
  CGPoint(x: -5, y: 10),
  CGPoint(x: 5, y: 10),
  CGPoint(x: 10, y: 5),
  CGPoint(x: 10, y: -5),
  CGPoint(x: 5, y: -10),
  CGPoint(x: -5, y: -10),
  CGPoint(x: -10, y: -5),
  CGPoint(x: -10, y: 5),
            
  // holes vertices list in counterclockwise direction
  CGPoint(x: -5, y: 0),
  CGPoint(x: 0, y: -5),
  CGPoint(x: 5, y: 0),
  CGPoint(x: 0, y: 5)
]

let hule = points[0...7]
let hole = points[8...11]
        
let triangles = Triangulator.triangulateDelaunay(points: points, hull: hule, holes: [hole])

```

<img align="center" src="https://github.com/NailxSharipov/iShapeTriangulation/blob/master/vertices_ordering_rule_1.svg" width="500">

After a triangulation you will get an array of indices. Where each triple are represent an indices of the triangle vertices. The indices are always listed in a clock wise direction.
<img align="center" src="https://github.com/NailxSharipov/iShapeTriangulation/blob/master/vertices_ordering_rule_2.svg" width="500">

