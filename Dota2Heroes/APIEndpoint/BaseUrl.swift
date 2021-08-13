//
//  BaseUrl.swift
//  Dota2Heroes
//
//  Created by DenisTirta on 12/08/21.
//

import Foundation

#if DEBUG
    var BaseURL     = "https://api.opendota.com"
    var BaseImg     = "https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/social/"
#else
    var BaseURL     = "https://api.opendota.com"
    var BaseImg     = "https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/social/"
#endif
