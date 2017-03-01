import UIKit
import SnapKit

class SegmentCell: UITableViewCell {

    let segment: UISegmentedControl = {
        let segmentControl = UISegmentedControl(frame: .zero)
        segmentControl.insertSegment(withTitle: "Watching", at: 0, animated: true)
        segmentControl.insertSegment(withTitle: "Movies", at: 1, animated: true)
        segmentControl.insertSegment(withTitle: "TV", at: 2, animated: true)
        
        segmentControl.setWidth(100, forSegmentAt: 0)
        segmentControl.setWidth(100, forSegmentAt: 1)
        segmentControl.setWidth(100, forSegmentAt: 2)
        
        segmentControl.tintColor = ColorPalette.white
        segmentControl.backgroundColor = ColorPalette.black
        segmentControl.selectedSegmentIndex = 0
        return segmentControl
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(segment)
        
        segment.snp.makeConstraints { (make) in
            make.centerXWithinMargins.equalTo(self)
            make.centerYWithinMargins.equalTo(self)
            make.height.equalTo(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
