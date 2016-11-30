//
//  Post.swift
//  gotrader
//
//  Created by Sydna Agnehs on 2016-11-28.
//  Copyright © 2016 Sydna Agnehs. All rights reserved.
//

import UIKit

class Post {
    
    
    var pokemonList: [String] = ["Bulbasaur", "Ivysaur", "Venusaur", "Charmander", "Charmeleon", "Charizard", "Squirtle", "Wartortle", "Blastoise", "Caterpie", "Metapod", "Butterfree", "Weedle", "Kakuna", "Beedrill", "Pidgey", "Pidgeotto", "Pidgeot", "Rattata", "Raticate", "Spearow", "Fearow", "Ekans", "Arbok", "Pikachu", "Raichu", "Sandshrew", "Sandslash", "Nidoran (f)", "Nidorina", "Nidoqueen", "Nidoran (m)", "Nidorino", "Nidoking", "Clefairy", "Clefable", "Vulpix", "Ninetales", "Jigglypuff", "Wigglytuff", "Zubat", "Golbat", "Oddish", "Gloom", "Vileplume", "Paras", "Parasect", "Venonat", "Venomoth", "Diglett", "Dugtrio", "Meowth", "Persian", "Psyduck", "Golduck", "Mankey", "Primeape", "Growlithe", "Arcanine", "Poliwag", "Poliwhirl", "Poliwrath", "Abra", "Kadabra", "Alakazam", "Machop", "Machoke", "Machamp", "Bellsprout", "Weepinbell", "Victreebel", "Tentacool", "Tentacruel", "Geodude", "Graveler", "Golem", "Ponyta", "Rapidash", "Slowpoke", "Slowbro", "Magnemite", "Magneton", "Farfetch'd", "Doduo", "Dodrio", "Seel", "Dewgong", "Grimer", "Muk", "Shellder", "Cloyster", "Gastly", "Haunter", "Gengar", "Onix", "Drowzee", "Hypno", "Krabby", "Kingler", "Voltorb", "Electrode", "Exeggcute", "Exeggutor", "Cubone", "Marowak", "Hitmonlee", "Hitmonchan", "Lickitung", "Koffing", "Weezing", "Rhyhorn", "Rhydon", "Chansey", "Tangela", "Kangaskhan", "Horsea", "Seadra", "Goldeen", "Seaking", "Staryu", "Starmie", "Mr. Mime", "Scyther", "Jynx", "Electabuzz", "Magmar", "Pinsir", "Tauros", "Magikarp", "Gyarados", "Lapras", "Ditto", "Eevee", "Vaporeon", "Jolteon", "Flareon", "Porygon", "Omanyte", "Omastar", "Kabuto", "Kabutops", "Aerodactyl", "Snorlax", "Articuno", "Zapdos", "Moltres", "Dratini", "Dragonair", "Dragonite", "Mewtwo", "Mew"]
    


    var lat: Double
    var lng: Double
    var post_id: Int
    var dist: Double
    var go_id: Int
    var cp: Int
    //var screenshot: UIImageView?
    var first_name: String
    var pokemon_name:String
    
    
    init(lat: Double, lng: Double, post_id: Int, dist: Double, go_id: Int, cp: Int, screenshot: String, first_name: String) {
        self.lat = lat
        self.lng = lat
        self.post_id = post_id
        self.dist = dist
        self.go_id = go_id
        self.cp = cp
        self.first_name = first_name
        self.pokemon_name = pokemonList[go_id]
        
        //let dataDecoded:NSData = NSData(base64EncodedString: screenshot, options: NSDataBase64DecodingOptions(rawValue: 0))!
        //let decodedimage:UIImage = UIImage(data: dataDecoded)!
        //self.screenshot!.image = decodedimage
        
    }
}
