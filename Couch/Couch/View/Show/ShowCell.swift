import UIKit

final class ShowCell: UITableViewCell {
    
    var showView = ShowView(frame: .zero)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let frame = CGRect(x: 0, y: 0, width: bounds.width, height: 100)
        showView.frame = frame
        
        contentView.addSubview(showView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(show: Show) {
        showView.titleLabel.text = show.title ?? ""
        if let year = show.year {
            showView.yearLabel.text = "\(year)"
        }
        
        ImageManager().download(with: show.imdb, imageView: showView.banner)
    }
}
