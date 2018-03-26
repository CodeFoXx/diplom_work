//
//  TextDetectionContract.swift
//  CoreML_test
//
//  Created Осина П.М. on 20.03.18.
//  Copyright © 2018 Осина П.М.. All rights reserved.
//

import Foundation

protocol TextDetectionView: class {
    
}

protocol TextDetectionPresenter {
    func textFromTextDetectionVC(textArray: [String])
}

protocol TextDetectionRouter {
    func textFromTextDetectionVC(textArray: [String])
}
