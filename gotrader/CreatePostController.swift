//
//  CreatePostControlller.swift
//  gotrader
//
//  Created by Sydna Agnehs on 2016-11-21.
//  Copyright © 2016 Sydna Agnehs. All rights reserved.
//

import UIKit

class CreatePostController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var selectImageView: UIImageView!
    @IBOutlet weak var createPostButton: UIButton!
    @IBOutlet weak var pokemonNameField: UITextField!
    @IBOutlet weak var CPField: UITextField!
    @IBOutlet weak var shortMessageField: UITextField!
    
    var pokemonList: [String] = ["Bulbasaur", "Ivysaur", "Venusaur", "Charmander", "Charmeleon", "Charizard", "Squirtle", "Wartortle", "Blastoise", "Caterpie", "Metapod", "Butterfree", "Weedle", "Kakuna", "Beedrill", "Pidgey", "Pidgeotto", "Pidgeot", "Rattata", "Raticate", "Spearow", "Fearow", "Ekans", "Arbok", "Pikachu", "Raichu", "Sandshrew", "Sandslash", "Nidoran (f)", "Nidorina", "Nidoqueen", "Nidoran (m)", "Nidorino", "Nidoking", "Clefairy", "Clefable", "Vulpix", "Ninetales", "Jigglypuff", "Wigglytuff", "Zubat", "Golbat", "Oddish", "Gloom", "Vileplume", "Paras", "Parasect", "Venonat", "Venomoth", "Diglett", "Dugtrio", "Meowth", "Persian", "Psyduck", "Golduck", "Mankey", "Primeape", "Growlithe", "Arcanine", "Poliwag", "Poliwhirl", "Poliwrath", "Abra", "Kadabra", "Alakazam", "Machop", "Machoke", "Machamp", "Bellsprout", "Weepinbell", "Victreebel", "Tentacool", "Tentacruel", "Geodude", "Graveler", "Golem", "Ponyta", "Rapidash", "Slowpoke", "Slowbro", "Magnemite", "Magneton", "Farfetch'd", "Doduo", "Dodrio", "Seel", "Dewgong", "Grimer", "Muk", "Shellder", "Cloyster", "Gastly", "Haunter", "Gengar", "Onix", "Drowzee", "Hypno", "Krabby", "Kingler", "Voltorb", "Electrode", "Exeggcute", "Exeggutor", "Cubone", "Marowak", "Hitmonlee", "Hitmonchan", "Lickitung", "Koffing", "Weezing", "Rhyhorn", "Rhydon", "Chansey", "Tangela", "Kangaskhan", "Horsea", "Seadra", "Goldeen", "Seaking", "Staryu", "Starmie", "Mr. Mime", "Scyther", "Jynx", "Electabuzz", "Magmar", "Pinsir", "Tauros", "Magikarp", "Gyarados", "Lapras", "Ditto", "Eevee", "Vaporeon", "Jolteon", "Flareon", "Porygon", "Omanyte", "Omastar", "Kabuto", "Kabutops", "Aerodactyl", "Snorlax", "Articuno", "Zapdos", "Moltres", "Dratini", "Dragonair", "Dragonite", "Mewtwo", "Mew"]
    
    var pokemonTeam: [String] = ["Mystic", "Valor", "Instinct"]
    var lat: Double = 0
    var lng: Double = 0
    var userID: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonNameField.delegate = self
        
        let pickerView = UIPickerView(frame: CGRectMake(0, view.frame.height*0.65, view.frame.width, view.frame.height-(view.frame.height*0.65)))
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = .whiteColor()
        pickerView.showsSelectionIndicator = true
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CreatePostController.dismissPickerView))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        pokemonNameField.inputView = pickerView
        pokemonNameField.inputAccessoryView = toolBar
        
        
        CPField.keyboardType = UIKeyboardType.NumberPad
        CPField.inputView?.backgroundColor = .whiteColor()
        
        toolBar.setItems([spaceButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        CPField.inputAccessoryView = toolBar
        
        shortMessageField.keyboardType = UIKeyboardType.Alphabet
        shortMessageField.inputView?.backgroundColor = .whiteColor()
        
        toolBar.setItems([spaceButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        shortMessageField.inputAccessoryView = toolBar
        
    }

    func dismissPickerView() {
        self.view.endEditing(true)
    }
    
    @IBAction func selectPhoto(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        selectImageView.contentMode = .ScaleAspectFit
        selectImageView.image = image
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return pokemonList.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pokemonList[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pokemonNameField.text = pokemonList[row]
    }

    @IBAction func backPressed(sender: AnyObject) {
        let firstViewController = self.storyboard!.instantiateViewControllerWithIdentifier("mainScreen") as! UITabBarController
        self.presentViewController(firstViewController, animated: true, completion: nil)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submit(sender: AnyObject) {
        createNewPost(userID)
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func createNewPost(userID: Int) {
        let inputPokemon: NSString = pokemonNameField.text!
        let go_id:Int = pokemonList.indexOf(inputPokemon as String)!
        let inputCP: Int = Int(CPField.text!)!
        let imageData: NSData = UIImagePNGRepresentation(selectImageView.image!)!
        
//        let strBase64:String = imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        let strBase64:String = imageData.base64EncodedStringWithOptions([])
        print(strBase64)
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://go-trader.mybluemix.net/api/v1/post/create_post")!)
        let json = [ "go_id": go_id,
                     "cp": inputCP,
                     "screenshot": "somescreenshot.png",
                     "location":
                        [
                            "lat": lat,
                            "lng": lng
                        ],
        ]
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
            request.HTTPMethod = "POST"
            request.setValue("3", forHTTPHeaderField: "user_id")
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = jsonData
        } catch {
            
        }
//        let postString = "go_id=\(userID)&pokemon=\(inputPokemon)&cp=\(inputCP)&screenshot=\(strBase64)"
//        request.HTTPBody = jsonData.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, response, error) in
            print(NSString(data: data!, encoding: NSUTF8StringEncoding)!)
        }
        task.resume()
        let firstViewController = self.storyboard!.instantiateViewControllerWithIdentifier("mainScreen") as! UITabBarController
        self.presentViewController(firstViewController, animated: true, completion: nil)
    }
    
      /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
