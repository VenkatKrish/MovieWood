//
//  ZTMovieCustomTableViewCell.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 10/10/21.
//

import UIKit

class ZTMovieCustomTableViewCell: UITableViewCell {
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieCategory: UILabel!
    @IBOutlet weak var imgVwThumbnail: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func loadMovieDetails(data:Movies? = nil, indexPath:IndexPath){
        if let dataVal = data{
            var movieCategory = ""
            if let stringArray = data?.movieGenres?.map({ ($0.genre?.genreName ?? "")}){
                movieCategory = stringArray.joined(separator: ", ")
            }
            if movieCategory.count == 0{
                self.lblMovieCategory.isHidden = true
            }else{
                self.lblMovieCategory.isHidden = false
            }
            self.lblMovieCategory.text = movieCategory
            self.lblMovieTitle.text = dataVal.movieName ?? ""
            Helper.shared.loadImage(url: dataVal.image ?? "", imageView: self.imgVwThumbnail)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
