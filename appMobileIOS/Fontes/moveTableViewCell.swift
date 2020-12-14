//
//  moveTableViewCell.swift
//  PokemonTeam
//
//  Created by Richard Gabriel on 02/05/17.
//  Copyright © 2017 Richard Gabriel. All rights reserved.
//

import UIKit

class moveTableViewCell: UITableViewCell {

    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var descricao: UILabel!
    @IBOutlet weak var tipo: UIImageView!
    @IBOutlet weak var categoria: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
