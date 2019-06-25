//
//  HomeView.swift
//  Jeroenscode
//
//  Created by Jeroen Bakker on 24/06/2019.
//  Copyright © 2019 Bakker. All rights reserved.
//

import SwiftUI

public protocol HomeViewDisplayProtocol {
    func displayBlogPosts()
    func displayError()
}

public struct HomeView: View {
    
    private let interactor: HomeInteractorProtocol
    
    init(interactor: HomeInteractorProtocol) {
        self.interactor = interactor
    }
    
    public var body: some View {
        Text("Hey").onAppear {
            self.interactor.fetchBlogs()
        }
    }
}

// MARK: - HomeViewDisplayProtocol
extension HomeView: HomeViewDisplayProtocol {
    
    public func displayBlogPosts() {
        
    }
    
    public func displayError() {
        
    }
}

//#if DEBUG
//struct HomeView_Previews : PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
//#endif
