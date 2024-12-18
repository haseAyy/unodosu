package com.example.spring_Demo.controller;


import java.util.ArrayList;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import com.example.spring_Demo.model.UnodosuEntity;
import com.example.spring_Demo.service.ProblemService;
import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.ui.Model;

import java.util.List;


@Controller
public class unodosuController {

  @Autowired
  private ProblemService problemService;

  @GetMapping("/")
  public String homePage(HttpSession session) {
      session.removeAttribute("solvedQuestions"); // 履歴をリセット
      return "home"; // 例えば home.html を表示する
  }

  @SuppressWarnings("unchecked")
  @GetMapping(value = "/random-text-question", produces = "application/json;charset=UTF-8")
  public ResponseEntity<UnodosuEntity> getRandomTextQuestion(@RequestParam String questiontype_id, HttpSession session) {

     // セッションから解いた問題のリストを取得
    List<String> solvedQuestions = (List<String>) session.getAttribute("solvedQuestions");
    if (solvedQuestions == null) {
        solvedQuestions = new ArrayList<>();

    }

    // 新しい問題を取得（解いた問題を除外）
    UnodosuEntity randomQuestion = problemService.getRandomTextQuestion(questiontype_id, solvedQuestions);
    if (randomQuestion == null) {
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build(); // 問題が無ければ204レスポンス
    }

     // 解いた問題をセッションに追加
     solvedQuestions.add(randomQuestion.getQuestion_id());
     session.setAttribute("solvedQuestions", solvedQuestions);

    //正常なレスポンスを返す
    return ResponseEntity.ok(randomQuestion); // 問題をJSON形式で返す
}
          

  /*@PostMapping("/submit-answer")
  public String submitAnswer(@RequestParam String question_id, @RequestParam String answer, Model model) {
      // Long 型の question_id を String 型に変換
      //String questionIdStr = String.valueOf(question_id);

      // 問題を取得
      UnodosuEntity question = problemService.findQuestionById(question_id);

      // 正解の判定
      if (question.getQuestion_answer().equals(answer)) {
          // 正解の場合は正解画面にリダイレクト
          return "correct";
      } else {
          // 不正解の場合は不正解画面にリダイレクト
          return "incorrect";
      }
  }*/
}