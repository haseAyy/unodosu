package com.example.spring_Demo.controller;

import java.util.ArrayList;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import com.example.spring_Demo.model.question;  // モデルクラス "question" をインポート
import com.example.spring_Demo.service.ProblemService;  // サービスクラスをインポート
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.Map;  // リクエストボディをマップで受け取るために使用
import java.util.List;  // Listインターフェースを使用

@Controller
public class unodosuController {

  @Autowired
  private ProblemService problemService;

  // ホームページへのGETリクエストを処理
  @GetMapping("/")
  public String homePage(HttpSession session) {
      // セッションに保存されている過去の問題履歴をリセット
      session.removeAttribute("solvedQuestions"); 
      return "home"; // home.htmlを返してビューを表示
  }

  // ランダムなテキスト問題を取得する
  @SuppressWarnings("unchecked")
  @GetMapping(value = "/random-text-question", produces = "application/json;charset=UTF-8")
  public ResponseEntity<question> getRandomTextQuestion(@RequestParam String questiontype_id, HttpSession session) {

      // セッションから"solvedQuestions"のリストを取得
      List<String> solvedQuestions = (List<String>) session.getAttribute("solvedQuestions");
      if (solvedQuestions == null) {
          solvedQuestions = new ArrayList<>();  // 初回アクセス時は新しいリストを作成
      }

      // サービスクラスからランダムなテキスト問題を取得
      question randomQuestion = problemService.getRandomTextQuestion(questiontype_id, solvedQuestions);
      if (randomQuestion == null) {
          // 問題が存在しない場合はHTTPステータス204 (NO_CONTENT) を返す
          return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
      }

      // 取得した問題のIDを解いた問題リストに追加
      solvedQuestions.add(randomQuestion.getQuestion_id());
      session.setAttribute("solvedQuestions", solvedQuestions);  // セッションを更新

      // 問題をHTTPステータス200 (OK) とともに返却
      return ResponseEntity.ok(randomQuestion);
  }

  // 回答を受け付けるPOST
  @PostMapping("/submit-answer")
  public ResponseEntity<String> submitAnswer(@RequestBody Map<String, String> payload) {
      // リクエストボディから問題IDと回答内容を取得
      String questionId = payload.get("questionId");  // 出題された問題のID
      String selectedAnswerId = payload.get("answer"); // 選択されたanswerのID
  
      // コンソールに受け取った値を出力 (デバッグ用)
      System.out.println("Received questionId: " + questionId);
      System.out.println("Selected answerId: " + selectedAnswerId);
  
      // 出題された問題のIDと選択されたIDが一致している場合は「正解」、異なる場合は「不正解」としてレスポンスを返す
      if (questionId.equals(selectedAnswerId)) {
          return ResponseEntity.ok("correct");  // 正解の場合
      } else {
          return ResponseEntity.ok("incorrect");  // 不正解の場合
      }
  }
}