//
//  CameraModel.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/12/23.
//

import AVFoundation
import SwiftUI

final class CameraModel: ObservableObject {
    
    let service = CameraService()
    
    @Published var viewFinderImage: Image?
    
    init() {
        Task {
            await self.handleCameraPreviews()
        }
    }
    
}

extension CameraModel {
    
    func handleCameraPreviews() async {
            let imageStream = service.previewStream
                .map { $0.image }


            for await image in imageStream {
                Task { @MainActor in
                    viewfinderImage = image
                }
            }
        }
}
