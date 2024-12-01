//
//  FetchTaskProtocol.swift
//  ManageTask
//
//  Created by Sourav Santra on 01/12/24.
//

import Foundation

protocol FetchTaskProtocol {
    func fetchAllTask() -> [TaskModelProtocol]
}
