//
//  HomeView.swift
//  Jeroenscode
//
//  Created by Jeroen Bakker on 24/06/2019.
//  Copyright © 2019 Bakker. All rights reserved.
//

import SwiftUI

public struct HomeView: View {
    
    @ObjectBinding public var controller: HomeController
    
    public init(controller: HomeController) {
        self.controller = controller
    }
    
    public var body: some View {
        Group {
            if controller.blogPosts.isEmpty {
                Text("Loading.....")
            } else {
                NavigationView {
                    List(controller.blogPosts, rowContent: BlogPostRow.init)
                        .navigationBarTitle(Text("Blog posts"))
                }
            }
        }.onAppear {
            self.controller.interactor.fetchBlogs()
        }
    }
}
