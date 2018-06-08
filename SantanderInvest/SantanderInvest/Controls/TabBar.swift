//
//  TabBar.swift
//  SantanderInvest
//
//  Created by Bruno Villanova on 06/06/18.
//  Copyright © 2018 Santander. All rights reserved.
//

import UIKit

class TabBar: UITabBar {
  
  fileprivate var selectionIndicatorTopView: UIView?
  
  override var items: [UITabBarItem]? {
    didSet {
      positionItemsTitles()
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    configureItemsBackground()
  }
  
  fileprivate func setup() {
    selectionIndicatorTopView = UIView(frame: CGRect(x: 0, y: -2, width: self.frame.size.width, height: 2))
    selectionIndicatorTopView!.backgroundColor = Constants.colors.defaultRed
    self.layer.addSublayer(selectionIndicatorTopView!.layer)
    self.shadowImage = UIImage()
    self.backgroundImage = Constants.colors.defaultRed.image(size: CGSize(width: 1, height:1))
    positionItemsTitles()
  }
  
  fileprivate func positionItemsTitles() {
    self.items?.forEach {
      $0.titlePositionAdjustment = UIOffset(horizontal:0, vertical:-14);
    }
  }
  
  fileprivate func configureItemsBackground() {
    let numberOfItems = CGFloat(self.items!.count)
    let tabBarItemSize = CGSize(width: self.frame.width / numberOfItems, height: self.frame.height)
    self.selectionIndicatorImage = Constants.colors.darkRed.image(size: tabBarItemSize)
  }
  
  override var selectedItem: UITabBarItem? {
    didSet {
      if let selectedItem = selectedItem, let items = self.items, let selectionIndicatorTopView = selectionIndicatorTopView {
        let numberOfItems = CGFloat(self.items!.count)
        let tabBarItemSize = CGSize(width: self.frame.width / numberOfItems, height: self.frame.height)
        let index = CGFloat(items.index(of: selectedItem)!)
        let originX = index*tabBarItemSize.width
        selectionIndicatorTopView.frame = CGRect(x: originX, y: selectionIndicatorTopView.frame.origin.y, width: tabBarItemSize.width, height: tabBarItemSize.height)
      }
    }
  }
}
