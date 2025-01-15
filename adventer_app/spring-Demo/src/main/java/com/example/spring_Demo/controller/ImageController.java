package com.example.spring_Demo.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.spring_Demo.model.question;

@Controller
@RequestMapping("/api") //help不正解のモーション表示
public class ImageController {

    @GetMapping("/getGifByAnswer")
    public ResponseEntity<String> getGifByAnswer(@RequestParam String message, @RequestParam String selectedAnswer,@RequestParam String questionId ) {
        // メッセージと選択した答えに基づいてGIFのURLを決定
        String gifUrl = getGifUrl(message, selectedAnswer, questionId);

        if (gifUrl != null) {
            return ResponseEntity.ok(gifUrl);  // GIF URLを返す
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("GIF not found");
        }
    }

    private String getGifUrl(String message, String selectedAnswer, String questionId) {
        // おふろとスポンジの場合、AWS S3のURLを返す
        if ("おふろ".equals(message)) {

            if ("MS157".equals(questionId) && "スポンジ".equals(selectedAnswer)) {
                return "https://imageunodosu.s3.us-east-1.amazonaws.com/helpBath/gif.gif";
            }

        } else if ("ベッド".equals(message)) {
            // ベッドの条件を追加する場所
        }

        // 他の条件に基づくURLも追加できます
        return null;  // 見つからなかった場合はnullを返す
    }
}
