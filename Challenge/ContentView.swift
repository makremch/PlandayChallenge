//
//  ContentView.swift
//  Challenge
//
//  Created by Makrem Hammani on 18/7/2021.
//

import SwiftUI

struct ContentView: View {
    let viewModel : ArticleListViewModel = ArticleListViewModel()
    var body: some View {
        ArticleListView(viewModel: viewModel)
            .ignoresSafeArea( edges: .bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
