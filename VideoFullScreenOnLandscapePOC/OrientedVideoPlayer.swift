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

struct OrientedVideoPlayer: View {
  @State private var orientation = UIDevice.current.orientation
    let url = URL(
        string: "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
    )!

    let videoPlayer = VideoPlayer(player: AVPlayer(url: URL(
        string: "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
    )!))
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
}

#Preview {
    OrientedVideoPlayer()
        .previewInterfaceOrientation(.landscapeLeft)
}
