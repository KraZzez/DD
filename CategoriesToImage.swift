//
//  CategoriesToImage.swift
//  DD
//
//  Created by Ludvig Krantzén on 2022-12-05.
//

import SwiftUI

struct CategoryToImage {
    
    func getCategoryImage(category: String) -> String{
        
        switch category {
        case "Fitness":
        return "figure.run"
        case "Chores":
        return "house"
        case "Health":
        return "heart"
        case "Cooking":
        return "fork.knife"
        case "Study":
        return "book"
        case "Recreational":
        return "face.smiling"
        default:
        return "questionmark.app"
        }
    }
}
