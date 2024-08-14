//
//  ContentView.swift
//  VideoFullScreenOnLandscapePOC
//
//  Created by maxime wacker on 07/08/2024.
//

// From: https://swiftuirecipes.com/blog/swiftui-device-orientation-change-observer


import SwiftUI
import AVKit

struct OrientationDetector: ViewModifier {
  @Binding var orientation: UIDeviceOrientation
    
  func body(content: Content) -> some View {
    content
      .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
        orientation = UIDevice.current.orientation
      }
  }
}

extension View {
  func detectOrientation(_ binding: Binding<UIDeviceOrientation>) -> some View {
    self.modifier(OrientationDetector(orientation: binding))
  }
}


import AVKit
import SwiftUI

struct PlayerViewController: UIViewControllerRepresentable {
    let avPlayer: AVPlayer
    internal init(videoURL: URL) {
        self.avPlayer = AVPlayer(url: videoURL)
    }
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        //controller.modalPresentationStyle = .fullScreen
        controller.player = avPlayer
        //controller.player?.play()
        
        return controller
    }

    func updateUIViewController(_ playerController: AVPlayerViewController, context: Context) {}
}


struct OrientedVideoPlayer: View {
  @State private var orientation = UIDevice.current.orientation
    let videoPlayerController = PlayerViewController(videoURL: URL(
        string: "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
    )!)
  var body: some View {
    Group {
        if orientation.isLandscape {
            videoPlayer
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                //.background(.green)
                .edgesIgnoringSafeArea(.all)
                .toolbar(.hidden, for: .tabBar)
        } else {
            videoPlayer
      }
    }
    .detectOrientation($orientation)
  }
    @ViewBuilder
    var videoPlayer: some View {
        self.videoPlayerController
    }

}


#Preview {
    OrientedVideoPlayer()
        .previewInterfaceOrientation(.landscapeLeft)
}
