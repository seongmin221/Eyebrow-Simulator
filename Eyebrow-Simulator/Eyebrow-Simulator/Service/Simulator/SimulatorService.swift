//
//  MLSimulatorService.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/11/23.
//

import CoreImage
import Foundation
import Vision

final class SimulatorService {
    
    private let buffer: CMSampleBuffer
    private var sequenceHandler = VNSequenceRequestHandler()
    
    var faceBoundingBox: CGRect?
    var eyebrowPos: (left: [CGPoint], right: [CGPoint])?
    
    init(buffer: CMSampleBuffer) {
        self.buffer = buffer
        self.detectFaceLandmarks()
    }
}

// MARK: - face landmark detection

extension SimulatorService {
    private func detectFaceLandmarks() {
        let request = VNDetectFaceLandmarksRequest(completionHandler: detectedFace)
        guard let imageBuffer = CMSampleBufferGetImageBuffer(self.buffer) else { return }
        
        do {
            try sequenceHandler.perform([request], on: imageBuffer, orientation: .downMirrored)
        }
        catch { print(error.localizedDescription) }
    }
    
    private func detectedFace(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNFaceObservation],
              let result = results.first
        else { return }
        
        self.faceBoundingBox = result.boundingBox
        detectEyebrow(for: result)
    }
    
    private func detectEyebrow(for result: VNFaceObservation) {
        guard let landmarks = result.landmarks,
              let leftEyebrow = landmarks.leftEyebrow,
              let rightEyebrow = landmarks.rightEyebrow
        else { return }
        
        self.eyebrowPos = (leftEyebrow.normalizedPoints, rightEyebrow.normalizedPoints)
    }
}

// MARK: -

extension SimulatorService {
    func extractCIImage() -> CIImage {
        guard let cvBuffer = CMSampleBufferGetImageBuffer(self.buffer)
        else { return CIImage() }
        return CIImage(cvImageBuffer: cvBuffer)
    }
}

