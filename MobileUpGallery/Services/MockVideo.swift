//
//  MockVideo.swift
//  MobileUpGallery
//
//  Created by Мария Нестерова on 24.08.2024.
//

import Foundation

struct MockVideo {
    static func getMockVideo() -> [Video] {
        var videos = [Video]()
        for (id, title) in videoIds {
            let video = Video(id: id, image: [VideoPreview(url: previews[id] ?? "")], title: title, player: videoUrl + String(id))
            videos.append(video)
        }
        
        return videos
    }
    private static let videoUrl = "https://vk.com/video_ext.php?oid=-128666765&hash=e037414127166efe&__ref=vk.api&api_hash=1677682946870d1f6fa590a9b323_HAZDCNJWG42DA&id="
    
    private static let videoIds = [456239094: "Голубой огонек в MobileUp", 456239090: "День людей в MobileUp – вечеринка во времена сухого закона", 456239089: "Добро пожаловать в MobileUp", 456239088: "Новый год – Народы мира", 456239086: "12 лет MobileUp", 456239084: "MobileUp Истории. Павел Александров: Про яхты, велосипед и другие активности", 456239082: "Кейс Самоката для P1. Как мы сделали концепцию программы лояльности для фудтеха и победили (опять!)", 456239081: "MobileUp. Снаружи и внутри", 456239079: "CoinRoad. Как мы сделали инновационное приложение для мониторинга курсов криптовалют", 456239080: "ПОМОЩЬ и MobileUp", 456239078: "MobileUp Истории. Даша Куркина: Про жизнь, путешествия по России и кремли", 456239077: "День людей", 456239074: "MobileUp – 2021. Будет новым", 456239071: "Кейс ANNA Money для P1. Как мы создали Payroll-концепт для финтех-стартапа из UK (и победили!)", 456239066: "Welcome to the HellUp 🔪🩸🪓", 456239068: "«Аэростат». Кто делает мобильное приложение для программы Бориса Гребенщикова", 456239061: "MobileUp Истории - Илья Буржинский", 456239060: "MobileUp на интервью у ХантИТ", 456239059: "MobileUp на Эхе Петербурга", 456239056: "MobileUp 10 лет. Документальное кино", 456239055: "MobileUp x Shvetsov", 456239046: "С днем рождения, Серж!", 456239051: "MobileUp - Искусство Вслух"]
    
    private static let previews = [
        456239094: "https://i.mycdn.me/getVideoPreview?id=3530607954683&idx=2&type=39&tkn=4UU6fAsZHVeZDNgJ83GRmj_Jfgg&fn=vid_x",
        456239090: "https://i.ytimg.com/vi/prtj7Kz3sMo/maxresdefault.jpg?sqp\\u003d-oaymwEmCIAKENAF8quKqQMa8AEB-AH-CYAC0AWKAgwIABABGH8gSSgqMA8\\u003d\\u0026rs\\u003dAOn4CLBfb6tMWCGZ6HMA5GHXNv1PXvj9pQ",
        456239089: "https://i.ytimg.com/vi/YwI0MJHg4V8/maxresdefault.jpg?sqp\\u003d-oaymwEmCIAKENAF8quKqQMa8AEB-AH-HYAC8BCKAgwIABABGGUgTChEMA8\\u003d\\u0026rs\\u003dAOn4CLCadv4-ALUVyCFfXFZbLLBia19evA",
        456239088: "",
        456239086: "",
        456239084: "",
        456239082: "",
        456239081: "",
        456239079: "",
        456239080: "",
        456239078: "",
        456239077: "",
        456239074: "",
        456239071: "",
        456239066: "",
        456239068: "",
        456239061: "",
        456239060: "",
        456239059: "",
        456239056: "",
        456239055: "",
        456239046: "",
        456239051: ""]
}
