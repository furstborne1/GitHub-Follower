//
//  GFError.swift
//  GitHub Follower
//
//  Created by MARC on 4/19/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import Foundation

enum GFError: String, Error {
    case invalidRequestErrorMessage = "This user created an invalid request. please try again later."
    case checkInternetConnectionError = "Unable to complete your request. Please check your internet connection."
    case invalidResponseFromServer = "Invalid response from server. Please try again later."
    case invalidData = "The Data Recieved by the server was invalid. Please try again later."
}
