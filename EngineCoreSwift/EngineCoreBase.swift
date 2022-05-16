//
//  EngineCoreBase.swift
//  EngineCoreSwift
//
//  Created by Shravan Gudikadi on 5/12/22.
//

import Foundation
import UIKit
import EngineUIKit


public class EngineCoreBase: NSObject {
    
   public var delegate: CarouselViewDelegate?
   public var viewModel: EngineUIKit.FixedActionTileViewModel?
   public var segmentedControlDelegate: SegmentedTapDelegate?
    
    public override init() {}
    
    public func EngineButton(frame: CGRect?, title: String?, state: UIControl.State?, font: UIFont?, color: UIColor?) -> UIButton {
        return EngineUIKit.EngineButton(frame: frame, title: title, state: state, font: font, color: color)
    }
    
    public func FixedActionTileView() -> UIView {
        let view = EngineUIKit.FixedActionTileView()
        view.ViewModel = viewModel
        return view
    }
    
    public func ImageCarouselView(_ images: [UIImage?]) -> UIView {
        let view = EngineUIKit.ImageCarouselView(images)
        view.delegate = self
        return view
    }
    
    public func animatedPageControl(_ images: [UIImage?]) -> UIView {
        guard let pageView = EngineUIKit.PagingCollectionView().intantiateFromNib() else { return UIView() }
        pageView.configureView(images)
        return pageView
    }
    
    public func segmentedControlView(titles: [String], selectedIndex: Int, selectorView: UIView, selectorTextFont: UIFont, selectorTextColor: UIColor, selectorViewColor: UIColor, textFont: UIFont, textColor: UIColor, delegate: SegmentedTapDelegate) -> UIView {
        let view = EngineUIKit.CustomSegmentedControl()
        view.setButtonTitles(buttonTitles: titles)
        view.selectedIndex = selectedIndex
        view.selectorView = selectorView
        view.selectorTextFont = selectorTextFont
        view.selectorTextColor = selectorTextColor
        view.selectorViewColor = selectorViewColor
        view.textFont = textFont
        view.textColor = textColor
        view.delegate = self
        return view
    }
}


extension EngineCoreBase: EngineUIKit.ImageCarouselViewDelegate {
    public func imageCarouselView(_ imageCarouselView: ImageCarouselView, didShowImageAt index: Int) {
        self.delegate?.CarouselView(imageCarouselView, didShowImageAt: index)
    }
}

extension EngineCoreBase: EngineUIKit.CustomSegmentedControlDelegate  {
    
    public func change(to index: Int) {
        self.segmentedControlDelegate?.change(to: index)
    }
    
}



public protocol CarouselViewDelegate {
    func CarouselView(_ imageCarouselView: ImageCarouselView, didShowImageAt index: Int)
}

public protocol SegmentedTapDelegate {
    
    func change(to index:Int)
    
}
