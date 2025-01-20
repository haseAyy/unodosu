package com.example.spring_Demo.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.spring_Demo.model.question;
import com.example.spring_Demo.service.HelpProblemService;

import jakarta.servlet.http.HttpSession;

@Controller // お手伝いモード　お片付け編
public class helpquestionController {

    @Autowired
    private HelpProblemService helpProblemService;

    // ランダムなテキスト問題を取得する
@GetMapping(value = "/random-text-questionhelp", produces = "application/json;charset=UTF-8")
public ResponseEntity<question> getRandomTextQuestionHelp(@RequestParam String question_theme, HttpSession session) {
    // セッションから"solvedQuestions"のリストを取得
    List<String> solvedQuestions = (List<String>) session.getAttribute("solvedQuestions");
    Integer solvedCount = (Integer) session.getAttribute("solvedCount");

    if (solvedQuestions == null) {
        solvedQuestions = new ArrayList<>(); // 初回アクセス時は新しいリストを作成
    }
    if (solvedCount == null) {
        solvedCount = 0; // 初回アクセス時は解答数を0に設定
    }

    // サービスクラスから未解答の問題を取得
    question randomQuestion = helpProblemService.getRandomTextQuestionHelp(question_theme, solvedQuestions);
    if (randomQuestion == null) {
        // 問題が存在しない場合はHTTPステータス204 (NO_CONTENT) を返す
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

    // 取得した問題のIDを解いた問題リストに追加
    solvedQuestions.add(randomQuestion.getQuestion_id());
    solvedCount++; // 解答数をカウントアップ
    session.setAttribute("solvedQuestions", solvedQuestions); // セッションを更新
    session.setAttribute("solvedCount", solvedCount); // 解答数をセッションに保存

    // 解答数が10問以上なら結果画面に遷移
    if (solvedCount >= 11) {
        return ResponseEntity.status(HttpStatus.FOUND) // HTTP 302: Found (リダイレクト)
                .header("Location", "/result-help") // 結果画面にリダイレクト
                .build();
    }

    // 未解答の問題をHTTPステータス200 (OK) とともに返却
    return ResponseEntity.ok(randomQuestion);
    }
    }
