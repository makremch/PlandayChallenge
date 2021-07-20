//
//  Models.swift
//  Challenge
//
//  Created by Makrem Hammani on 18/7/2021.
//

import Foundation 


// MARK: - Article Response
struct ArticlesResponse: Codable {
    let status        : String?
    let totalResults  : Int?
    let articles      : [ArticleDTO]?
    let message            : String?

}

// MARK: - Article Data Transfer Object
struct ArticleDTO: Codable {
    let source             : Source?
    let author             : String?
    let title              : String?
    let description        : String?
    let url                : String?
    let urlToImage         : String?
    let publishedAt        : String?
    let content            : String?

}

// MARK: - Source Type
struct Source: Codable {
    let id   : String?
    let name : String?
}



// MARK:- Article
class Article : Identifiable, ObservableObject {
    
    let title       : String?
    let author      : String?
    let description : String?
    let content     : String?
    let source      : String?
    let link        : String?
    let image       : URL?
    let publishedAt : Date?
    
    
    
    init(article: ArticleDTO) {
        self.title       = article.title
        self.author      = article.author
        self.description = article.description
        self.content     = article.content
        self.source      = article.source!.name
        self.link        = article.url
        if let url = URL(string: (article.urlToImage) ??  "https://nelowvision.com/wp-content/uploads/2018/11/Picture-Unavailable.jpg") {
            self.image = url
        }
        else {
            self.image = URL(string: "https://nelowvision.com/wp-content/uploads/2018/11/Picture-Unavailable.jpg")!
        }

        self.publishedAt = ISO8601DateFormatter().date(from:article.publishedAt!)!
        
    }
    
    
    
}
