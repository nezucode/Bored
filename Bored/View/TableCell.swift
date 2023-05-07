//
//  TableCell.swift
//  Bored
//
//  Created by Intan on 03/04/23.
//

import UIKit

class TableCell: UITableViewCell {
    
    var category: Category? {
        didSet {
            guard let unwrappedCategory = category else { return }
            imageCellView.image = UIImage(named: unwrappedCategory.imageCell)
            categoryLbl.text = unwrappedCategory.categoryLabel
            imageChevron.image = UIImage(named: unwrappedCategory.imageChev)
        }
    }
    
    lazy var cellView: UIView = {
        let view = UIView(frame: CGRect(x: 10, y: 6, width: self.frame.width - 20, height: 80))
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.systemGray4.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.shadowRadius = 5.0
        view.layer.shouldRasterize = true
        return view
    }()
    
    lazy var imageCellView: UIImageView = {
        let icv = UIImageView(frame: CGRect(x: 20, y: 10, width: 56, height: 56))
        icv.contentMode = .scaleAspectFill
        return icv
    }()
    
    lazy var imageChevron: UIImageView = {
        let icv = UIImageView(frame: CGRect(x: 264, y: 30, width: 24, height: 24))
        icv.contentMode = .scaleAspectFill
        return icv
    }()
    
    lazy var categoryLbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 116, y: 24, width: cellView.frame.width - 116, height: 30))
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        addSubview(cellView)
        cellView.addSubview(imageCellView)
        cellView.addSubview(categoryLbl)
        cellView.addSubview(imageChevron)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
