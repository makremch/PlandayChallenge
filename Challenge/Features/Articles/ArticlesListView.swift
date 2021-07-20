//
//  ArticlesListView.swift
//  Challenge
//
//  Created by Makrem Hammani on 18/7/2021.
//

import SwiftUI
import Foundation
import Combine
import UIKit

struct ArticleListView: View {
    @ObservedObject var viewModel: ArticleListViewModel
    @State var searchString = ""
    func search() {
        viewModel.changeTab(activeTab: searchString)
    }
    func cancel() {
        viewModel.changeTab(activeTab: "all")

    }
    
    var body: some View {

            SearchNavigation(text: $searchString, search: search, cancel: cancel) {
                
                content
                    .navigationBarTitle("News",displayMode: .large)
            }
        topicContent
            .background(Color.blue)
            
    }
    
    
    private var content: some View {
        ArticlesList(
            articles: viewModel.state.articles,
            isLoading: viewModel.state.canLoadNextPage,
            onScrolledAtBottom: viewModel.fetchNextPageIfPossible
        )
        .onAppear(perform: viewModel.fetchNextPageIfPossible)
        
    }
    
    private var topicContent : some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack(alignment: .center, spacing: 0) {
                Button(action: {
                    viewModel.changeTab(activeTab: "all")
                }){
                    Text("All")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width / 3)
                }
                
                Button(action: {
                    viewModel.changeTab(activeTab: "covid")
                }){
                    Text("Covid")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width / 3)
                }
                
                
                Button(action: {
                    viewModel.changeTab(activeTab: "sport")
                }){
                    Text("Sport")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width / 3 )
                }
                
                
            }
        })
        .frame( height: 80, alignment: .center)
        .cornerRadius(20)
    }
    
    struct ArticlesList : View {
        let articles: [Article]
        let isLoading: Bool
        let onScrolledAtBottom: () -> Void
        
        var body: some View{
            ScrollView {
                LazyVStack {
                    ForEach(articles) { article in
                        
                        NavigationLink(
                            destination: ArticleDetailView(article: article),
                            label: { ArticleListItemView(article: article) }
                        )
                        
                        .onAppear {
                            if articles.last?.id == article.id {
                                self.onScrolledAtBottom()
                            }
                            
                        }
                        
                        .padding(.all, 5)
                    }
                    
                    if isLoading
                    {
                        ProgressView()
                    }
                }
            }
        }
        
    }
}

struct ArticleListItemView: View {
    let article: Article
    let utils : Utils = Utils()
    @Environment(\.imageCache) var cache: ImageCache
    
    var body: some View {
        VStack(alignment: .leading  , spacing: 10){
            HStack(spacing: 5 ){
                image.frame(width:200,height:(120)).cornerRadius(5)
                VStack(alignment: .leading, spacing: 10){
                    title.padding(.top,5)
                    date
                    Spacer()
                }
            }
        }.background(Color.white).cornerRadius(10)
    }
    
    private var title: some View {
        Text(article.title!)
            .foregroundColor(Color.black)
            .font(.system(size: 15, weight: .regular, design: .default))
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.black)
            .multilineTextAlignment(.leading)
    }
    
    private var image: some View {
        AsyncImage(
            url: article.image!,
            cache: cache,
            placeholder: spinner,
            configuration: { $0.resizable() }
        )
    }
    
    
    private var date : some View {
        Text("Posted : " + utils.formatDate(date:article.publishedAt!,format: "MMM d, h:mm a"))
            .foregroundColor(Color.gray)
            .font(.system(size: 12, weight: .light, design: .default))
    }
    
    private var spinner: some View {
        Spinner(isAnimating: true, style: .large)
    }
}
