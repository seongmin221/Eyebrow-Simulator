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
    var cmBuffer: CMSampleBuffer?
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
        
        guard let session = self.captureSession else { return }
        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
        }
        
        videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
        videoOutput.connections.first?.videoOrientation = .portrait
        videoOutput.connections.first?.isVideoMirrored = true
    }
}

// MARK: - Functions

extension CameraService {
    
    func configurePreviewLayer() -> AVCaptureVideoPreviewLayer? {
        guard let session = self.captureSession else { return nil }
        return AVCaptureVideoPreviewLayer(session: session)
    }
    
    func startSession() {
        self.captureSession?.startRunning()
    }
    
    func takePhoto() {
        self.hasTakenPhoto = true
    }
    
    func stopSession() {
        self.captureSession?.stopRunning()
        self.takenPhoto = nil
    }
}


extension CameraService: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard !self.hasTakenPhoto else { return }
        
        guard let cvBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        else { return }
        
        self.takenPhoto = CIImage(cvImageBuffer: cvBuffer)
        self.hasTakenPhoto = false
        self.cmBuffer = sampleBuffer
    }
}
