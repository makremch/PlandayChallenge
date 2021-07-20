//
//  ArticleViewModel.swift
//  Challenge
//
//  Created by Makrem Hammani on 19/7/2021.
//

import Foundation

protocol ArticleDetailsViewModelProtocol {
    func getArticleInfo(article: Article)
}


class ArticleDetailsViewModel: ArticleDetailsViewModelProtocol,ObservableObject {
    
    func getArticleInfo(article: Article) {
        print(article)
    }
    
    
   
    
    
    
}
