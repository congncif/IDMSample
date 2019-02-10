//
//  Animator.swift
//  IDMFoundation
//
//  Created by FOLY on 11/8/18.
//  Copyright © 2018 [iF] Solution. All rights reserved.
//

import Foundation
import UIKit

public protocol AnimatorProtocol: UIViewControllerAnimatedTransitioning {
    var isPresenting: Bool { get set }
}
