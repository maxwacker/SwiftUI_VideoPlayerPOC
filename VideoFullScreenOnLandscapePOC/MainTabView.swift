//
//  MainTabView.swift
//  VideoFullScreenOnLandscapePOC
//
//  Created by maxime wacker on 07/08/2024.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            OrientedVideoPlayer()
                .tabItem { Text("Video") }
            Text("Other")
                .tabItem { Text("Other") }
        }
    }
}
