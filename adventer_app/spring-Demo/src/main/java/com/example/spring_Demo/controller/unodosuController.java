package com.example.spring_Demo.controller;


import java.util.ArrayList;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import com.example.spring_Demo.model.question;
import com.example.spring_Demo.model.AnswerRequest;
import com.example.spring_Demo.service.ProblemService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import javax.validation.Valid;
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
  public ResponseEntity<question> getRandomTextQuestion(@RequestParam String questiontype_id, HttpSession session) {

      List<String> solvedQuestions = (List<String>) session.getAttribute("solvedQuestions");
      if (solvedQuestions == null) {
          solvedQuestions = new ArrayList<>();
      }

      question randomQuestion = problemService.getRandomTextQuestion(questiontype_id, solvedQuestions);
      if (randomQuestion == null) {
          return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
      }

      solvedQuestions.add(randomQuestion.getQuestion_id());
      session.setAttribute("solvedQuestions", solvedQuestions);

      return ResponseEntity.ok(randomQuestion);
  }

  @PostMapping("/submit-answer")
  public ResponseEntity<String> submitAnswer(@Valid @RequestBody AnswerRequest request) {
      String questionId = request.getQuestionId();
      String selectedAnswer = request.getAnswer();

      String correctAnswer = getCorrectAnswerForQuestion(questionId);

      if (selectedAnswer.equals(correctAnswer)) {
          return ResponseEntity.status(HttpStatus.OK).body("correct");
      } else {
          return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("incorrect");
      }
  }

  /*private String getCorrectAnswerForQuestion(String questionId) {
      return problemService.getCorrectAnswerForQuestion(questionId);
  }*/
}