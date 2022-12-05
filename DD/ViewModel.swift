//
//  ViewModel.swift
//  DD
//
//  Created by Ludvig Krantzén on 2022-12-05.
//

import Foundation
import Combine


class ViewModel: ObservableObject{
    @Published var dataArr: [TaskObject] = []
    private var manager = CoreDataManager.shared
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        getData()
        print(dataArr)
    }
    
    func getData(){
        manager.$savedTaskObjects
            .receive(on: DispatchQueue.main)
            .sink { data in
                self.manager.fetchTaskObjects()
                self.dataArr = data
            }.store(in: &cancellables)
    }
}
