//
//  Chat.swift
//  gotrader
//
//  Created by Sydna Agnehs on 2016-11-28.
//  Copyright © 2016 Sydna Agnehs. All rights reserved.
//

import UIKit

class Chat {
    
    var chatLastUpdateTime: String
    var chatTitle: String
    var chatSubtitle: String
    
    init(chatLastUpdateTime: String, chatTitle: String, chatSubtitle: String) {
        self.chatTitle = chatTitle
        self.chatLastUpdateTime = chatLastUpdateTime
        self.chatSubtitle = chatSubtitle
    }
}
