//
//  CameraService.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/11/23.
//

import Foundation
import AVFoundation
import CoreImage

final class CameraService: NSObject {
    
    // MARK: - Properties
    
    private let device: AVCaptureDevice? = .default(.builtInWideAngleCamera, for: .video, position: .front)
    
    private var isCaptureSessionConfigured: Bool = false
    private let captureSession: AVCaptureSession = .init()
    private var deviceInput: AVCaptureDeviceInput?
    private var photoOutput: AVCapturePhotoOutput?
    
    var isPreviewPaused: Bool = false
    private var addToPhotoStream: ((AVCapturePhoto) -> Void)?
    lazy var photoStream: AsyncStream<AVCapturePhoto> = {
        AsyncStream { continuation in
            addToPhotoStream = { photo in
                continuation.yield(photo)
            }
        }
    }()
    
    private var sessionQueue: DispatchQueue = .init(label: "session queue")
}

extension CameraService {
    
    func checkAuthorization() async -> Bool {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            print("❓ Requesting Access ❓")
            sessionQueue.suspend()
            await AVCaptureDevice.requestAccess(for: .video)
            sessionQueue.resume()
            return true
        case .restricted:
            print("❗️ Access Restricted ❗️")
            return false
        case .denied:
            print("❗️ Access Denied ❗️")
            return false
        case .authorized:
            print("❗️ Access Authorized ❗️")
            return true
        @unknown default:
            return false
        }
    }
    
    func configureSession(completion: @escaping (Bool) -> Void) {
        guard !isCaptureSessionConfigured else { return }
        
        var isSuccessful = false
        
        self.captureSession.beginConfiguration()
        defer {
            self.captureSession.commitConfiguration()
            completion(isSuccessful)
        }
        
        guard let device = device,
              let deviceInput = try? AVCaptureDeviceInput(device: device)
        else {
            print("❌ Unable to load device ❌")
            return
        }
        
        guard captureSession.canAddInput(deviceInput)
        else {
            print("❌ Unable to load input ❌")
            return
        }
        
        let photoOutput = AVCapturePhotoOutput()
        guard captureSession.canAddOutput(photoOutput)
        else {
            print("❌ Unable to load output ❌")
            return
        }
        
        captureSession.sessionPreset = .photo
        captureSession.addInput(deviceInput)
        captureSession.addOutput(photoOutput)
        self.deviceInput = deviceInput
        self.photoOutput = photoOutput
        
        self.isCaptureSessionConfigured = true
        isSuccessful = true
    }
    
    func startSession() async {
        guard await self.checkAuthorization()
        else {
            print("❌ Terminated due to Authorization Status ❌")
            return
        }
        
        if !isCaptureSessionConfigured {
            self.sessionQueue.async { [self] in
                self.configureSession { isDone in
                    guard isDone else { return }
                    self.captureSession.startRunning()
                }
            }
        } else {
            if !self.captureSession.isRunning {
                self.sessionQueue.async { [self] in
                    self.captureSession.startRunning()
                }
            }
        }
    }
    
    func stopSession() {
        guard isCaptureSessionConfigured else { return }
        guard self.captureSession.isRunning else { return }
        self.sessionQueue.async {
            self.captureSession.stopRunning()
        }
    }
    
    func takePhoto() {
        guard let output = self.photoOutput else { return }
        
        let settings = AVCapturePhotoSettings()
        settings.flashMode = .off
        settings.photoQualityPrioritization = .quality
        
        output.capturePhoto(with: settings, delegate: self)
    }
}

extension CameraService: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            dump(error.localizedDescription)
        } else {
            addToPhotoStream?(photo)
        }
    }
}
