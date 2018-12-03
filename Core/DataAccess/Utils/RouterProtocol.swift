//
//  RouterProtocol.swift
//  Board
//
//  Created by Benjamin Budet on 12/3/18.
//  Copyright © 2018 EpiMac. All rights reserved.
//

import Foundation
import Alamofire

protocol RouterProtocol {
    var method:     HTTPMethod      { get }
    var path:       String          { get }
    var headers:    HTTPHeaders     { get }
    var urlRequest: URLRequest      { get }
}
