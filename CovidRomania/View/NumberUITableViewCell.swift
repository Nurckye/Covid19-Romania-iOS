import UIKit
import SnapKit

class NumberUITableViewCell: UITableViewCell {
    var countyData: CountyData? {
        didSet {
            countyLabel.text = countyData?.county.capitalizingFirstLetter()
            guard let totalCounty = countyData?.totalCounty else {
                casesLabel.text = "Necunoscut"
                return
            }
            casesLabel.text = String(totalCounty)
            if totalCounty > 2000 {
                casesLabel.font = UIFont.boldSystemFont(ofSize: 20)
                casesLabel.textColor = UIColor(red: 0.571, green: 0.112, blue: 0.112, alpha: 1)
            }
        }
    }
    
    private var countyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()
    
    private var casesLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.171, green: 0.171, blue: 0.171, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(countyLabel)
        countyLabel.snp.makeConstraints { make in
            make.left.equalTo(self).offset(24)
            make.centerY.equalTo(self)
        }
        self.addSubview(casesLabel)
        casesLabel.snp.makeConstraints { make in
            make.right.equalTo(self).inset(24)
            make.centerY.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
