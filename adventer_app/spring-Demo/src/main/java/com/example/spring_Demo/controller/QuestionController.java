package com.example.spring_Demo.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

@RestController
public class QuestionController {

    /* 
    @GetMapping("/get-question")
    public QuestionResponse getQuestion(@RequestParam String correctAnswer) {
        // 正解の選択肢と不正解の選択肢を設定
        List<String> options = Arrays.asList("ほし", "しかく", "まる", "さんかく");
        
        // 正解をランダムに配置
        Collections.shuffle(options);
        options.set(0, correctAnswer); // 最初の選択肢を正解にセット

        // 問題をランダムに選ぶ
        String questionContent = "この形は何ですか？";

        return new QuestionResponse(questionContent, options);
    }*/
}
