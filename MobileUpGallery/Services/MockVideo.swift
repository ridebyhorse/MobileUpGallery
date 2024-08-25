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
        456239090: "https://i.ytimg.com/vi/prtj7Kz3sMo/maxresdefault.jpg",
        456239089: "https://i.ytimg.com/vi/YwI0MJHg4V8/maxresdefault.jpg",
        456239088: "https://i.mycdn.me/getVideoPreview?id=2104081976006&idx=14&type=39&tkn=8Q_M5K9sGShD-yxRmxqYTbxRiUY&fn=vid_x",
        456239086: "https://i.ytimg.com/vi/FjTcwKWllqk/maxresdefault.jpg",
        456239084: "https://i.ytimg.com/vi/JiZzZXXsunw/maxresdefault.jpg",
        456239082: "https://i.ytimg.com/vi/IU309F3Vp0I/maxresdefault.jpg",
        456239081: "https://i.ytimg.com/vi/IcRHd0jzRfE/maxresdefault.jpg",
        456239079: "https://i.ytimg.com/vi/bhBQnxpjgUc/maxresdefault.jpg",
        456239080: "https://i.mycdn.me/getVideoPreview?id=1533239823057&idx=8&type=39&tkn=bvOuzCy0b67If4B9az2VYBbm6b4&fn=vid_x",
        456239078: "https://sun9-24.userapi.com/MxJi3H033PeChtTDf3KvQJPNc9e_pntjgrh5mw/qHYHk3zR8bw.jpg",
        456239077: "https://i.mycdn.me/getVideoPreview?id=1236475054738&idx=5&type=39&tkn=_zqxs-8jsPUVQOnFklGo0XkG5Qw&fn=vid_x",
        456239074: "https://sun9-60.userapi.com/uwm9toSZVQBfkLhofW2QnZfpojMmPAFMdEV-kg/uF4mm2KI07o.jpg",
        456239071: "https://i.ytimg.com/vi/jM-05-mBWKw/maxresdefault.jpg",
        456239066: "https://sun9-25.userapi.com/XccnKoPQSpRBOw3qzYVkqahzcM5wm6BxdYqRxg/tB47RxCfXQk.jpg",
        456239068: "https://sun29-2.userapi.com/dx2fdPll7AG9y-TH1Zq5m4v0fagoPUfUVLss9w/MRcR-JbWu_4.jpg",
        456239061: "https://sun9-56.userapi.com/c858532/v858532573/12c259/CjQpQci0xbQ.jpg",
        456239060: "https://sun9-37.userapi.com/c858020/v858020932/1667cc/EWncIK2ipLE.jpg",
        456239059: "https://i.ytimg.com/vi/RHlZghQWz_Y/maxresdefault.jpg",
        456239056: "https://sun9-25.userapi.com/c855020/v855020561/d9fdd/VL2o2uu0iMM.jpg",
        456239055: "https://sun9-74.userapi.com/c855620/v855620878/d85d3/JxqogfUxH5E.jpg",
        456239046: "https://sun9-72.userapi.com/c851416/v851416512/181862/ysdRuRI_i34.jpg",
        456239051: "https://sun9-57.userapi.com/c850136/v850136481/1b05d3/u361Oaag_3A.jpg"]
}
