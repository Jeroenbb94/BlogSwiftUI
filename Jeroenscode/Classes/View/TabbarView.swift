//
//  TabbarView.swift
//  Jeroenscode
//
//  Created by Jeroen Bakker on 24/06/2019.
//  Copyright © 2019 Bakker. All rights reserved.
//

import SwiftUI
import Presentation

struct TabbarView: View {
    private let homeView: HomeView
    @State private var selection = 0
    
    init(homeView: HomeView) {
        self.homeView = homeView
    }
 
    var body: some View {
        TabbedView(selection: $selection) {
            homeView
                .tabItemLabel(Image("first"))
                .tag(0)
            Text("Second View")
                .font(.title)
                .tabItemLabel(Image("second"))
                .tag(1)
        }
    }
}
