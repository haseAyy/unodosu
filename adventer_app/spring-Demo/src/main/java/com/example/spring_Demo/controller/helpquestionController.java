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
    private HelpProblemService helpproblemService;

    // ランダムなテキスト問題を取得する
    @SuppressWarnings("unchecked")
    @GetMapping(value = "/random-text-questionhelp", produces = "application/json;charset=UTF-8")
    public ResponseEntity<question> getRandomTextQuestionTeme(@RequestParam String question_theme, HttpSession session) {

        // セッションから"solvedQuestions"のリストを取得
        List<String> solvedQuestions = (List<String>) session.getAttribute("solvedQuestions");
        Integer solvedCount = (Integer) session.getAttribute("solvedCount"); // 解答数を取得

        if (solvedQuestions == null) {
            solvedQuestions = new ArrayList<>(); // 初回アクセス時は新しいリストを作成
        }
        if (solvedCount == null) {
            solvedCount = 0; // 初回アクセス時は解答数を0に設定
        }

        // サービスクラスからランダムなテキスト問題を取得
        question randomQuestion = helpproblemService.getRandomTextQuestionHelp(question_theme, solvedQuestions);
        if (randomQuestion == null) {
            // 問題が存在しない場合はHTTPステータス204 (NO_CONTENT) を返す
            return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
        }

        // 取得した問題のIDを解いた問題リストに追加
        solvedQuestions.add(randomQuestion.getQuestion_id());
        solvedCount++; // 解答数をカウントアップ
        session.setAttribute("solvedQuestions", solvedQuestions); // セッションを更新
        session.setAttribute("solvedCount", solvedCount); // 解答数をセッションに保存

        // 解答数が5問以上なら結果画面に遷移
        if (solvedCount >= 5) {
            return ResponseEntity.status(HttpStatus.FOUND) // HTTP 302: Found (リダイレクト)
                    .header("Location", "/result-help") // 結果画面にリダイレクト
                    .build();
        }

        // 問題をHTTPステータス200 (OK) とともに返却
        return ResponseEntity.ok(randomQuestion);
    }

    

    // 回答を受け付けるPOST
    @PostMapping("/submit-answer-help")
    public ResponseEntity<Map<String, Object>> submitAnswerHelp(@RequestBody Map<String, String> payload, HttpSession session) {
        // リクエストボディから問題IDと回答内容を取得
        String questionId = payload.get("questionId");
        String selectedAnswerId = payload.get("answer");
        String selectedAnswerContent = payload.get("answerContent");

        // 判定処理
        boolean isCorrect = questionId.equals(selectedAnswerId);

        // 結果を格納するレスポンスマップを作成
        Map<String, Object> response = new HashMap<>();
        response.put("isCorrect", isCorrect);
        response.put("questionId", questionId);
        response.put("selectedAnswerId", selectedAnswerId);
        response.put("selectedAnswerContent", selectedAnswerContent);

        return ResponseEntity.ok(response);
    }

    // 結果画面を表示するためのエンドポイント
    @GetMapping("/result-help")
    public String resultPage(HttpSession session) {
        Integer solvedCount = (Integer) session.getAttribute("solvedCount");
        if (solvedCount != null && solvedCount >= 5) {
            return "result"; // 5問解いた場合、結果ページを表示
        }
        return "redirect:/"; // 5問解いていない場合はホームページにリダイレクト
    }

    


}
