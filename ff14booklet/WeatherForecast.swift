//
//  WeatherForecast.swift
//  ff14booklet
//
//  Created by tomohiro-moro on 9/14/14.
//  Copyright (c) 2014 slightair. All rights reserved.
//

import Foundation

enum Weather: Int {
    case 不明
    case 快晴
    case 晴れ
    case 曇り
    case 霧
    case 風
    case 暴風
    case 雨
    case 暴雨
    case 雷
    case 雷雨
    case 砂塵
    case 砂嵐
    case 熱波
    case 灼熱波
    case 雪
    case 吹雪
    case オーロラ
    case 妖霧
    case 闇

    func imageURL() -> NSURL? {
        switch self {
        case .不明:
            return nil
        default:
            return NSURL(string: String(format: "http://ff14angler.com/img/w%03d.png", rawValue))
        }
    }

    func title() -> String {
        switch self {
        case .不明: return "不明"
        case .快晴: return "快晴"
        case .晴れ: return "晴れ"
        case .曇り: return "曇り"
        case .霧: return "霧"
        case .風: return "風"
        case .暴風: return "暴風"
        case .雨: return "雨"
        case .暴雨: return "暴雨"
        case .雷: return "雷"
        case .雷雨: return "雷雨"
        case .砂塵: return "砂塵"
        case .砂嵐: return "砂嵐"
        case .熱波: return "熱波"
        case .灼熱波: return "灼熱波"
        case .雪: return "雪"
        case .吹雪: return "吹雪"
        case .オーロラ: return "オーロラ"
        case .妖霧: return "妖霧"
        case .闇: return "闇"
        }
    }
}

enum Location: Int {
    case リムサ・ロミンサ = 1
    case 中央ラノシア
    case 低地ラノシア
    case 東ラノシア
    case 西ラノシア
    case 高地ラノシア
    case 外地ラノシア
    case ウルヴズジェイル係船場
    case ミスト・ヴィレッジ
    case グリダニア
    case 黒衣森：中央森林
    case 黒衣森：東部森林
    case 黒衣森：南部森林
    case 黒衣森：北部森林
    case ラベンダーベッド
    case ウルダハ
    case 西ザナラーン
    case 中央ザナラーン
    case 東ザナラーン
    case 南ザナラーン
    case 北ザナラーン
    case ゴブレットビュート
    case クルザス中央高地
    case モードゥナ

    func title() -> String {
        switch self {
        case .リムサ・ロミンサ: return "リムサ・ロミンサ"
        case .中央ラノシア: return "中央ラノシア"
        case .低地ラノシア: return "低地ラノシア"
        case .東ラノシア: return "東ラノシア"
        case .西ラノシア: return "西ラノシア"
        case .高地ラノシア: return "高地ラノシア"
        case .外地ラノシア: return "外地ラノシア"
        case .ウルヴズジェイル係船場: return "ウルヴズジェイル係船場"
        case .ミスト・ヴィレッジ: return "ミスト・ヴィレッジ"
        case .グリダニア: return "グリダニア"
        case .黒衣森：中央森林: return "黒衣森：中央森林"
        case .黒衣森：東部森林: return "黒衣森：東部森林"
        case .黒衣森：南部森林: return "黒衣森：南部森林"
        case .黒衣森：北部森林: return "黒衣森：北部森林"
        case .ラベンダーベッド: return "ラベンダーベッド"
        case .ウルダハ: return "ウルダハ"
        case .西ザナラーン: return "西ザナラーン"
        case .中央ザナラーン: return "中央ザナラーン"
        case .東ザナラーン: return "東ザナラーン"
        case .南ザナラーン: return "南ザナラーン"
        case .北ザナラーン: return "北ザナラーン"
        case .ゴブレットビュート: return "ゴブレットビュート"
        case .クルザス中央高地: return "クルザス中央高地"
        case .モードゥナ: return "モードゥナ"
        }
    }

    static let allValues = [
        リムサ・ロミンサ,
        中央ラノシア,
        低地ラノシア,
        東ラノシア,
        西ラノシア,
        高地ラノシア,
        外地ラノシア,
        ウルヴズジェイル係船場,
        ミスト・ヴィレッジ,
        グリダニア,
        黒衣森：中央森林,
        黒衣森：東部森林,
        黒衣森：南部森林,
        黒衣森：北部森林,
        ラベンダーベッド,
        ウルダハ,
        西ザナラーン,
        中央ザナラーン,
        東ザナラーン,
        南ザナラーン,
        北ザナラーン,
        ゴブレットビュート,
        クルザス中央高地,
        モードゥナ,
    ]
}

struct WeatherForecastLocation {
    var location: Location
    var forecasts: [Weather]
}

struct WeatherForecast {
    var date: String
    var locations: [WeatherForecastLocation]
}

