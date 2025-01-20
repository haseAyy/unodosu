package com.example.spring_Demo.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import com.example.spring_Demo.model.question;

@Controller
@RequestMapping("/api") //help不正解のモーション表示
public class ImageController {

     // Loggerのインスタンスを作成
     private static final Logger log = LoggerFactory.getLogger(ImageController.class);

    @GetMapping("/getGifByAnswer")
    public ResponseEntity<String> getGifByAnswer(@RequestParam String message, @RequestParam String selectedAnswer, @RequestParam String questionId) {
        // メッセージと選択した答えに基づいてGIFのURLを決定
        String gifUrl = getGifUrl(message, selectedAnswer, questionId);

        if (gifUrl != null) {
            return ResponseEntity.ok(gifUrl);  // GIF URLを返す
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("GIF not found");
        }
    }

    private String getGifUrl(String message, String selectedAnswer, String questionId) {
        // ベッド関連のGIF
        if ("ベッド".equals(message)) {
            switch (questionId) {
                case "MS501": //ベッドのうえにようふく
                    if ("たたむ".equals(selectedAnswer)) {
                        return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/youhukuhatatande.gif";
                    }
                    else if ("やぶる".equals(selectedAnswer)) {
                        return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/hondanawahonwosimautokorodayo.gif";
                    }else{
                        //ようふくはたたもう！
                        return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/youhukuhatatande.gif";
                    }
                case "MS502": //ベッドのうえにぬりぐるみ
                    if ("ならべる".equals(selectedAnswer)) {
                        return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/bednuiguruminaraberu.gif";
                    }else if ("たなにしまう".equals(selectedAnswer)) {
                        return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/hondanawahonwosimautokorodayo.gif";
                    }else{
                        return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/bednuiguruminaraberu.gif";
                    }
                case "MS503"://べっどのまわりにみず
                    if ("たおるでふく".equals(selectedAnswer)) {
                        return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/taoruwotukattekireinisiyou.gif";
                    }else if ("たなにしまう".equals(selectedAnswer)) {
                        return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/hondanawahonwosimautokorodayo.gif";
                    }else if ("そのままにする".equals(selectedAnswer)) {
                        return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/mizudesuberu.gif";
                    }else{
                        return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/taoruwotukattekireinisiyou.gif";
                    }
                
                case "MS504": //べっどのうえにくつ
                    if ("げんかんにもどす".equals(selectedAnswer)) {
                        return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/kutuhakutubakoni.gif";
                      
                    }else if("はく".equals(selectedAnswer)){
                        return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/bednouegayogoretyauyo.gif";
                    }else{
                        return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/bednouegayogoretyauyo.gif";
                    }
                case "MS505":
                    if ("おもちゃをしまう".equals(selectedAnswer)) {
                        return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/omotyahaomotyabakoni.gif";
                    }else if ("たなにしまう".equals(selectedAnswer)) {
                        return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/hondanawahonwosimautokorodayo.gif";
                    }else if ("そのままにする".equals(selectedAnswer)) {
                        return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/omotyanitumaduku.gif";
                    }
                    break;
                case "MS506":
                    if ("たなにしまう".equals(selectedAnswer)) {
                        return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/hondanawahonwosimautokorodayo.gif";
                    }else{
                        return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/hondanawahonwosimautokorodayo.gif";
                    }
                    case "MS507":
                    if ("かたづける".equals(selectedAnswer)) {
                        return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/omotyahaomotyabakoni.gif";
                    }else if ("たなにしまう".equals(selectedAnswer)) {
                        return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/hondanawahonwosimautokorodayo.gif";
                    }else{
                        return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/bedhanemurutokorotdayo.gif";
                    }
                    case "MS508":
                    if ("ごみいれにいれる".equals(selectedAnswer)) {
                        return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/gomihagomibakonimodosou.gif";
                    }else if ("たなにしまう".equals(selectedAnswer)) {
                        return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/hondanawahonwosimautokorodayo.gif";
                    }
                    break;
                    case "MS509":
                    if ("たべない".equals(selectedAnswer)) {
                        return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/omotyahaomotyabako.gif";
                    }else{
                        return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/bedhanemurutokorotdayo.gif";
                    }

                    case "MS510":
                    if ("ほうきではわく".equals(selectedAnswer)) {
                        return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/houkiwotukattekirenisiyou.gif";
                    }else if ("たなにしまう".equals(selectedAnswer)) {
                        return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/hondanawahonwosimautokorodayo.gif";
                    }else{
                        return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/houkiwotukattekirenisiyou.gif";
                    }

                // 他のベッドに関する条件も追加
                default:
                    break;
            }
        }

        // 他のテーマや選択肢に対する処理
        if ("おふろ".equals(message) && "おもちゃをしまう".equals(selectedAnswer)) {
            return "https://imageunodosu.s3.us-east-1.amazonaws.com/HelpBed/omotyahaomotyabako.gif";
        }

        if ("おふろ".equals(message) && "ふとんをのばす".equals(selectedAnswer)) {
            return "https://imageunodosu.s3.us-east-1.amazonaws.com/helpBath/bed1.gif";
        }
        // ログ出力
        log.info("Received message: {}, selectedAnswer: {}, questionId: {}", message, selectedAnswer, questionId);

        return null;
    }


}
