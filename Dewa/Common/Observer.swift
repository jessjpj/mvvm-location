//
//  Observer.swift
//  Dewa
//
//  Created by Mac on 25/03/2022.
//

import Foundation

typealias Observer<T> = (T) -> Void
typealias ObserverVoid = () -> Void
