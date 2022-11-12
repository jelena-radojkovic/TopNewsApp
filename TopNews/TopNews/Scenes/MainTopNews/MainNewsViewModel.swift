//
//  MainNewsViewModel.swift
//  TopNews
//
//  Created by Jelena Radojkovic on 11.11.22..
//

import Foundation

class MainNewsViewModel {
    private(set) var fetchedData: [MainNewsModel] = []
    private(set) var dataSource: [String: [MainNewsModel]] = [:]
    var headlines: [String] {
        Array(dataSource.keys).sorted { $0.lowercased() < $1.lowercased() }
    }
    var onFetchedData: (() -> Void)?
    
    enum Constants {
        static let country = "rs"
    }
    
    init() {
        setUpDataSource()
    }
    
    func getMainNewsCellModel(from data: MainNewsModel) -> MainNewsCellModel {
        MainNewsCellModel(imageUrlLink: data.urlToImage ?? "", newsTitle: data.title, newsDescription: data.description)
    }
    
    func setUpDataSource() {
        NetworkManager.shared.getTopNews(country: Constants.country) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                self.fetchedData = result.map { MainNewsModel(source: $0.source.name,
                                                              title: $0.title,
                                                              description: $0.description,
                                                              url: $0.url,
                                                              urlToImage: $0.urlToImage,
                                                              date: $0.publishedAt.toDate())}
                self.createDataSource(self.fetchedData)
                self.onFetchedData?()
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
    func filterNews(with text: String) {
        if text.isEmpty {
            createDataSource(fetchedData)
        } else {
            createDataSource(fetchedData.filter { $0.title.contains(text) || $0.description.contains(text) })
        }
        onFetchedData?()
    }
    
    private func createDataSource(_ topNews: [MainNewsModel]) {
        dataSource = [:]
        let newsSortedByTime = topNews.sorted(by: { $0.date.compare($1.date) == .orderedDescending })
        for news in newsSortedByTime {
            if self.dataSource[news.source] == nil {
                self.dataSource[news.source] = [news]
            } else {
                self.dataSource[news.source]?.append(news)
            }
        }
    }
}
