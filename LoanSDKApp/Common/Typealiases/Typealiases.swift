//
//  Typealiases.swift
//  PayLink
//
//  Created by Sreekar on 11/11/19.
//  Copyright © 2019 Santosh Gupta. All rights reserved.
//

import Foundation

public typealias EmptyCompletion = () -> Void
public typealias CompletionObject<T> = (_ response: T) -> Void
public typealias CompletionOptionalObject<T> = (_ response: T?) -> Void
public typealias CompletionResponse = (_ response: Result<Void, Error>) -> Void
public typealias completionBooleanObject<T> = (_ Bool: T?) -> Void

