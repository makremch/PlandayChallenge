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
import AlertX

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
                onScrolledAtBottom: viewModel.fetchNextPageIfPossible,
                error : viewModel.state.error
            )
            .onAppear(perform: viewModel.fetchNextPageIfPossible)
    }
    
    struct Error : View {
        let error : String
        var body: some View{
            AlertX(title: Text(error),theme: .wine(withTransparency: true, roundedCorners: true))
        }
    }
    
    
    private var topicContent : some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack(alignment: .center, spacing: 0) {
                Button(action: {
                    viewModel.changeTab(activeTab: "all")
                }){
                    Text("All")
                        .underline(viewModel.state.activeTab=="all",color: Color.white)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width / 3)
                }.accessibilityIdentifier("All")
                
                Button(action: {
                    viewModel.changeTab(activeTab: "covid")
                }){
                    
                    Text("#COVID")
                        .underline(viewModel.state.activeTab=="covid",color: Color.white)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width / 3)
                }.accessibilityIdentifier("#COVID")
                
                
                Button(action: {
                    viewModel.changeTab(activeTab: "sport")
                }){
                    Text("#SPORT")
                        .underline(viewModel.state.activeTab=="sport",color: Color.white)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width / 3 )
                }.accessibilityIdentifier("#SPORT")
            }
        })
        .frame( height: 80, alignment: .center)
        .cornerRadius(20)
        .accessibilityIdentifier("newsList")
    }
    
    struct ArticlesList : View {
        let articles: [Article]
        let isLoading: Bool
        let onScrolledAtBottom: () -> Void
        let error : String?

        var body: some View{
            if error != nil {
                Error(error: error!)
            } else {
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

