//
//  CameraService.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/13/23.
//

import AVFoundation
import CoreImage

final class CameraService: NSObject {
    
    var captureSession: AVCaptureSession?
    
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var hasTakenPhoto: Bool = false
    var takenPhoto: CIImage?
}

// MARK: - Setting

extension CameraService {
    
    func setupSession() {
        self.captureSession = AVCaptureSession()
        self.captureSession?.beginConfiguration()
        defer { self.captureSession?.commitConfiguration() }
        
        self.configureSession()
        self.configureInput()
        self.configureOutput()
    }
    
    private func configureSession() {
        guard let session = self.captureSession else { return }
        if session.canSetSessionPreset(.photo) {
            session.sessionPreset = .photo
        }
        session.automaticallyConfiguresCaptureDeviceForWideColor = true
    }
    
    private func configureInput() {
        guard let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
        else { fatalError("❌ Unable to load device ❌") }
        
        guard let input = try? AVCaptureDeviceInput(device: frontCamera)
        else { fatalError("❌ Unable to use input device ❌") }
        
        guard let session = self.captureSession else { return }
        session.addInput(input)
    }
    
    private func configureOutput() {
        let videoQueue = DispatchQueue(label: "video queue", qos: .userInteractive)
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
        videoOutput.connections.first?.videoOrientation = .portrait
        
        guard let session = self.captureSession else { return }
        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
        }
    }
}

// MARK: - Configure

extension CameraService {
    
    func sendPreviewLayer() {
        guard let session = self.captureSession else { return }
        self.previewLayer = AVCaptureVideoPreviewLayer(session: session)
    }
    
    func takePhoto() {
        self.hasTakenPhoto = true
    }
}


extension CameraService: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard !self.hasTakenPhoto else { return }
        
        guard let cvBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        else { return }
        
        self.takenPhoto = CIImage(cvImageBuffer: cvBuffer)
        self.hasTakenPhoto = false
    }
}
