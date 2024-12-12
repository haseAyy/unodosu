package com.example.spring_Demo.controller;


import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.example.spring_Demo.model.unodosuEntity;
import com.example.spring_Demo.service.ProblemService;

import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;

import java.util.List;


@Controller
public class unodosuController {

  @Autowired
  private ProblemService problemservice;

    @GetMapping("/random-text-question")
    public String getRandomTextQuestion(@RequestParam String theme, Model model, HttpSession session) {

        // セッションから解いた問題のリストを取得
        List<String> solvedQuestions = (List<String>) session.getAttribute("solvedQuestions");
        if (solvedQuestions == null) {
            solvedQuestions = new ArrayList<>();
        }

        // 新しい問題を取得（解いた問題を除外）
        unodosuEntity randomQuestion = problemservice.getRandomTextQuestion(theme, solvedQuestions);
        if (randomQuestion == null) {
            model.addAttribute("message", "すべての問題を解き終えました！");
            return "no_more_questions";
        }

        // 解いた問題をセッションに追加
        solvedQuestions.add(randomQuestion.getQuestion_id());
        session.setAttribute("solvedQuestions", solvedQuestions);

        // 選択肢を生成
        List<String> options = problemservice.getAnswerOptions(randomQuestion.getQuestion_id(), theme);
        model.addAttribute("question", randomQuestion);
        model.addAttribute("options", options);

        return "question"; // 表示するHTMLテンプレート名
    }
}