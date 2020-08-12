//
//  MetalView.swift
//  Metal_MacOS
//
//  Created by Nail Sharipov on 11.08.2020.
//  Copyright © 2020 Nail Sharipov. All rights reserved.
//

import MetalKit
import SwiftUI
import iGeometry

struct MetalView: NSViewRepresentable {
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeNSView(context: NSViewRepresentableContext<MetalView>) -> MTKView {
        let mtkView = MTKView()
        mtkView.delegate = context.coordinator
        mtkView.preferredFramesPerSecond = 60
        mtkView.device = context.coordinator.device
        mtkView.framebufferOnly = false
        mtkView.clearColor = MTLClearColor(red: 0, green: 0, blue: 0, alpha: 0)
        mtkView.drawableSize = mtkView.frame.size
        mtkView.enableSetNeedsDisplay = true
        mtkView.isPaused = false

        return mtkView
    }
    
    func updateNSView(_ nsView: MTKView, context: NSViewRepresentableContext<MetalView>) {
    
    }
    
    final class Coordinator: NSObject, MTKViewDelegate {

        let meshBuilder = MeshBuilder()
        let device: MTLDevice
        private let parent: MetalView
        private let metalCommandQueue: MTLCommandQueue
        private let pipeline: MTLRenderPipelineState
        
        private let vertexData: [Point] = [
            Point(x: 0.0, y: 0.5),
            Point(x: -0.5, y: -0.5),
            Point(x: 0.5, y: -0.5)
        ]
        
        private let vertexBuffer: MTLBuffer
        
        init(_ parent: MetalView) {
            self.parent = parent
            self.device = MTLCreateSystemDefaultDevice()!
            self.metalCommandQueue = device.makeCommandQueue()!
            let library = try! self.device.makeDefaultLibrary(bundle: Bundle(for: Coordinator.self))
            let pipelineDescriptor = MTLRenderPipelineDescriptor()
            pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
            pipelineDescriptor.vertexFunction = library.makeFunction(name: "vertexShader")!
            pipelineDescriptor.fragmentFunction = library.makeFunction(name: "fragmentShader")!
            
            self.pipeline = try! self.device.makeRenderPipelineState(descriptor: pipelineDescriptor)

            let vertexSize = self.vertexData.count * MemoryLayout.size(ofValue: vertexData[0])
            self.vertexBuffer = self.device.makeBuffer(bytes: vertexData, length: vertexSize, options: [.cpuCacheModeWriteCombined])!
            
            super.init()
        }
        
        func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
            
        }
        
        func draw(in view: MTKView) {
            guard
                let drawable = view.currentDrawable,
                let commandBuffer = self.metalCommandQueue.makeCommandBuffer(),
                let renderPath = view.currentRenderPassDescriptor,
                let encoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPath)
                else {
                    return
            }
            encoder.setRenderPipelineState(self.pipeline)
            
            let mesh = meshBuilder.next(device: device)
            
            encoder.setVertexBuffer(mesh.vertexBuffer, offset: 0, index: 0)
            encoder.drawIndexedPrimitives(type: .triangle, indexCount: mesh.count, indexType: .uint16, indexBuffer: mesh.indexBuffer, indexBufferOffset: 0)
            
            renderPath.colorAttachments[0].clearColor = MTLClearColorMake(0, 1, 0, 1)
            renderPath.colorAttachments[0].loadAction = .clear
            renderPath.colorAttachments[0].storeAction = .store

            encoder.endEncoding()
            commandBuffer.present(drawable)
            commandBuffer.commit()
        }
    }
}
