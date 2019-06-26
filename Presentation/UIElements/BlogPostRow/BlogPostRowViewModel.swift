//
//  BlogPostRowViewModel.swift
//  Jeroenscode
//
//  Created by Jeroen Bakker on 25/06/2019.
//  Copyright © 2019 Bakker. All rights reserved.
//

import SwiftUI

public struct BlogPostRowViewModel: Identifiable, Equatable {
    public let id: Int
    public let title: String
    public let date: String
}

public func ==(lhs: BlogPostRowViewModel, rhs: BlogPostRowViewModel) -> Bool {
    return rhs.id == lhs.id
}
