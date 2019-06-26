//
//  BlogPostRow.swift
//  Presentation
//
//  Created by Jeroen Bakker on 25/06/2019.
//  Copyright © 2019 Bakker. All rights reserved.
//

import SwiftUI
import Domain

public struct BlogPostRow: View {
    
    public let viewModel: BlogPostRowViewModel
    
    public var body: some View {
        HStack {
            Text(viewModel.title).font(.headline)
            Text(viewModel.date).font(.footnote)
        }
    }
}

#if DEBUG
struct BlogPostRow_Previews: PreviewProvider {
    static let dummyBlogPost = BlogPostRowViewModel(id: 0, title: "A title", date: "A date")
    
    static var previews: some View {
        BlogPostRow(viewModel: dummyBlogPost)
    }
}
#endif
