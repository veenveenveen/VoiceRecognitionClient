//
//  AccessoryCell.swift
//  VGClient
//
//  Created by jie on 2017/3/13.
//  Copyright © 2017年 HTIOT.Inc. All rights reserved.
//

import UIKit

/// cell包含三个按钮，collectionview可以注册为代理以接受点击事件
/// 考虑到内存管理，使用代理还是比较安全的；

protocol AccessoryCellDelegate: class {
    
    func cell(_ cell: AccessoryCell, isTapped action: AccessoryAction)
}


class AccessoryCell: UICollectionViewCell {
    
    @IBOutlet weak var container: RectCornerView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    /// 状态信息
    
    @IBOutlet weak var infoLabel: UILabel!
    
    /// 右下角图标表示可点击
    
    @IBOutlet weak var actionIndicatorImageView: UIImageView!
    
    /// 动作按钮安放在一个水平stack中
    
    @IBOutlet weak var actionStack: UIStackView!
    
    /// 三个动作按钮
    
    @IBOutlet weak var openButton: UIButton!
    
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var closeButton: UIButton!
        
    
    /// collectionview可以注册为代理以接受点击事件
    
    weak var delegate: AccessoryCellDelegate?
    
    /// 三个动作按钮的点击事件
    
    @IBAction func didTapOpenButton(_ sender: Any) {
        delegate?.cell(self, isTapped: .open)

    }
    @IBAction func didTapCloseButton(_ sender: Any) {
        delegate?.cell(self, isTapped: .close)

    }
    @IBAction func didTapStopButton(_ sender: Any) {
        delegate?.cell(self, isTapped: .stop)

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        /// Blur effect
        
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        backgroundView = blurEffectView
        backgroundView?.layer.cornerRadius = container.cornerRadiusX
        backgroundView?.layer.masksToBounds = true
        
    }
    
    func update(data: AccessoryData, delegate: AccessoryCellDelegate?) {
        
        titleLabel.text = data.name
        
        imageView.image = data.image
        
        infoLabel.text = data.state.textDescription
    
        /// 设置模糊效果的显示和隐藏
        
        if data.state == .opened {
            
            container.setFillColor(color: UIColor(white: 1, alpha: 1))
            
        } else {
            
            container.setFillColor(color: UIColor(white: 1, alpha: 0.5))
        }
        
        ///
        
        if data.type.isSingleActionTypes {
            
            /// 显示点击图标
            
            actionIndicatorImageView.isHidden = false
            
            /// 无操作按钮
            
            actionStack.isHidden = true
            
            /// 移除代理
            
            self.delegate = nil
            
        } else {
            
            /// 隐藏点击图标

            actionIndicatorImageView.isHidden = true
            
            /// 有三个操作按钮
            
            actionStack.isHidden = false
            
            /// 设置代理
            
            self.delegate = delegate
        }
    }
    
}