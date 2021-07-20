//
//  ArticleViewModel.swift
//  Challenge
//
//  Created by Makrem Hammani on 18/7/2021.
//

import Foundation
import Combine


//MARK:- ViewModel
final class ArticleListViewModel: ObservableObject {
    @Published private(set) var state = State()
    let pageSize = 5
    struct State {
        var totalResults = 15
        var articles: [Article] = []
        var visibleArticles: [Article] = []
        var page: Int = 1
        var canLoadNextPage = true
        var activeTab = "all"
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    func changeTab(activeTab : String) {
        state.activeTab = activeTab
        state.articles =  []
        state.page = 1
        state.canLoadNextPage = true
        self.fetchNextPageIfPossible()
    }
    
    func fetchNextPageIfPossible() {

        guard state.canLoadNextPage else { return }
        var params = ["language" : "en" ,"pageSize" : String(pageSize) , "page" : String(state.page)]
        var response : AnyPublisher<ArticlesResponse, Error>
        if(state.activeTab != "all" ) {
            params["q"] = state.activeTab
            response = ArticlesAPI.getArticles(params: params)
        } else {
            response = ArticlesAPI.getTopHeadlines(params: params)
        }
        response
            .map {
                return $0.articles!.map(Article.init)
            }
            .sink(receiveCompletion: onReceive,
                  receiveValue: onReceive)
            .store(in: &subscriptions)
    }
    
    func search(searchText : String)  {
        if searchText.isEmpty {
            state.visibleArticles = state.articles
        } else  {
            state.visibleArticles = state.articles.filter{ $0.title?.lowercased().contains(searchText.lowercased()) ?? false }
        }
            
    }
    
    private func onReceive(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure:
            state.canLoadNextPage = false
        }
    }

    private func onReceive(_ batch: [Article]) {
        state.articles += batch
        state.page += 1
        state.canLoadNextPage = batch.count == pageSize
    }
    
}

