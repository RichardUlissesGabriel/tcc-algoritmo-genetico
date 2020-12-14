//
//  listaPokemonTableViewCell.swift
//  PokemonTeam
//
//  Created by Richard Gabriel on 01/05/17.
//  Copyright © 2017 Richard Gabriel. All rights reserved.
//

import UIKit

class listaPokemonTableViewCell: UITableViewCell {
    

    @IBOutlet weak var nomePokemon: UILabel!
    @IBOutlet weak var imgPokemon: UIImageView!
    @IBOutlet weak var numDex: UILabel!
    @IBOutlet weak var tipo1: UIImageView!
    @IBOutlet weak var tipo2: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
