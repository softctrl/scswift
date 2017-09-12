//
//  UIImage.swift
//  Pods
//
//  Created by Timoshenko on 04/07/17.
//
//

import Foundation
import CoreGraphics
//import SVGPath


extension UIImage {

    /// <#Description#>
    /// Based on:
    /// https://stackoverflow.com/questions/39451491/create-an-uiimage-from-uibezierpath-array-in-swift
    ///
    /// - Parameter paths: <#paths description#>
    /// - Returns: <#return value description#>
    public static func convertPathsToImage(paths: [UIBezierPath], _ imageWidth: CGFloat = 200, _ imageHeight: CGFloat  = 200) -> UIImage {

        let strokeColor:UIColor = UIColor.black
        
        // Make a graphics context
        UIGraphicsBeginImageContextWithOptions(CGSize(width: imageWidth, height: imageHeight), false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        
        context!.setStrokeColor(strokeColor.cgColor)
        
        for path in paths {
            path.stroke()
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
    }
    
}
