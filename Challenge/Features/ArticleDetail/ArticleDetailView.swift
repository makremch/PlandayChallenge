//
//  ArticlepView.swift
//  Challenge
//
//  Created by Makrem Hammani on 19/7/2021.
//

import SwiftUI

struct ArticleDetailView: View {
    @ObservedObject var article : Article
    @Environment(\.imageCache) var cache: ImageCache
    var utils = Utils()
    
    
    
    var body: some View {
        ZStack (alignment: Alignment(horizontal: .center, vertical: .top)){
            image
            customNavigationBar
        }
        ScrollView{
            
            title
            Spacer().frame(height: 20, alignment: .center)
            
            HStack(spacing:5){
                Image(systemName: "calendar.badge.clock")
                    .foregroundColor(.gray.opacity(0.5))
                    .padding()
                source
            }
            
            Spacer().frame(height: 25, alignment: .center)
            description
            Spacer().frame(height: 25, alignment: .center)
            link
        }
        .frame(width: UIScreen.main.bounds.width,  alignment: .center)
        Spacer()
    }
    
    
    
    private var image: some View {
        AsyncImage(
            url: article.image!,
            cache: cache,
            placeholder: spinner,
            configuration: { $0.resizable()}
        )
        .aspectRatio(contentMode: .fill)
        .frame(width: UIScreen.main.bounds.width,  alignment: .center)
        
    }
    
    
    private var title : some View {
        Text(self.article.title!)
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(Color.black)
            .multilineTextAlignment(.leading)
            .frame(width: UIScreen.main.bounds.width - 30,  alignment: .center)
    }
    
    private var source : some View {
        Text(utils.formatDate(date:article.publishedAt!,format: "MMM d, h:mm a"))
            .frame(width: UIScreen.main.bounds.width - 30,  alignment: .leading)
            .font(.footnote)
            .foregroundColor(Color.gray)
            .multilineTextAlignment(.trailing)
    }
    
    private var description : some View {
        Text((self.article.description) != nil ? self.article.description! : "...")
            .frame(width: UIScreen.main.bounds.width - 60,  alignment: .leading)
    }
    
    private var link : some View {
      
        Link(destination: URL(string: self.article.link!)!) {
            HStack(spacing: 5) {
                Image(systemName: "link.circle.fill")
                    .foregroundColor(.blue)
                Text("Visit link")
                    .font(.body)
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.trailing)
            }
            .padding(.all,5)
            .border(Color.blue).cornerRadius(2)
            
            
        }
    }
    
    private var spinner: some View {
        Spinner(isAnimating: true, style: .large)
    }
    
    private var customNavigationBar : some View {
        VStack{
            Spacer()
            HStack(spacing:3){
                Spacer()
                Text("From:  " + article.source!)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding()
            }
            .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .center)
            .background(Color.black.opacity(0.5))
        }
        .ignoresSafeArea( edges: .top)
    }
}
