//
//  ArticleAPI.swift
//  Challenge
//
//  Created by Makrem Hammani on 18/7/2021.
//

import Foundation 
import Combine

enum ArticlesAPI {
    static let imageBase      = URL(string: "https://image.tmdb.org/t/p/original/")!
    private static let base   = URL(string: "https://newsapi.org/v2")!
    private static let apiKey =             "0a0a0b1590304ca28136754f69d3a579"
    private static let agent  = Agent()
    
    
    //MARK:- Get NewsList from Agent performRequest: Everything param
    static func getArticles(params : [String:String]) -> AnyPublisher<ArticlesResponse, Error> {
        let request = URLComponents(url: base.appendingPathComponent("everything"), resolvingAgainstBaseURL: true)?
            .addingApiKey(apiKey)
            .addParameters(params)
            .request
        return agent.performRequest(request!)
    }
    
    //MARK:- Get NewsList from Agent performRequest: Top param
    static func getTopHeadlines(params : [String:String]) -> AnyPublisher<ArticlesResponse, Error> {
        let request = URLComponents(url: base.appendingPathComponent("top-headlines"), resolvingAgainstBaseURL: true)?
            .addingApiKey(apiKey)
            .addParameters(params)
            .request
        return agent.performRequest(request!)
    }
}

private extension URLComponents {
    func addingApiKey(_ apiKey: String) -> URLComponents {
        var copy        = self
        copy.queryItems = [URLQueryItem(name: "apiKey", value: apiKey)]
        return copy
    }
    
    func addParameters(_ params : [String:String]) -> URLComponents {
        var copy       = self
        let queryItems = params.map {
            URLQueryItem(name: $0.0, value: $0.1)
        }
        copy.queryItems?.append(contentsOf: queryItems)
        return copy
    }
    
    var request: URLRequest? {
        url.map { URLRequest.init(url: $0) }
    }
}

